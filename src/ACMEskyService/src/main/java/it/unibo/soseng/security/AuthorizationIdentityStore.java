package it.unibo.soseng.security;

import static it.unibo.soseng.security.Constants.BANK;
import static it.unibo.soseng.security.Constants.AIRLINE;

import static java.util.Collections.emptySet;
import static java.util.Collections.singleton;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.enterprise.context.RequestScoped;
import javax.security.enterprise.identitystore.CredentialValidationResult;
import javax.security.enterprise.identitystore.IdentityStore;
import static javax.security.enterprise.identitystore.IdentityStore.ValidationType.PROVIDE_GROUPS;

@RequestScoped
public class AuthorizationIdentityStore implements IdentityStore {

    private Map<String, Set<String>> groupsPerCaller;

    @PostConstruct
    public void init() {
        groupsPerCaller = new HashMap<>();
        groupsPerCaller.put("airline", singleton(AIRLINE));
        groupsPerCaller.put("bank", singleton(BANK));
    }

    @Override
    public Set<String> getCallerGroups(CredentialValidationResult validationResult) {
        Set<String> result = groupsPerCaller.get(validationResult.getCallerPrincipal().getName());
        if (result == null) {
            result = emptySet();
        }
        return result;
    }

    @Override
    public Set<ValidationType> validationTypes() {
        return singleton(PROVIDE_GROUPS);
    }

}