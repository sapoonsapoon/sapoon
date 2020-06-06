package com.sapoon.loginmembservice.util;

import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class ValidChecker {
    public boolean validcheck(String Keys, HashMap<String, Object> values){

        StringTokenizer st = new StringTokenizer(Keys, ";");

        while (st.hasMoreTokens()){
            if (values.get(st.nextToken()) == null){
                return false;
            }
        }

        return true;
    }
}
