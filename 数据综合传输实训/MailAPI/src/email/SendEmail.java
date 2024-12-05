package email;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.security.GeneralSecurityException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import com.sun.mail.util.MailSSLSocketFactory;

public class SendEmail {

	public static void main(String[] args) throws IOException {

		// 收件人邮箱
		String[] to = { "2438257908@qq.com"};
		// 发件人邮箱
		String from = "3453863492@qq.com";
		// 指定发送邮件的主机为 smtp.qq.com
		String host = "smtp.qq.com"; // QQ 邮件服务器
		// 获取系统属性
		Properties properties = System.getProperties();
		// 设置邮件服务器
		properties.setProperty("mail.smtp.host", host);
		properties.put("mail.smtp.auth", "true");
		// QQ邮箱，设置SSL加密
		MailSSLSocketFactory sf;
		try {
			sf = new MailSSLSocketFactory();
			sf.setTrustAllHosts(true);
			properties.put("mail.smtp.ssl.enable", "true");
			properties.put("mail.smtp.ssl.socketFactory", sf);
		} catch (GeneralSecurityException e1) {
			e1.printStackTrace();
		}
		// 获取默认session对象
		Session session = Session.getDefaultInstance(properties, new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				// 发件人邮件用户名、授权码
				return new PasswordAuthentication("3453863492@qq.com", "nylidkclyffhcgjg");
			}
		});

		try {
			// 创建默认的 MimeMessage 对象
			MimeMessage message = new MimeMessage(session);
			// 设置发件人的昵称
			String nick = MimeUtility.encodeText("Bounds");
			// Set From: 设置发件人地址
			message.setFrom(new InternetAddress(nick + " <" + from + ">"));
			// 解析一组收件人的地址
			InternetAddress[] address = new InternetAddress[to.length];
			for (int i = 0; i < to.length; i++) {
				address[i] = new InternetAddress(to[i]);
			}
			// Set To: 设置收件人地址 ，TO代表邮件的主要接受者，CC代表邮件的抄送接收者，BCC代表邮件的暗送接受者
			message.addRecipients(Message.RecipientType.BCC, address);
			// Set Subject: 设置头部字段
			message.setSubject("这是邮件的主题。。。");
			// 设置发送日期
			message.setSentDate(new Date());
			// 创建消息部分
			BodyPart messageBody = new MimeBodyPart();
			// 消息
			messageBody.setText("这里是邮件的内容。。。");
			// 创建多重消息
			Multipart multipart = new MimeMultipart();
			// 设置附件部分
			messageBody = new MimeBodyPart();
			File file = new File("file.txt");
			FileOutputStream fos = new FileOutputStream(file);
			OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
			osw.write("这是一封邮件。。。");
			osw.close();
			fos.close();
			// 封装文件的简单 DataSource 对象
			DataSource source = new FileDataSource(file);
			// 返回与此 DataHandler 实例关联的 DataSource
			messageBody.setDataHandler(new DataHandler(source));
			messageBody.setFileName(file.getName());
			// 设置消息部分
			multipart.addBodyPart(messageBody);
			// 发送完整消息
			message.setContent(multipart);
			// 发送消息
			Transport.send(message);
			System.out.println("Send message successfully...");

		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

}
