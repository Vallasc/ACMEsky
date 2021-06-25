package it.unibo.soseng.logic.user;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;

import it.unibo.soseng.gateway.user.dto.UserResponse;
import it.unibo.soseng.gateway.user.dto.UserSignInRequest;
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

    public void createUser(UserSignInRequest request) throws UserAlreadyInException{
        User user = new User();
        user.setName(request.getName());
        user.setSurname(request.getSurname());
        user.setAddress(request.getAddress());
        user.setEmail(request.getEmail());
        user.setProntogramToken(request.getProntogramToken());
        DomainEntity entity = new DomainEntity();
        entity.setUsername(request.getEmail());
        entity.setPassword(request.getPassword());
        entity.setRole(USER);
        entity.setSalt("aaaa");
        user.setEntity(entity);
        
        databaseManager.createUser(user);
    }

    public UserResponse getUser(String username){
        String name = securityContext.getCallerPrincipal().getName();
        if(!name.equals(username))
            return null;
        try {
            User user = databaseManager.getUser(username);
            UserResponse response = new UserResponse();
            response.setName(user.getName());
            response.setSurname(user.getSurname());
            response.setEmail(user.getEmail());
            response.setPassword(user.getEntity().getPassword());
            response.setAddress(user.getAddress());
            response.setProntogramToken(user.getProntogramToken());
            return response;
        } catch (UserNotFoundException e) {
            //e.printStackTrace();
            return null;
        }

    }
    
}
