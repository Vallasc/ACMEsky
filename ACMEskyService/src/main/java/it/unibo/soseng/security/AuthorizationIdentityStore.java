package it.unibo.soseng.security;

import static java.util.Collections.emptySet;
import static java.util.Collections.singleton;
import java.util.List;
import java.util.Set;

import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.security.enterprise.identitystore.CredentialValidationResult;
import javax.security.enterprise.identitystore.IdentityStore;
import static javax.security.enterprise.identitystore.IdentityStore.ValidationType.PROVIDE_GROUPS;

@RequestScoped
public class AuthorizationIdentityStore implements IdentityStore {

    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;

    @Override
    public Set<String> getCallerGroups(CredentialValidationResult validationResult) {
        Set<String> result = getRoleCredential(validationResult.getCallerPrincipal().getName());
        if (result == null) {
            result = emptySet();
        }
        return result;
    }

    @Override
    public Set<ValidationType> validationTypes() {
        return singleton(PROVIDE_GROUPS);
    }

    public Set<String> getRoleCredential(String username) {
        @SuppressWarnings("unchecked")
        List<String> result = (List<String>) entityManager.createQuery(
                            "SELECT d.role FROM DomainEntity d WHERE d.username = :username")
                            .setParameter("username", username)
                            .setMaxResults(10)
                            .getResultList();
        if( result.size() == 1 ){
            return singleton(result.get(0));
        }
        return null;
    }
}