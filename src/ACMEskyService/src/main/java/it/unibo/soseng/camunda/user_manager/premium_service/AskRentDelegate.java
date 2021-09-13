package it.unibo.soseng.camunda.user_manager.premium_service;

import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_ADDRESS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.NEAREST_RENT;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.logic.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.RentService;

/**
 * JavaDelegate associato al task "Ask for rent" del diagramma BPMN
 * confirm_offer.bpmn. L'esecuzione di questo task va ad effettuare le
 * prenotazioni per il servizio di rent per i voli di andata e ritorno
 * dell'offerta.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("askRentDelegate")
public class AskRentDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(AskRentDelegate.class.getName());

    @Inject
    OfferManager offerManager;

    /**
     * Raccoglie le informazioni sull'indirizzo dell'utente, il suo username,
     * l'offerta che ha acquistato e infine aggiunge le informazioni sul servizio di
     * rent che applica ai voli di andata e ritorno dell'offerta.
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute AskRentDelegate");
        AddressDTO address = (AddressDTO) execution.getVariable(USER_ADDRESS);
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        String email = (String) execution.getVariable(USERNAME);
        RentService nearest = (RentService) execution.getVariable(NEAREST_RENT);

        try {
            offerManager.bookAllRent(email, address, offer, nearest, execution);
            execution.setVariable(USER_OFFER, offer);
        } catch (UserNotFoundException e) {
            LOGGER.info(e.toString());
        }
    }

}
