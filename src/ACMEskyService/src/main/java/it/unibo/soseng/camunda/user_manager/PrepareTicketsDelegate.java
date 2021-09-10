package it.unibo.soseng.camunda.user_manager;

import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.utils.Pdf;
import it.unibo.soseng.ws.generated.BookRentResponse;

import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_OUTBOUND;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_BACK;

@Named("prepareTicketsDelegate")
public class PrepareTicketsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(PrepareTicketsDelegate.class.getName());

    @Inject
    Pdf pdfUtil;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute PrepareTicketsDelegate");

        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        BookRentResponse rentOutbound = (BookRentResponse) execution.getVariable(RENT_OUTBOUND);
        BookRentResponse rentBack = (BookRentResponse) execution.getVariable(RENT_BACK);
        
        // Produce  i biglietti con la ricevuta
        pdfUtil.makePdf(offer, rentOutbound, rentBack);
        try {
            pdfUtil.mergePdf(offer.getToken()+"_tmp2.pdf", offer.getToken()+"_tmp1.pdf", offer.getToken()+".pdf");
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Clean tmp file
        try {
            File tmp = new File(offer.getToken()+"_tmp1.pdf"); 
            tmp.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            File tmp = new File(offer.getToken()+"_tmp2.pdf"); 
            tmp.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
