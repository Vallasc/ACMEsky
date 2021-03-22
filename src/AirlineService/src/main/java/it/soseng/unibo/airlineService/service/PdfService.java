package it.soseng.unibo.airlineService.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.transaction.Transactional;

import com.lowagie.text.DocumentException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ClassLoaderTemplateResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;


import it.soseng.unibo.airlineService.repository.FlightOfferRepository;


@Service
public class PdfService {

  @Autowired
  private FlightOfferRepository repo;

  private TemplateEngine templateEngine;

    @Autowired
    public PdfService(TemplateEngine templateEngine) {
      this.templateEngine = templateEngine;
    }



  public File generatePdf() throws IOException, DocumentException {
    // FlightOffer o = repo.findById(id).get();
    String html = getContext();
    return renderPdf(html);
}


private File renderPdf(String html) throws IOException, DocumentException {
    File file = File.createTempFile("Ticket", ".pdf");
    OutputStream outputStream = new FileOutputStream(file);
    ITextRenderer renderer = new ITextRenderer(20f * 4f / 3f, 20);
    renderer.setDocumentFromString(html);
    renderer.layout();
    renderer.createPDF(outputStream);
    outputStream.close();
    file.deleteOnExit();
    return file;
}


private String getContext() {

  ClassLoaderTemplateResolver templateResolver = new ClassLoaderTemplateResolver();
  templateResolver.setSuffix(".html");
  templateResolver.setTemplateMode(TemplateMode.HTML);

  TemplateEngine templateEngine = new TemplateEngine();
  templateEngine.setTemplateResolver(templateResolver);

  Context context = new Context();
  context.setVariable("to", "Baeldung");

  return templateEngine.process("Ticket_template", context);
}


private String loadAndFillTemplate(Context context) {
    return templateEngine.process("Ticket_template", context);

}
}
