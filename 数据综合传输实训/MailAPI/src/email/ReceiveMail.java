package email;

import java.text.SimpleDateFormat;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeUtility;

import com.sun.mail.util.MailSSLSocketFactory;


public class ReceiveMail {

	public static void main(String[] args) throws Exception {
		//// 定义连接POP3服务器的属性信息
		String host = "pop.qq.com";
		String user = "3453863492@qq.com";
		// QQ邮箱的SMTP的授权码
		String pwd = "nylidkclyffhcgjg";
		String protocol = "pop3";
		Properties props = new Properties();
		// 使用的协议（JavaMail规范要求）
		props.setProperty("mail.store.protocal", protocol);
		// 发件人的邮箱的 SMTP服务器地址
		props.setProperty("mail.pop3.host", host);
		// QQ邮箱，设置SSL加密(必须要加密)
		MailSSLSocketFactory sf = new MailSSLSocketFactory();
		sf.setTrustAllHosts(true);
		props.put("mail.pop3.ssl.enable", "true");
		props.put("mail.pop3.ssl.socketFactory", sf);
		// 获取默认session对象
		Session session = Session.getDefaultInstance(props);
		session.setDebug(false);
		// 获取Store对象
		Store store = session.getStore(protocol);
		// POP3服务器的登陆认证
		store.connect(host, user, pwd);
		// 获得用户的邮件帐户
		Folder folder = store.getFolder("INBOX");
		// 设置对邮件帐户的访问权限
		folder.open(Folder.READ_WRITE);
		// 得到邮箱帐户中的所有邮件
		Message[] messages = folder.getMessages();
		// 打印收件箱邮件部分信息
		int length = messages.length;
		System.out.println("收件箱的邮件数：" + length);
		System.out.println("-------------------------------------------\n");
		for (int i = 0; i < length; i++) {
			// 解决Folder is not Open的问题
			if (!messages[i].getFolder().isOpen()) // 判断是否open
				messages[i].getFolder().open(Folder.READ_WRITE); // 如果close，就重新open
			String from = MimeUtility.decodeText(messages[i].getFrom()[0].toString());
			InternetAddress ia = new InternetAddress(from);
			System.out.println("发件人：" + ia.getPersonal() + '<' + ia.getAddress() + '>');
			System.out.println("主题：" + messages[i].getSubject());
			System.out.println("邮件大小：" + messages[i].getSize());
			System.out
					.println("邮件发送时间:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(messages[i].getSentDate()));
			// 如果该邮件是组合型"multipart/*"则可能包含附件等
			Message msg = messages[i];
			if (msg.isMimeType("multipart/alternative")) {
				Multipart mp = (Multipart) msg.getContent();
				int bodynum = mp.getCount();
				for (int j = 0; j < bodynum; j++) {
					if (mp.getBodyPart(j).isMimeType("text/html")) {
						String content = (String) mp.getBodyPart(j).getContent();
						System.out.println("邮件内容：" + content);
					}
				}
				System.out.println("-------------------------------------------\n");
			}
			folder.close(false);// 关闭邮件夹对象
			store.close(); // 关闭连接对象
		}
	}

}
