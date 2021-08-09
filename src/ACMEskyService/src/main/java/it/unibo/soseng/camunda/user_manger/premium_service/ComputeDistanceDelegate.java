package it.unibo.soseng.camunda.user_manger.premium_service;

import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.distance.DistanceClient;
import it.unibo.soseng.gateway.distance.DistanceClient.GeoserverErrorException;
import it.unibo.soseng.gateway.distance.dto.DistanceDTO;
import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.logic.offer.OfferManager.DistanceServiceException;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ErrorsEvents.DISTANCE_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_ADDRESS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_DISTANCE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PREMIUM_SERVICE_ERROR;


@Named("computeDistanceDelegate")
public class ComputeDistanceDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(ComputeDistanceDelegate.class.getName());

    @Inject
    private OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute ComputeDistanceDelegate");
        AddressDTO address = (AddressDTO) execution.getVariable(USER_ADDRESS);
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(GENERATED_OFFER);
        try {
            float distance = offerManager.getDistance(address, offer);
            execution.setVariable(USER_DISTANCE, distance);
            LOGGER.info("Distance: " + String.valueOf(distance));
            execution.setVariable(PREMIUM_SERVICE_ERROR, false);

        } catch ( DistanceServiceException e) {
            LOGGER.severe(e.toString());
            execution.setVariable(PREMIUM_SERVICE_ERROR, true);
            throw new BpmnError(DISTANCE_ERROR);
        }
    }
  
}
