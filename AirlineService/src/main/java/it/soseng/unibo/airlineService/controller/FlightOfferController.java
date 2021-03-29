package it.soseng.unibo.airlineService.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.lowagie.text.DocumentException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.model.FlightOffer;
import it.soseng.unibo.airlineService.model.Iban;
import it.soseng.unibo.airlineService.service.FlightOfferService;
import it.soseng.unibo.airlineService.service.PdfService;

/**
 * Controller che si occupa della generazione e gestione delle offerte di volo e 
 * della comunicazione delle coordinate bancarie del servizio
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */
@RestController
public class FlightOfferController {

    /**
     * istanza di FlightOfferService le cui funzioni vengono richiamate per offrire le funzionalità
     * all'esterno tramite le route
     */
    @Autowired
    private FlightOfferService s;

    @Autowired
    private PdfService p;

    @Value("${server.file}") 
    public String FILE;
    

    
    /** 
     * si occupa di generare le offerte di volo randomicamente e automaticamente, ed
     * inviarle ad ACMEsky se si tratta di offerte last minute.
     * Seguono le eccezioni da considerare dovute alla creazione delle offerte da file json
     * @throws JsonProcessingException
     * @throws IOException
     */
    @Scheduled(fixedRate = 6000)
    @PostMapping("/createOffer")
    private void autoCreateOffer() throws JsonProcessingException, IOException {
        s.createFlightOffer(FILE);
    }

    
    /** 
     * si occupa di restituire le offerte di volo che hanno un match con una specifica
     * richiesta dell'utente 
     * @param r che contiene i parametri del volo che l'utente cerca
     * @return List<FlightOffer> che contiene tutte le offerte di lavoro prenotabili
     */
    @PostMapping("/searchFlight")
    public List<FlightOffer> getOffers(@RequestBody UserRequest r) {
        return s.searchFlightOffers(r);
    }

    
    /** restituisce la lista di tutte le offerte di volo
     * @return List<FlightOffer>
     */
    @GetMapping("/getAll")
    public List<FlightOffer> getAll() {
        return s.getAll();
    }

    
    /** si occupa di cancellare l'offerta di volo quando risulta che l'offerta sia stata acquistata 
     * correttamente(viene chiamata quando si è verificato il pagamento dell'utente)
     * @param id che viene passato per identificare l'offerta da eliminare
     */
    @DeleteMapping("/DeleteOffer")
    public void OfferPurchasedCorrectly(@RequestParam(name = "id") long id) {
        s.deleteFlightOffer(id);
    }

    
    /** restituisce lo stato dell'offerta di volo (se risulta prenotabile o no)
     * @param id dell'offerta di cui si richiede lo stato
     * @return boolean il cui valore true indica che l'offerta è prenotabile(viceversa false se non lo è)
     */
    @GetMapping("/getOfferBookableState")
    public boolean getOfferState(@RequestParam(name = "id") long id){
        return s.getOfferState(id);
    }

    
    /** 
     * restituisce l'esito della prenotazione dell'offerta di volo
     * @param id dell'offerta oggetto di interesse
     * @return boolean che indica true se l'offerta viene prenotata(false viceversa)
     * @throws DocumentException
     * @throws IOException
     */
    @GetMapping("/download-pdf")
    public void downloadPDFResource( HttpServletResponse response, @RequestParam(name = "id") long ... id) {
        try {
            Path file = Paths.get(p.generatePdf(id).getAbsolutePath());
            if (Files.exists(file)) {
                response.setContentType("application/pdf");
                response.addHeader("Content-Disposition",
                        "attachment; filename=" + file.getFileName());
                Files.copy(file, response.getOutputStream());
                response.getOutputStream().flush();
            }
        } catch (DocumentException | IOException ex) {
            ex.printStackTrace();
        }
    }

    
    /** 
     * restituisce l'iban del servizio necessario per il pagamento dell'offerta
     * @param sendIban iban preso dal paramtro server.iban presente in application.properties in resources
     * @return Iban del servizio
     */
    @GetMapping("/iban")
    public Iban sendIban(@Value("${server.iban}") String iban) {
        return s.sendIban(iban);
    }
}
