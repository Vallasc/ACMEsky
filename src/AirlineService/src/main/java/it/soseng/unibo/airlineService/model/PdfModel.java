package it.soseng.unibo.airlineService.model;

import com.lowagie.text.DocumentException;

import org.springframework.beans.factory.annotation.Autowired;
import org.thymeleaf.context.Context;
import org.xhtmlrenderer.pdf.ITextRenderer;
import org.thymeleaf.spring5.SpringTemplateEngine;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class PdfModel {

    @Autowired
    private SpringTemplateEngine templateEngine;


    public File generatePdf(FlightOffer o) throws IOException, DocumentException {
        Context context = getContext(o);
        String html = loadAndFillTemplate(context);
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


    private Context getContext(FlightOffer o) {

        Context context = new Context();
        context.setVariable("flight.id", o.getId());
        context.setVariable("flight.departure", o.getDeparture());
        context.setVariable("flight.departureTime", o.getDepartureTime());
        context.setVariable("flight.destinationTime", o.getDestinationTime());
        context.setVariable("flight.destination", o.getDestination());
        context.setVariable("flight.price", o.getPrice());
        return context;
    }

    private String loadAndFillTemplate(Context context) {
        return templateEngine.process("Ticket_template", context);
    }

}
