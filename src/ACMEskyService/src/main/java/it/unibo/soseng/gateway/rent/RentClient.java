package it.unibo.soseng.gateway.rent;

import java.util.logging.Logger;

import javax.ejb.Stateless;

import it.unibo.soseng.ws.generated.BookRent;
import it.unibo.soseng.ws.generated.BookRentResponse;
import it.unibo.soseng.ws.generated.Rent;

@Stateless
public class RentClient {
    private final static Logger LOGGER = Logger.getLogger(RentClient.class.getName());

    public BookRentResponse rentRequest(Rent rentService, BookRent request) {
        return rentService.bookRent(request);
    }
}
