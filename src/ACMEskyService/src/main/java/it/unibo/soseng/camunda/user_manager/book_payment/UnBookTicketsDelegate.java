package it.unibo.soseng.camunda.user_manager.book_payment;

import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;

@Named("unbookTicketsDelegate")
public class UnBookTicketsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(UnBookTicketsDelegate.class.getName());

    @Inject
    AirlineManager airlineManager;

    @Inject
    DatabaseManager dbManager;

    @Override
    public void execute(DelegateExecution execution) throws IOException {
        LOGGER.info("UnbookTickets working");
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        airlineManager.unbookOffer(offer);

    }
}
