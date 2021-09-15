package it.soseng.unibo.airlineService.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

import javax.annotation.PostConstruct;
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
import it.soseng.unibo.airlineService.service.FlightOfferService;
import it.soseng.unibo.airlineService.service.PdfService;

/**
 * Controller che si occupa della generazione e gestione delle offerte di volo e
 * della generazione dei biglietti di volo
 * 
 * @author Andrea Di Ubaldo andrea.diubaldo@studio.unibo.it
 */
@RestController
public class FlightOfferController {

    /**
     * istanza di FlightOfferService le cui funzioni vengono richiamate per offrire
     * le funzionalità all'esterno tramite le route
     */
    @Autowired
    private FlightOfferService s;

    /**
     * istanza di PdfService che consente di generare i biglietti per ogni richiesta
     * sulla route corrispondente
     * 
     */
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

    private final static Logger LOGGER = Logger.getLogger(FlightOfferService.class.getName());

    /**
     * si occupa di generare le offerte di volo randomicamente e automaticamente, ed
     * inviarle ad ACMEsky ogni 10 minuti.
     * 
     * @throws JsonProcessingException
     * @throws IOException
     */
    @Scheduled(fixedRate = 600000)
    private void sendLastMinuteOffer() throws JsonProcessingException, IOException {
        s.handleLastMinuteOffer(FILE, ACMEskyRoute, user, pass);

    }

    /**
     * crea automaticamente tutte le offerte di volo non last-minute una sola volta
     * dopo 6 secondi che il servizio viene eseguito.
     */
    @PostConstruct()
    private void autoCreateOffer() {

        ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();
        executorService.schedule(new Runnable() {
            public void run() {
                try {
                    s.createFlightOffers(FILE);
                } catch (IOException e) {
                    LOGGER.info("Error" + e.getMessage());
                }
            }
        }, (long) 6, TimeUnit.SECONDS);
    }

    /**
     * si occupa di restituire i voli che hanno un match con quelli richiesti dagli
     * utenti passati nel corpo della richiesta
     * 
     * @param r che contiene i parametri del volo che l'utente cerca
     * @return List<FlightOffer> che contiene tutte le offerte di lavoro prenotabili
     */
    @PostMapping("/getFlights")
    public List<Flight> getOffers(@RequestBody List<UserRequest> r) {
        return s.getMatchingFlights(r);
    }

    /**
     * invia il biglietto in formato pdf relativi ai voli di andata e ritorno i cui
     * id vengono specificati nel parametro id
     * 
     * @param id dei voli che si vuole acquistare
     * @throws com.lowagie.text.DocumentException
     * @throws JsonProcessingException
     */
    @GetMapping("/getTickets")
    public String sendTickets(HttpServletResponse response, @RequestParam(name = "id") long... id)
            throws DocumentException {
        try {

            Path file = Paths.get(p.generatePdf(id).getAbsolutePath());
            if (Files.exists(file)) {
                response.setContentType("application/pdf");
                response.addHeader("Content-Disposition", "attachment; filename=" + file.getFileName());
                Files.copy(file, response.getOutputStream());
                response.getOutputStream().flush();
            }
            return new String("ok");

        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return "";
    }

}