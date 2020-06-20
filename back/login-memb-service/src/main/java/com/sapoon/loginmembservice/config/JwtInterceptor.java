package com.sapoon.loginmembservice.config;

import com.sapoon.loginmembservice.common.exception.UnauthorizedException;
import com.sapoon.loginmembservice.controller.LoginMemberController;
import com.sapoon.loginmembservice.service.JwtService;
import lombok.SneakyThrows;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class JwtInterceptor implements HandlerInterceptor {
    private static final String HEADER_AUTH = "Authorization";

    Logger logger = LoggerFactory.getLogger(JwtInterceptor.class);

    @Autowired
    private JwtService jwtService;

    @SneakyThrows
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        logger.info("Jwtinterceptor - prehandle requestURI : " +  request.getRequestURI());
        final String token = request.getHeader(HEADER_AUTH);

        if(token != null && jwtService.isUsable(token)){
            return true;
        }else{
            response.setStatus(400);
            return false;
        }

    }
}
