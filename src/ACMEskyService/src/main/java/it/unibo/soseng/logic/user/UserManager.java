package it.unibo.soseng.logic.user;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.security.enterprise.SecurityContext;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.cdi.annotation.ProcessVariable;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;

import it.unibo.soseng.gateway.user.dto.UserDeleteDTO;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.user.dto.UserDTO;
import it.unibo.soseng.gateway.user.dto.UserSignUpDTO;
import it.unibo.soseng.gateway.user.dto.UserUpdateDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.OfferNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.DomainEntity;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.User;
import it.unibo.soseng.utils.Errors;

import static it.unibo.soseng.security.Constants.USER;
import static it.unibo.soseng.camunda.utils.Events.PAYMENT_REQUEST;
import static it.unibo.soseng.camunda.utils.Events.PAY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.BUSINESS_KEY;
import static it.unibo.soseng.camunda.utils.ProcessVariables.ERRORS_IN_PAYMENT_REQ;
import static it.unibo.soseng.camunda.utils.ProcessVariables.IS_OFFER_EXPIRED;
import static it.unibo.soseng.camunda.utils.ProcessVariables.IS_VALID_TOKEN;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER_REQUEST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.OFFER_TOKEN;

import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

@Stateless
public class UserManager {
    private final static Logger LOGGER = Logger.getLogger(UserManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private SecurityContext securityContext;

    @Inject
    private ProcessState processState;

    //TODO: controllare che non ci siano altri processi attivi
    // Start Camunda process
    public void startConfirmOffer(UserOfferDTO request, AsyncResponse response, UriInfo uriInfo) {
        LOGGER.info("startConfirmOffer");
        String email = securityContext.getCallerPrincipal().getName();
        String token = request.getToken();

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put(USER_OFFER_REQUEST, request);
        processVariables.put(OFFER_TOKEN, token);
        processVariables.put(USERNAME, email);
        processVariables.put(BUSINESS_KEY, email+PROCESS_CONFIRM_BUY_OFFER);
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE, response);

        
        // Start the process instance
        // TODO Iniziare processo con messaggio se si puo
        runtimeService.createProcessInstanceByKey(PAY_OFFER)
                    .businessKey(email+PROCESS_CONFIRM_BUY_OFFER)
                    .setVariables(processVariables)
                    .executeWithVariablesInReturn();
    }  
    
    public Response handleConfirmUserFlight(String token, String email, UserOfferDTO offer, DelegateExecution execution) throws OfferNotFoundException{
        // Control token
        execution.setVariable(IS_VALID_TOKEN, true);               
        execution.setVariable(IS_OFFER_EXPIRED, false);               

        if (token == null || token == "") {
            execution.setVariable(IS_VALID_TOKEN, false);               
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
            .entity(Errors.INVALID_TOKEN)
            .build();
        }
        GeneratedOffer offerToReturn;

        try {
            offerToReturn = databaseManager.getOfferByToken(token, email);

        } catch (OfferNotFoundException e) {
            execution.setVariable(IS_VALID_TOKEN, false);               
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
            .entity(Errors.INVALID_TOKEN)
            .build();
        }
        
        OffsetDateTime now = OffsetDateTime.now();
        if (offerToReturn.getExpireDate().compareTo(now) < 0) {
            execution.setVariable(IS_OFFER_EXPIRED, true);  
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                            .entity(Errors.OFFER_EXPIRED)
                            .build();
        }
        execution.setVariable(USER_OFFER, offerToReturn);
        return Response.status(Response.Status.OK.getStatusCode())
        .build();
    }

    public void createUser(UserSignUpDTO request) throws UserAlreadyInException {
        User user = new User();
        user.setProntogramUsername(request.getProntogramUsername());
        user.setEmail(request.getEmail());
        user.setName(request.getName());
        user.setSurname(request.getSurname());
        DomainEntity entity = new DomainEntity();
        entity.setUsername(request.getEmail());
        entity.setPassword(request.getPassword());
        entity.setUsername(request.getEmail());
        entity.setRole(USER);
        entity.setSalt("aaaa"); //TODO
        user.setEntity(entity);
        
        databaseManager.createUser(user);
    }

  
    public UserDTO getUser() throws UserNotFoundException{
        String email = securityContext.getCallerPrincipal().getName();
        User user = databaseManager.getUser(email);
        UserDTO response = new UserDTO();
        response.setEmail(user.getEmail());
        response.setPassword(user.getEntity().getPassword());
        response.setProntogramUsername(user.getProntogramUsername());
        return response;

    }
    
    public UserDTO updateUser(UserUpdateDTO request) throws InvalidCredentialsException, UserNotFoundException {
        String name = securityContext.getCallerPrincipal().getName();
        if(!name.equals(request.getEmail()))
            throw new InvalidCredentialsException();

        User user = databaseManager.getUser(name);

        if(!user.getEntity().getPassword().equals(request.getPassword()))
            throw new InvalidCredentialsException();
        if(request.getNewPassword() != null)
            user.getEntity().setPassword(request.getNewPassword());
        if(request.getNewProntogramUsername() != null)
            user.setProntogramUsername(request.getNewProntogramUsername());
        
        databaseManager.updateUser(user);
        UserDTO response = new UserDTO();
        response.setEmail(user.getEmail());
        response.setPassword(user.getEntity().getPassword());
        response.setProntogramUsername(user.getProntogramUsername());
        return response;
    }

    public void deleteUser(UserDeleteDTO request) throws InvalidCredentialsException, 
                                                                PersistenceException, UserNotFoundException {
        String name = securityContext.getCallerPrincipal().getName();
        if(!name.equals(request.getEmail()))
            throw new InvalidCredentialsException();

        User user = databaseManager.getUser(name);

        if(!user.getEntity().getPassword().equals(request.getPassword()))
            throw new InvalidCredentialsException();

        
        databaseManager.removeUser(user);
    }

    public void startPaymentRequest(AsyncResponse response) throws BadRequestException{
        String email = securityContext.getCallerPrincipal().getName();
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        runtimeService.correlateMessage(PAY_OFFER, email+PROCESS_CONFIRM_BUY_OFFER);
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE, response);
    }


    public class InvalidCredentialsException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }
}
