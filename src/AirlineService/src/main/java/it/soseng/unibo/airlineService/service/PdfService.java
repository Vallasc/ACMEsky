package it.soseng.unibo.airlineService.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

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



@Service
public class PdfService {


  private SpringTemplateEngine templateEngine;

  private FlightOfferService service;

  private static final String PDF_RESOURCES = "/pdf-resources/";


    @Autowired
    public PdfService(SpringTemplateEngine templateEngine, FlightOfferService service) {
      this.service = service;
      this.templateEngine = templateEngine;
    }
    
    public File generatePdf(long ... id) throws IOException, DocumentException {
      Context context = getContext(id);
      String html = loadAndFillTemplate(context);
      return renderPdf(html);
  }


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


  public Context getContext(long ... l) {

      Context context = new Context();
      this.templateEngine.addDialect(new Java8TimeDialect());
      context.setVariable("flights", service.getOffers(l));
      return context;
    }

  private String loadAndFillTemplate(Context context) {
      return templateEngine.process("Ticket_template", context);
  }

  public void sendPdfs(long...id){

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

    HttpEntity<MultiValueMap<String, Object>> requestEntity= new HttpEntity<>(body, headers);

    String serverUrl = "http://localhost:8080/OfferPdfFiles";

    RestTemplate restTemplate = new RestTemplate();
    ResponseEntity<String> response = restTemplate
      .postForEntity(serverUrl, requestEntity, String.class);
  }



}
