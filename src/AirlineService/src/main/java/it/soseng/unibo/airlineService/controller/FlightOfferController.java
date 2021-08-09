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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import it.soseng.unibo.airlineService.DTO.Flight;
import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.model.FlightOffer;
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
    
    @Value("${server.acmesky.route}") 
    public String ACMEskyRoute;

    @Value("${server.airline.user}") 
    public String user;

    @Value("${server.airline.pass}") 
    public String pass;

    
    /** 
     * si occupa di generare le offerte di volo randomicamente e automaticamente, ed
     * inviarle ad ACMEsky se si tratta di offerte last minute.
     * Seguono le eccezioni da considerare dovute alla creazione delle offerte da file json
     * @throws JsonProcessingException
     * @throws IOException
     */
    @Scheduled(fixedRate = 60000)
    @PostMapping("/createOffer")
    private void autoCreateOffer() throws JsonProcessingException, IOException {
        s.createFlightOffer(FILE,ACMEskyRoute, user, pass);
    }

    
    /** 
     * si occupa di restituire i voli che hanno un match con una specifica
     * richiesta dell'utente 
     * @param r che contiene i parametri del volo che l'utente cerca
     * @return List<FlightOffer> che contiene tutte le offerte di lavoro prenotabili
     */
    @PostMapping("/getFlights")
    public List<Flight> getOffers(@RequestBody List<UserRequest> r) {
        return s.getMatchingFlights(r);
    }

    
    /** si occupa di impostare il soldFlag con il valore false dell'offerta di volo quando risulta 
     * che l'offerta non sia stata acquistata per un eventuale errore (viene chiamata dopo il tentativo di pagamento dell'utente)
     * @param id che viene passato per identificare l'offerta da eliminare
     */
    @PostMapping("/notPurchasedOffer")
    public void unsoldFlight(@RequestParam(name = "id") long ... id) {
        s.unsoldFlights(id);
    }
    
    
    /** 
     * invia i biglietti in formato pdf relativi a quelle offerte che hanno il valore degli id corrispondenti
     * a quelli passati attraverso i parametri
     * @param id dei voli che si vuole acquistare
     * @throws com.lowagie.text.DocumentException
     * @throws JsonProcessingException
     */
    @GetMapping("/getTickets")
    public String sendTickets( HttpServletResponse response, @RequestParam(name = "id") long ... id) throws DocumentException  {
        try {
            if(s.checkUnsoldFlights(id) == true){

            Path file = Paths.get(p.generatePdf(id).getAbsolutePath());
            if (Files.exists(file)) {
                response.setContentType("application/pdf");
                response.addHeader("Content-Disposition",
                        "attachment; filename=" + file.getFileName());
                Files.copy(file, response.getOutputStream());
                response.getOutputStream().flush();
            }
                return new String("ok");
            }else{
                return new String("error: flights have already been sold");
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return "";
    }

}