package it.unibo.soseng.security;

import static java.util.Collections.singleton;
import java.util.List;
import java.util.Set;

import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.security.enterprise.credential.Credential;
import javax.security.enterprise.credential.UsernamePasswordCredential;
import javax.security.enterprise.identitystore.CredentialValidationResult;
import javax.security.enterprise.identitystore.IdentityStore;

import it.unibo.soseng.model.DomainEntity;

import static javax.security.enterprise.identitystore.IdentityStore.ValidationType.VALIDATE;
import static javax.security.enterprise.identitystore.CredentialValidationResult.INVALID_RESULT;
import static javax.security.enterprise.identitystore.CredentialValidationResult.NOT_VALIDATED_RESULT;

@RequestScoped
public class AuthenticationIdentityStore implements IdentityStore {

    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        CredentialValidationResult result;

        if (credential instanceof UsernamePasswordCredential) {
            UsernamePasswordCredential usernamePassword = (UsernamePasswordCredential) credential;

            boolean find = findWithCredential(usernamePassword.getCaller(),usernamePassword.getPasswordAsString());
            if ( find ) {
                result = new CredentialValidationResult(usernamePassword.getCaller());
            } else {
                result = INVALID_RESULT;
            }
        } else {
            result = NOT_VALIDATED_RESULT;
        }
        return result;
    }

    @Override
    public Set<ValidationType> validationTypes() {
        return singleton(VALIDATE);
    }

    public boolean findWithCredential(String username, String password) {
        @SuppressWarnings("unchecked")
        List<DomainEntity> result = (List<DomainEntity>) entityManager.createQuery(
                            "SELECT d FROM DomainEntity d WHERE d.username = :username AND d.password = :password")
                            .setParameter("username", username)
                            .setParameter("password", password)
                            .setMaxResults(10)
                            .getResultList();
        return result.size() == 1;
    }
}