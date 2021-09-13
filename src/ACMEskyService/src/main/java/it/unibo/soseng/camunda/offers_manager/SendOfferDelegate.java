package it.unibo.soseng.camunda.offers_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import io.jsonwebtoken.io.IOException;
import it.unibo.soseng.gateway.prontogram.ProntogramClient;
import it.unibo.soseng.gateway.prontogram.ProntogramClient.ProntogramServiceErrorException;
import it.unibo.soseng.gateway.prontogram.dto.NotificationDTO;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PRONTOGRAM_USERNAME;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

/**
 * JavaDelegate associato al task "Send offer" del diagramma BPMN
 * offer_manager.bpmn. Questo task recupera l'username di Prontogram dell'utente
 * per inviargli una notifica di avvenuta generazione dell'offerta da lui
 * richiesta su Prontogram. Entrando nell'app vedrà l'offerta con le
 * caratteristiche richieste e con il codice che dovrà inserire sull'app di
 * ACMEskyWeb per acquistarla.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("sendOfferDelegate")
public class SendOfferDelegate implements JavaDelegate {
  private final static Logger LOGGER = Logger.getLogger(SendOfferDelegate.class.getName());

  @Inject
  ProntogramClient prontogramClient;

  /**
   * Recupera l'offerta generata in precedenza e l'id di Prontogram dell'utente
   * per inviargli una notifica che annuncia la disponibilità dell'offerta
   * richiesta.
   */

  @Override
  public void execute(DelegateExecution execution) throws IOException, InterruptedException, java.io.IOException {
    LOGGER.info("Execute sendOfferDelegate");

    String prontogramUsername = (String) execution.getVariable(PRONTOGRAM_USERNAME);
    GeneratedOffer offer = (GeneratedOffer) execution.getVariable(GENERATED_OFFER);
    NotificationDTO notification = NotificationDTO.fromOffer(offer, prontogramUsername);
    LOGGER.info("Offer - protogramUser: " + prontogramUsername + " - offerToken: " + offer.getToken());
    try {
      prontogramClient.sendNotificationOffer(notification);
    } catch (IOException | ProntogramServiceErrorException e) {
      LOGGER.severe("Send prontogram notification error: " + e);
    }
  }
}
