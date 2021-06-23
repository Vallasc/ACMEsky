package it.soseng.unibo.airlineService.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.transaction.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.lowagie.text.DocumentException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.thymeleaf.context.Context;
import org.thymeleaf.extras.java8time.dialect.Java8TimeDialect;
import org.thymeleaf.spring5.SpringTemplateEngine;
import org.xhtmlrenderer.pdf.ITextRenderer;

import it.soseng.unibo.airlineService.auth.Auth;
import it.soseng.unibo.airlineService.repository.FlightOfferRepository;



@Service
@Transactional
public class PdfService {


  @Autowired
    private FlightOfferRepository repo;


    private SpringTemplateEngine templateEngine;

    private FlightOfferService service;

    private Auth auth = new Auth();

    private static final String PDF_RESOURCES = "/pdf-resources/";


    @Autowired
    public PdfService(SpringTemplateEngine templateEngine, FlightOfferService service) {
      this.service = service;
      this.templateEngine = templateEngine;
    }
    
    /**
     * fa generare il biglietto del volo che sta per essere acquistato dall'utente
     * @param id
     * @return
     * @throws IOException
     * @throws DocumentException
     */
    public File generatePdf(long ... id) throws IOException, DocumentException {
      Context context = getContext(id);
      String html = loadAndFillTemplate(context);
      return renderPdf(html);
  }


  /**
   * si occupa del rendering del file pdf del biglietto
   * @param html
   * @return
   * @throws IOException
   * @throws DocumentException
   */
  private File renderPdf(String html) throws IOException, DocumentException {
    File file = File.createTempFile("Ticket", ".pdf");
    OutputStream outputStream = new FileOutputStream(file);
    ITextRenderer renderer = new ITextRenderer(20f * 4f / 3f, 20);
    renderer.setDocumentFromString(html,  new ClassPathResource(PDF_RESOURCES).getURL().toExternalForm());
    renderer.layout();
    renderer.createPDF(outputStream);
    outputStream.close();
    file.deleteOnExit();
    return file;
  }


  /**
   * fornisce il contesto del biglietto, ovvero il recupero delle informazioni relative ai voli che l'utente vuole acquistare
   * @param l
   * @return
   */
  public Context getContext(long ... l) {

      Context context = new Context();
      this.templateEngine.addDialect(new Java8TimeDialect());
      context.setVariable("flights", service.getOffers(l));
      return context;
    }

  /**
   * "riempie" il template del biglietto con le informazioni dei voli da acquistare
   * @param context
   * @return
   */
  private String loadAndFillTemplate(Context context) {
      return templateEngine.process("Ticket_template", context);
  }

  /**
   * si occupa di inviare ad ACMEsky (o chiunque chiami la risorsa) i biglietti che l'utente vuole acquistare attraverso una chiamata 
   * HTTP POST che ha nel suo body i file pdf dei biglietti dopo aver imposta il soldFlag delle offerte relative ai voli oggetto 
   * dell'acquisto 
   * @param sendLastMinuteOffersRoute
   * @param id
   * @throws JsonProcessingException
   */
  public void sendPdfs(String user, String pass, String ACMEskyRoute, long...id) throws JsonProcessingException{

    String jwt = auth.AuthRequest(ACMEskyRoute, user, pass);

    for(long i : id){
      repo.findById(i).get().setSoldFlag(true);
    }

    MultiValueMap<String, Object> body  = new LinkedMultiValueMap<>();
    for(long i : id){
      try {
        body.add("files", generatePdf(i));
      } catch (IOException e) {
        e.printStackTrace();
      } catch (DocumentException e) {
        e.printStackTrace();
      }
    }

    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.MULTIPART_FORM_DATA);
    headers.set("Authorization", jwt);

    HttpEntity<MultiValueMap<String, Object>> requestEntity= new HttpEntity<>(body, headers);

    String serverUrl = ACMEskyRoute + "/airline/OfferFiles";

    RestTemplate restTemplate = new RestTemplate();
    ResponseEntity<String> response = restTemplate
      .postForEntity(serverUrl, requestEntity, String.class);
  }



}