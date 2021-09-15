package it.unibo.soseng.logic;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.security.enterprise.SecurityContext;

import it.unibo.soseng.gateway.user.dto.UserDTO;
import it.unibo.soseng.gateway.user.dto.UserSignUpDTO;
import it.unibo.soseng.gateway.user.dto.UserUpdateDTO;
import it.unibo.soseng.logic.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.DomainEntity;
import it.unibo.soseng.model.User;

import static it.unibo.soseng.security.Constants.USER;

import java.util.UUID;

/**
 * Logica che gestisce gli utenti che vogliono interagire con ACMEsky
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Stateless
public class UserManager {
    // private final static Logger LOGGER =
    // Logger.getLogger(UserManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private SecurityContext securityContext;

    /**
     * genera l'oggetto utente e lo salva in DB
     * 
     * @param request
     * @throws UserAlreadyInException
     */
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

    /**
     * recupera l'utente che si è appena autenticato su ACMEskyWeb
     * 
     * @return
     * @throws UserNotFoundException
     */
    public UserDTO getUser() throws UserNotFoundException {
        String email = securityContext.getCallerPrincipal().getName();
        User user = databaseManager.getUser(email);
        return UserDTO.fromUser(user);
    }

    /**
     * aggiorna le informazioni dell'utente che si è autenticato su ACMEskyWeb
     * 
     * @param request
     * @return
     * @throws InvalidCredentialsException
     * @throws UserNotFoundException
     */
    public UserDTO updateUser(UserUpdateDTO request) throws InvalidCredentialsException, UserNotFoundException {
        String name = securityContext.getCallerPrincipal().getName();
        if (!name.equals(request.getEmail()))
            throw new InvalidCredentialsException();

        User user = databaseManager.getUser(name);

        if (!user.getEntity().getPassword().equals(request.getPassword()))
            throw new InvalidCredentialsException();
        if (request.getNewPassword() != null)
            user.getEntity().setPassword(request.getNewPassword());
        if (request.getNewProntogramUsername() != null)
            user.setProntogramUsername(request.getNewProntogramUsername());
        if (request.getNewName() != null)
            user.setName(request.getNewName());
        if (request.getNewSurname() != null)
            user.setSurname(request.getNewSurname());

        databaseManager.updateUser(user);
        return UserDTO.fromUser(user);
    }

    /**
     * elimina l'utente che si è autenticato su ACMEskyWeb
     * 
     * @throws InvalidCredentialsException
     * @throws PersistenceException
     * @throws UserNotFoundException
     */
    public void deleteUser() throws InvalidCredentialsException, PersistenceException, UserNotFoundException {
        String name = securityContext.getCallerPrincipal().getName();
        User user = databaseManager.getUser(name);
        databaseManager.removeUser(user);
    }

    public class InvalidCredentialsException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }
}
