package it.soseng.unibo.airlineService.DTO;

import javax.validation.constraints.NotBlank;

public class AuthRequest {
    
    @NotBlank(message = "user is mandatory")
    private String user;

    @NotBlank(message = "pass is mandatory")
    private String pass;

    
    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
}
