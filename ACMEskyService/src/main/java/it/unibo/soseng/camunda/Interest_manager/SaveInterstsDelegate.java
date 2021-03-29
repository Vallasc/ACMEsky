package it.unibo.soseng.camunda.Interest_manager;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("saveInterstsDelegate")
public class SaveInterstsDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SaveInterstsDelegate.class.getName());

    @Override
    public void execute(DelegateExecution execution){
      LOGGER.info("Execute");
    }
  
}
