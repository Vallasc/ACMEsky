package it.unibo.soseng.camunda.offers_manager;

import java.util.logging.Logger;

import javax.inject.Named;
import javax.ws.rs.core.Response;
import javax.inject.Inject;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.database.DatabaseManager.OfferNotFoundException;
import it.unibo.soseng.logic.user.UserManager;
import it.unibo.soseng.camunda.ProcessState;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER_TOKEN;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_BUY_OFFER;
import static it.unibo.soseng.camunda.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;


@Named("retrieveOfferDelegate")
public class RetrieveOfferDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(RetrieveOfferDelegate.class.getName());

    @Inject 
    UserManager userManager;

    @Inject
    private ProcessState processState;

    @Override
    public void execute(DelegateExecution execution) throws OfferNotFoundException{
        LOGGER.info("Execute RetrieveOffer");
        UserOfferDTO offerRequest = (UserOfferDTO) execution.getVariable(USER_OFFER_REQUEST);
        String token = (String) execution.getVariable(USER_OFFER_TOKEN);
        String email = (String) execution.getVariable(USERNAME);
        Response response = userManager.handleConfirmUserFlight(token, email, offerRequest, execution);
        processState.setState(PROCESS_BUY_OFFER, email, RESPONSE, response);
    }
  
}
