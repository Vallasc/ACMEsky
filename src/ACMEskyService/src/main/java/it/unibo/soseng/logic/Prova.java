package it.unibo.soseng.logic;

import javax.inject.Singleton;
import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class Prova {
    private int n = 99;

    @PostConstruct
    public void afterCreate() {
        System.out.println("PROVA created");
    }

    public int getN() {
        return n;
    }

    public void setN(int n) {
        this.n = n;
    }
}
