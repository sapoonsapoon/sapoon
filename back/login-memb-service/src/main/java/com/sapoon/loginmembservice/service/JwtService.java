package com.sapoon.loginmembservice.service;

import com.sapoon.loginmembservice.common.exception.UnauthorizedException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class JwtService {
    private static final String SALT = "greenFactory";

    public String create(HashMap<String, Object> data) throws UnsupportedEncodingException{
        Date expiredTime = new Date();
        expiredTime.setTime(expiredTime.getTime() - 1000 * 60 * 60 * 24);
        //data.put("exp", expiredTime);
        String Jwt = Jwts.builder()
                    .setHeaderParam("typ", "JWT")
                    .setHeaderParam("regDate",System.currentTimeMillis())
                    .setClaims(data)
                    .setExpiration(expiredTime)
                    .signWith(SignatureAlgorithm.HS256, generateKey())
                    .compact();

        return Jwt;
    }

    private byte[] generateKey() throws UnsupportedEncodingException{
        byte[] key = null;
        try {
            key = SALT.getBytes("UTF-8");
        }catch (UnsupportedEncodingException e){
            throw new UnsupportedEncodingException();
        }
        return key;
    }

    public Boolean isUsable(String jwt){
        try {
            Jws<Claims> claims = Jwts.parser()
                    .setSigningKey(this.generateKey())
                    .parseClaimsJws(jwt);
            return true;
        }catch (Exception e){
            System.out.println(e.getMessage());
            return false;
        }
    }

    public Map<String, Object> get(String key) throws UnauthorizedException {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        String jwt = request.getHeader("Authorization");
        Jws<Claims> claims = null;
        try {
            claims = Jwts.parser()
                    .setSigningKey(SALT.getBytes("UTF-8"))
                    .parseClaimsJws(jwt);
        } catch (Exception e) {
            throw new UnauthorizedException();
        }
        @SuppressWarnings("unchecked")
        Map<String, Object> value = (LinkedHashMap<String, Object>)claims.getBody().get(key);
        return value;
    }
}
