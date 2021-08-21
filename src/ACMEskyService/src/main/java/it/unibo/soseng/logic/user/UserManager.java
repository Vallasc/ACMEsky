package it.unibo.soseng.logic.user;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.security.enterprise.SecurityContext;

import it.unibo.soseng.gateway.user.dto.UserDeleteDTO;
import it.unibo.soseng.gateway.user.dto.UserDTO;
import it.unibo.soseng.gateway.user.dto.UserSignUpDTO;
import it.unibo.soseng.gateway.user.dto.UserUpdateDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.DomainEntity;
import it.unibo.soseng.model.User;

import static it.unibo.soseng.security.Constants.USER;

import java.util.UUID;
import java.util.logging.Logger;

@Stateless
public class UserManager {
    private final static Logger LOGGER = Logger.getLogger(UserManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private SecurityContext securityContext;

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
        String salt = UUID.randomUUID().toString().substring(0, 4);
        entity.setSalt(salt);
        user.setEntity(entity);
        
        databaseManager.createUser(user);
    }

  
    public UserDTO getUser() throws UserNotFoundException{
        String email = securityContext.getCallerPrincipal().getName();
        User user = databaseManager.getUser(email);
        return UserDTO.fromUser(user);
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
        if(request.getNewName() != null)
            user.setName(request.getNewName());
        if(request.getNewSurname() != null)
            user.setSurname(request.getNewSurname());

        databaseManager.updateUser(user);
        return UserDTO.fromUser(user);
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
