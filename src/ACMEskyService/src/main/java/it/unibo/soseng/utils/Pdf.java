package it.unibo.soseng.utils;

import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.ws.generated.BookRentResponse;

import java.nio.charset.StandardCharsets;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.logging.Logger;
import java.text.SimpleDateFormat;
import java.util.UUID;
import java.io.IOException;

import javax.ejb.Stateless;

import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.utils.PdfMerger;

@Stateless
public class Pdf {
    private final static Logger LOGGER = Logger.getLogger(Pdf.class.getName());
    
    public void makePdf(GeneratedOffer offer, BookRentResponse rent1, BookRentResponse rent2) {
        InputStream is = getClass().getClassLoader().getResourceAsStream("/template/invoice.html"); 

        try{
            String content = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            content = content.replace("{{name}}", offer.getUser().getName());
            content = content.replace("{{surname}}", offer.getUser().getSurname());
            content = content.replace("{{orderToken}}", offer.getToken());

            SimpleDateFormat formatter= new SimpleDateFormat("dd/MM/yyyy");
            Date date = new Date(System.currentTimeMillis());
            content = content.replace("{{date}}", formatter.format(date));

            content = content.replace("{{row1}}", tableRow(offer.getOutboundFlight().toString(),
                                                            UUID.randomUUID().toString().substring(0, 4) +
                                                            offer.getOutboundFlight().getFlightCode(),
                                                            String.format ("%.2f", offer.getOutboundFlight().getPrice())));
            content = content.replace("{{row2}}", tableRow(offer.getFlightBack().toString(),
                                                            UUID.randomUUID().toString().substring(0, 4) +
                                                            offer.getFlightBack().getFlightCode(),
                                                            String.format ("%.2f", offer.getFlightBack().getPrice())));
            if(rent1 != null){
                content = content.replace("{{row3}}", tableRow("Noleggio con autista (Andata)",
                                                                rent1.getRentId(),"0.00"));
            } else {
                content = content.replace("{{row3}}", "");
            }
            if(rent2 != null){
                content = content.replace("{{row4}}", tableRow("Noleggio con autista (Ritorno)",
                                                                rent2.getRentId(),"0.00"));
            } else {
                content = content.replace("{{row4}}", "");
            }

            content = content.replace("{{subtotal}}", String.format ("%.2f", offer.getTotalPrice()));
            content = content.replace("{{serviceCost}}", "10.00");
            content = content.replace("{{total}}", String.format ("%.2f", offer.getTotalPrice() + 10));


            HtmlConverter.convertToPdf(content, new FileOutputStream(offer.getToken() + "_tmp2.pdf"));
        } catch (Exception e) {
            LOGGER.severe(e.toString());
            e.printStackTrace();
        }
    }   
    
    private String tableRow(String desc, String id, String amt){
        return "<tr class='item'><td class='desc'>" + desc + "</td>" +
        "<td class='id num'>" + id + "</td><td class='amt'>€" + amt + "</td></tr>";
    }

    public void mergePdf(String src1, String src2, String dest) throws IOException {
        PdfDocument pdf = new PdfDocument(new PdfWriter(dest));
        PdfMerger merger = new PdfMerger(pdf);

        //Add pages from the first document
        PdfDocument firstSourcePdf = new PdfDocument(new PdfReader(src1));
        merger.merge(firstSourcePdf, 1, firstSourcePdf.getNumberOfPages());

        //Add pages from the second pdf document
        PdfDocument secondSourcePdf = new PdfDocument(new PdfReader(src2));
        merger.merge(secondSourcePdf, 1, secondSourcePdf.getNumberOfPages());

        firstSourcePdf.close();
        secondSourcePdf.close();
        pdf.close();
    }
}
