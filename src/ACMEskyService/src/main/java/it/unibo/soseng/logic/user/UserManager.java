package it.unibo.soseng.logic.user;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.security.enterprise.SecurityContext;

import it.unibo.soseng.gateway.user.dto.UserDeleteRequest;
import it.unibo.soseng.gateway.user.dto.UserResponse;
import it.unibo.soseng.gateway.user.dto.UserSignInRequest;
import it.unibo.soseng.gateway.user.dto.UserUpdateRequest;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.DomainEntity;
import it.unibo.soseng.model.User;
import static it.unibo.soseng.security.Constants.USER;
import java.util.logging.Level;
import java.util.logging.Logger;

@Stateless
public class UserManager {
    private final static Logger LOGGER = Logger.getLogger(UserManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private SecurityContext securityContext;

    public void createUser(UserSignInRequest request) throws UserAlreadyInException {
        User user = new User();
        user.setProntogramToken(request.getProntogramToken());
        user.setEmail(request.getEmail());
        DomainEntity entity = new DomainEntity();
        entity.setUsername(request.getEmail());
        entity.setPassword(request.getPassword());
        entity.setRole(USER);
        entity.setSalt("aaaa");
        user.setEntity(entity);
        
        databaseManager.createUser(user);
    }

    public UserResponse getUser() throws UserNotFoundException{
        String email = securityContext.getCallerPrincipal().getName();
        User user = databaseManager.getUser(email);
        UserResponse response = new UserResponse();
        response.setEmail(user.getEmail());
        response.setPassword(user.getEntity().getPassword());
        response.setProntogramToken(user.getProntogramToken());
        return response;

    }
    
    public UserResponse updateUser(UserUpdateRequest request) throws InvalidCredentialsException, UserNotFoundException {
        String name = securityContext.getCallerPrincipal().getName();
        if(!name.equals(request.getEmail()))
            throw new InvalidCredentialsException();

        User user = databaseManager.getUser(name);

        if(!user.getEntity().getPassword().equals(request.getPassword()))
            throw new InvalidCredentialsException();
        if(request.getNewPassword() != null)
            user.getEntity().setPassword(request.getNewPassword());
        if(request.getNewProntogramToken() != null)
            user.setProntogramToken(request.getNewProntogramToken());
        
        databaseManager.updateUser(user);
        UserResponse response = new UserResponse();
        response.setEmail(user.getEmail());
        response.setPassword(user.getEntity().getPassword());
        response.setProntogramToken(user.getProntogramToken());
        return response;
    }

    public void deleteUser(UserDeleteRequest request) throws InvalidCredentialsException, 
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
}
