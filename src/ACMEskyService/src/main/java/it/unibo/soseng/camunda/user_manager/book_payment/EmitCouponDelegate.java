package it.unibo.soseng.camunda.user_manager.book_payment;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

/**
 * JavaDelegate associato al task "Emit coupon" del diagramma BPMN
 * confirm_offer.bpmn, la cui esecuzione dovrebbe generare un coupon nel caso in
 * cui l'utente abbia effettuato il pagamento ma non riceve i biglietti.
 * Tuttavia non è stato implementato
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("emitCouponDelegate")
public class EmitCouponDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(EmitCouponDelegate.class.getName());

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("Execute EmitCouponDelegate");

    }

}
