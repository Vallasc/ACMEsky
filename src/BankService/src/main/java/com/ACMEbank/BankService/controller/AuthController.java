package com.ACMEbank.BankService.controller;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.validation.Valid;

import com.ACMEbank.BankService.dto.AuthRequestDTO;
import com.ACMEbank.BankService.dto.AuthResponseDTO;
import com.ACMEbank.BankService.model.User;
import com.ACMEbank.BankService.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@RestController
@RequestMapping("/")
public class AuthController {

    @Value( "${server.JWTsecret}" )
	private String SECRET;

    @Autowired
    private UserService userService;

    @PostMapping("/auth")
    public ResponseEntity<AuthResponseDTO> auth(@Valid @RequestBody AuthRequestDTO request) throws ServletException {

        User authUser = userService.findByLogin(request.userId, request.password);

        if(authUser == null) {
            throw new ServletException("User not present!");
        }

        /*String token = Jwts.builder().
            setSubject(authUsuario.getLogin()).
            signWith(SignatureAlgorithm.HS512, TOKEN_KEY).
            setExpiration(new Date(System.currentTimeMillis() + 1 * 60 * 1000))
            .compact();*/

        String token = getJWTToken(authUser.getLoginId());
		return new ResponseEntity<AuthResponseDTO>(new AuthResponseDTO(token), HttpStatus.OK);

    }

    private String getJWTToken(String userId) {
		List<GrantedAuthority> grantedAuthorities = AuthorityUtils
				.commaSeparatedStringToAuthorityList("ROLE_USER");
		
		String token = Jwts
				.builder()
				.setId("bankJWT")
				.setSubject(userId)
				.claim("authorities",
						grantedAuthorities.stream()
								.map(GrantedAuthority::getAuthority)
								.collect(Collectors.toList()))
				.setIssuedAt(new Date(System.currentTimeMillis()))
				.setExpiration(new Date(System.currentTimeMillis() + 600000)) // 10 minuti
				.signWith(SignatureAlgorithm.HS512,
						SECRET.getBytes()).compact();

		return "Bearer " + token;
	}


}