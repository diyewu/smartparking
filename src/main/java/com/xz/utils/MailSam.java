package com.xz.utils;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class MailSam {
	public MailSam(){
		
	}
	public static void sendTemple() throws MessagingException{
        // 创建Properties 类用于记录邮箱的一些属性
        final Properties props = new Properties();
        // 表示SMTP发送邮件，必须进行身份验证
        props.put("mail.smtp.auth", "true");
        //此处填写SMTP服务器
        props.put("mail.smtp.host", "smtp.qq.com");
        //端口号，QQ邮箱给出了两个端口，但是另一个我一直使用不了，所以就给出这一个587
        props.put("mail.smtp.port", "587");
        // 此处填写你的账号
        props.put("mail.user", "194973883@qq.com");
        // 此处的密码就是前面说的16位STMP口令
        props.put("mail.password", "bctxjkzoywyqbied");

        // 构建授权信息，用于进行SMTP进行身份验证
        Authenticator authenticator = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                // 用户名、密码
                String userName = props.getProperty("mail.user");
                String password = props.getProperty("mail.password");
                return new PasswordAuthentication(userName, password);
            }
        };
        // 使用环境属性和授权信息，创建邮件会话
        Session mailSession = Session.getInstance(props, authenticator);
        // 创建邮件消息
        MimeMessage message = new MimeMessage(mailSession);
        // 设置发件人
        InternetAddress form;
		try {
			form = new InternetAddress(props.getProperty("mail.user"));
	        message.setFrom(form);
	        // 设置收件人的邮箱
	        InternetAddress to = new InternetAddress("930725713@qq.com");
	        message.setRecipient(RecipientType.TO, to);
	
	        // 设置邮件标题
	        message.setSubject("测试邮件");
	
	        // 设置邮件的内容体
	        String content="尊敬的用户：<br/>您的验证码为：2BYP4uDM（60分钟内有效,区分大小写），为了保证您的账户安全，请勿向任何人提供此验证码。";
	        message.setContent(content, "text/html;charset=UTF-8");
	
	        // 最后当然就是发送邮件啦
	        Transport.send(message);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void send(String smtp,String port,String user,String pwd,String touser,String subject,String content) throws MessagingException{
		// 创建Properties 类用于记录邮箱的一些属性
		final Properties props = new Properties();
		// 表示SMTP发送邮件，必须进行身份验证
		props.put("mail.smtp.auth", "true");
		//此处填写SMTP服务器
		props.put("mail.smtp.host", smtp);
		//端口号，QQ邮箱给出了两个端口，但是另一个我一直使用不了，所以就给出这一个587
		props.put("mail.smtp.port", port);
		// 此处填写你的账号
		props.put("mail.user", user);
		// 此处的密码就是前面说的16位STMP口令
		props.put("mail.password", pwd);
		
		// 构建授权信息，用于进行SMTP进行身份验证
		Authenticator authenticator = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				// 用户名、密码
				String userName = props.getProperty("mail.user");
				String password = props.getProperty("mail.password");
				return new PasswordAuthentication(userName, password);
			}
		};
		// 使用环境属性和授权信息，创建邮件会话
		Session mailSession = Session.getInstance(props, authenticator);
		// 创建邮件消息
		MimeMessage message = new MimeMessage(mailSession);
		// 设置发件人
		InternetAddress form;
		try {
			form = new InternetAddress(props.getProperty("mail.user"));
			message.setFrom(form);
			// 设置收件人的邮箱
			InternetAddress to = new InternetAddress(touser);
			message.setRecipient(RecipientType.TO, to);
			
			// 设置邮件标题
			message.setSubject(subject);
			
			// 设置邮件的内容体
			message.setContent(content, "text/html;charset=UTF-8");
			
			// 最后当然就是发送邮件啦
			Transport.send(message);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		try {
			MailSam.sendTemple();
			System.out.println("发送成功");
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}


}
