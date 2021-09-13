package it.unibo.soseng.gateway.rent;

import java.util.logging.Logger;

import javax.ejb.Stateless;

import it.unibo.soseng.model.User;
import it.unibo.soseng.ws.generated.BookRent;
import it.unibo.soseng.ws.generated.BookRentResponse;
import it.unibo.soseng.ws.generated.Rent;
import it.unibo.soseng.ws.generated.RentService1;
import it.unibo.soseng.ws.generated.RentService2;

/**
 * Questa classe elenca le richieste che il servizio effettua verso il servizio
 * di Rent.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Stateless
public class RentClient {
    private final static Logger LOGGER = Logger.getLogger(RentClient.class.getName());

    public BookRentResponse rentRequest(Rent rentService, BookRent request) {
        return rentService.bookRent(request);
    }

    /**
     * prenota i trasferimenti degli utenti dal loro indirizzo di residenza a quello
     * dell'aereoporto di partenza per l'andata, ma anche per trasferimenti di
     * ritorno
     * 
     * @param service
     * @param user
     * @param addressFrom
     * @param addressTo
     * @param arrivalDateTime
     * @return
     */
    public BookRentResponse bookRent(String service, User user, String addressFrom, String addressTo,
            String arrivalDateTime) {
        RentService1 rentService1;
        RentService2 rentService2;
        Rent ws;

        if (service == "RentGood") {
            rentService1 = new RentService1();
            ws = rentService1.getRentServicePort();
        } else {
            rentService2 = new RentService2();
            ws = rentService2.getRentServicePort();
        }

        BookRent bookRent = new BookRent();
        bookRent.setClientName(user.getName());
        bookRent.setClientSurname(user.getSurname());
        bookRent.setFromAddress(addressFrom);
        bookRent.setToAddress(addressTo);
        bookRent.setArrivalDateTime(arrivalDateTime);

        return rentRequest(ws, bookRent);
    }
}
