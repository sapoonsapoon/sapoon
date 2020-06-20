package com.sapoon.loginmembservice.service;

import com.sapoon.loginmembservice.vo.MemberInfoVO;
import com.sun.mail.util.logging.MailHandler;
import lombok.AllArgsConstructor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class MailService {
    @Autowired
    private JavaMailSender javaMailSender;

    Logger logger = LoggerFactory.getLogger(MailService.class);

    public void mailSender(String to, String subject, String text) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");

            message.setContent(text,"text/html; charset=UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);

            logger.info("send email subject : {}, to : {}",subject, to);
            javaMailSender.send(message);
        }catch (MailException | MessagingException e){
            e.printStackTrace();
        }
    }

    public String MakeChangePasswordMsg(MemberInfoVO memberInfoVO){
        String password = memberInfoVO.getPassword();
        String name = memberInfoVO.getName();

        StringBuilder builder = new StringBuilder();
        builder.append("<div>");
        builder.append(name + "님 안녕하세요.");
        builder.append("<br>");
        builder.append("변경된 패스워드는 <b> " + password + " </b> 입니다.");
        builder.append("<br>");
        builder.append("감사합니다.");
        builder.append("</div>");

        return builder.toString();
    }
}
