/**
 * 
 */
package com.yourcompany.demo.service;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

/**
 * @author wwadge
 *
 */

@Component
public class EmailService {

	private static final Logger logger = LoggerFactory.getLogger(EmailService.class);


	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	FreeMarkerConfigurer freeMarkerConfig;

	@Value("${email.fromEmailAddress}")
	private String fromEmailAddress;



	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}


	public void sendEmail(String email, String username, String subject, String templateFile, Map<String, ?> model) {

		MimeMessage msg = this.mailSender.createMimeMessage();
		// use the true flag to indicate you need a multipart message
		try{
			MimeMessageHelper helper = new MimeMessageHelper(msg, true);
			helper.setFrom(fromEmailAddress);
			helper.setSubject("Some subject prefix: " +subject);
			helper.setTo(email);


			Map<String, Object> tmpModel = new HashMap<String,Object>();
			tmpModel.put("placeholderExample", "someValue - possibly from engine");
			tmpModel.putAll(model);

			helper.setText(FreeMarkerTemplateUtils.processTemplateIntoString(
					freeMarkerConfig.getConfiguration().getTemplate(templateFile),tmpModel), true);
			this.mailSender.send(helper.getMimeMessage());
		}
		catch(Exception ex) {
			logger.error("Could not send email for template: "+templateFile+", to : "+email, ex);
		}
	}

}