package it.unibo.soseng.camunda;

public class SendTicketError extends Exception{

    public SendTicketError(String SendError) {
        super(SendError);

    }

}
