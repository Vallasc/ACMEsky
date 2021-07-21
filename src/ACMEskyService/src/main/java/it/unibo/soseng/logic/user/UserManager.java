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
import it.unibo.soseng.camunda.ProcessState;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_BUY_OFFER;
import static it.unibo.soseng.camunda.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_ERROR;
import static it.unibo.soseng.camunda.ProcessVariables.ERRORS_IN_PAYMENT_REQ;

import static it.unibo.soseng.camunda.StartEvents.PAY_OFFER;

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
import it.unibo.soseng.util.Errors;
import static it.unibo.soseng.security.Constants.USER;
import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER_TOKEN;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.ProcessVariables.IS_VALID_TOKEN;
import static it.unibo.soseng.camunda.ProcessVariables.IS_OFFER_EXPIRED;
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
    public void startConfirmUserFlight(UserOfferDTO request, AsyncResponse response, UriInfo uriInfo) 
    throws BadRequestException{
    LOGGER.info("startConfirmUserFlight");
    String email = securityContext.getCallerPrincipal().getName();
    String token = request.getToken();

    final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
    Map<String,Object> processVariables = new HashMap<String,Object>();
    processVariables.put(USER_OFFER_REQUEST, request);
    processVariables.put(USER_OFFER_TOKEN, token);
    processVariables.put(USERNAME, email);
    processState.setState(PROCESS_BUY_OFFER, email, ASYNC_RESPONSE, response);

    // Start the process instance
    ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey(PAY_OFFER)
    .setVariables(processVariables)
    .executeWithVariablesInReturn();
    processVariables = instance.getVariables();
    String error = (String) processVariables.get(PROCESS_ERROR);

    if(error != null)
        throw new BadRequestException();

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
            return Response.status(Response.Status.OK.getStatusCode())
            .build();
        }

    public void createUser(UserSignUpDTO request) throws UserAlreadyInException {
        User user = new User();
        user.setProntogramUsername(request.getProntogramUsername());
        user.setEmail(request.getEmail());
        DomainEntity entity = new DomainEntity();
        entity.setUsername(request.getEmail());
        entity.setPassword(request.getPassword());
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

        processState.setState(PROCESS_BUY_OFFER, email, ASYNC_RESPONSE, response);

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String,Object> processVariables = new HashMap<String,Object>();
        // processVariables = runtimeService.getVariables(PAY_OFFER);
    }

    public Response handlePaymentRequest(String email, DelegateExecution execution) {
        
        byte[] ticket = (byte[]) processState.getState(PROCESS_BUY_OFFER, email, "PDF");

        if(ticket == null){
            execution.setVariable(ERRORS_IN_PAYMENT_REQ, true);  
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                            .entity(Errors.OFFER_NOT_AVAILABLE)
                            .build();
        
        }        
        
        return Response.status(Response.Status.OK.getStatusCode())
        .build();
    }


    public class InvalidCredentialsException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }
}
