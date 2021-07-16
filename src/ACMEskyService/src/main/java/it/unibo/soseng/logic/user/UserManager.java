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
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;

import it.unibo.soseng.gateway.user.dto.UserDeleteDTO;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.camunda.ProcessState;
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
import static it.unibo.soseng.camunda.StartEvents.RECEIVED_TOKEN;
import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER_TOKEN;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_CONFIRM_FLIGHT;
import static it.unibo.soseng.camunda.ProcessVariables.URI_INFO;
import static it.unibo.soseng.camunda.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_ERROR;

import java.time.OffsetDateTime;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
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

    // Start Camunda process
    public void startConfirmUserFlight(UserOfferDTO request, AsyncResponse response, UriInfo uriInfo) 
    throws BadRequestException{
    LOGGER.info("StartConfirmFlightsFromUser");
    String token = request.getToken();

    final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
    Map<String,Object> processVariables = new HashMap<String,Object>();
    processVariables.put(USER_OFFER_REQUEST, request);
    processVariables.put(USER_OFFER_TOKEN, token);
    processState.setState(PROCESS_CONFIRM_FLIGHT, token, URI_INFO, uriInfo);
    processState.setState(PROCESS_CONFIRM_FLIGHT, token, ASYNC_RESPONSE, response);

        // Start the process instance
    ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey(RECEIVED_TOKEN)
    .setVariables(processVariables)
    .executeWithVariablesInReturn();
    processVariables = instance.getVariables();
    String error = (String) processVariables.get(PROCESS_ERROR);
    if(error != null)
    throw new BadRequestException();
    }  
    
    public Response handleConfirmUserFlight(String token, UserOfferDTO offer) throws OfferNotFoundException{
            // Control token
            if (token == null || token == "") {
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                .entity(Errors.INVALID_TOKEN)
                .build();
            }
            GeneratedOffer offerToReturn = databaseManager.getOfferByToken(token);
            OffsetDateTime now = OffsetDateTime.now();
            if (offerToReturn.getExpireDate().compareTo(now) < 0) {
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                                .entity(Errors.OFFER_EXPIRED)
                                .build();
            }
            try {
                UriInfo uriInfo = (UriInfo) processState.getState(PROCESS_CONFIRM_FLIGHT, token, URI_INFO);
                return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), offer.getId()))
                        .build();
            } catch (DateTimeParseException e){
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                                .entity(Errors.DATE_FORMAT_ERROR)
                                .build();
            }
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

    public class InvalidCredentialsException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }
}
