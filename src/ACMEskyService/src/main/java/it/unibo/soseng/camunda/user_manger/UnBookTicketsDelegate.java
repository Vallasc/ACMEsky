package it.unibo.soseng.camunda.user_manger;

import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.GeneratedOffer;

@Named("unBookTicketsDelegate")
public class UnBookTicketsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("unBookTicketsDelegate");

    @Inject
    AirlineManager airlineManager;

    @Inject
    DatabaseManager dbManager;

    @Override
    public void execute(DelegateExecution execution) throws IOException{
        LOGGER.info("UnBookTickets working");
        


        
    }
}
