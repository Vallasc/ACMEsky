package it.soseng.unibo.airlineService.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.annotation.PostConstruct;
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
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
import org.thymeleaf.extras.java8time.dialect.Java8TimeDialect;
import org.xhtmlrenderer.pdf.ITextRenderer;

import it.soseng.unibo.airlineService.auth.Auth;
import it.soseng.unibo.airlineService.repository.FlightOfferRepository;

@Service
@Transactional
public class PdfService {

  @Autowired
  private FlightOfferRepository repo;

  @Autowired
  TemplateEngine templateEngine;

  private FlightOfferService service;

  private Auth auth = new Auth();

  private static final String PDF_RESOURCES = "/pdf-resources/";

  @Autowired
  public PdfService(FlightOfferService service) {
    this.service = service;

  }

  @PostConstruct
  public void postConstruct() {
    this.templateEngine.addDialect(new Java8TimeDialect());

  }

  /**
   * fa generare il biglietto del volo che sta per essere acquistato dall'utente
   * 
   * @param id
   * @return
   * @throws IOException
   * @throws DocumentException
   */
  public File generatePdf(long... id) throws IOException, DocumentException {
    Context context = getContext(id);
    String html = loadAndFillTemplate(context);
    return renderPdf(html);
  }

  /**
   * si occupa del rendering del file pdf del biglietto
   * 
   * @param html
   * @return
   * @throws IOException
   * @throws DocumentException
   */
  private File renderPdf(String html) throws IOException, DocumentException {
    File file = File.createTempFile("Ticket", ".pdf");
    OutputStream outputStream = new FileOutputStream(file);
    ITextRenderer renderer = new ITextRenderer(20f * 4f / 3f, 20);
    renderer.setDocumentFromString(html, new ClassPathResource(PDF_RESOURCES).getURL().toExternalForm());
    renderer.layout();
    renderer.createPDF(outputStream);
    outputStream.close();
    file.deleteOnExit();
    return file;
  }

  /**
   * fornisce il contesto del biglietto, ovvero il recupero delle informazioni
   * relative ai voli che l'utente vuole acquistare
   * 
   * @param l
   * @return
   */
  public Context getContext(long... l) {

    Context context = new Context();
    context.setVariable("flights", service.getOffers(l));
    return context;
  }

  /**
   * "riempie" il template del biglietto con le informazioni dei voli da
   * acquistare
   * 
   * @param context
   * @return
   */
  private String loadAndFillTemplate(Context context) {
    return this.templateEngine.process("Ticket_template", context);
  }

}