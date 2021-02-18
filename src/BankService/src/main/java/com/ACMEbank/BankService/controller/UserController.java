package com.ACMEbank.BankService.controller;

import javax.validation.Valid;

import com.ACMEbank.BankService.dto.UserRequestDTO;
import com.ACMEbank.BankService.model.User;
import com.ACMEbank.BankService.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @Autowired
    UserService userService;

    @GetMapping("/users/me")
    private ResponseEntity<User> getUser() {
        String userId = (String) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return new ResponseEntity<User>(userService.getUserByLoginId(userId), HttpStatus.OK);
    }

    @PostMapping("/users")
    private ResponseEntity<User> saveUser(@Valid @RequestBody UserRequestDTO userDTO) {
        User result = userService.register(userDTO);
        return new ResponseEntity<User>(result, HttpStatus.CREATED);
    }

}