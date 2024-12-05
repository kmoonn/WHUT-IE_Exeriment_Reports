package mail;

import com.sun.mail.util.MailSSLSocketFactory;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.swing.*;
import java.awt.*;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.io.File;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Properties;


public class SendEmail {

    public static void send() {
        JFrame jFrame = new JFrame("发送邮件");
        jFrame.setBounds(500, 200, 600, 700);
        // 设置窗口不可拉伸
        jFrame.setResizable(false);
        jFrame.add(new SendPanel(jFrame));
        jFrame.setVisible(true);
        // 设置窗口关闭
        jFrame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    }
}

class SendPanel extends JPanel {
    private String EmailTo;
    private String Subject;
    private String Text;
    private String FileName;
    JFrame jFrame;
    public SendPanel(JFrame jFrame) {
        this.jFrame=jFrame;
        setBounds(0, 0, 600, 700);
        JLabel jLabelTo = new JLabel("收件人");
        jLabelTo.setLocation(100, 70);
        jLabelTo.setSize(50, 50);
        JTextField jTextFieldTo = new JTextField(1);
        jTextFieldTo.setLocation(150, 80);
        jTextFieldTo.setSize(300, 30);
        jTextFieldTo.setToolTipText("请输入收件人邮箱地址");
        jTextFieldTo.setText("请输入收件人邮箱地址");
        jTextFieldTo.setBackground(new Color(204, 204, 204));

        // 设置焦点监听
        jTextFieldTo.addFocusListener(new FocusListener(){
            @Override
            public void focusGained(FocusEvent e) {
                if ("请输入收件人邮箱地址".equals(jTextFieldTo.getText())){
                    jTextFieldTo.setText("");
                    jTextFieldTo.setBackground(Color.white);
                }
            }
            @Override
            public void focusLost(FocusEvent e) {
                if (jTextFieldTo.getText().isEmpty()){
                    jTextFieldTo.setText("请输入收件人邮箱地址");
                    jTextFieldTo.setBackground(new Color(204, 204, 204));
                }else {
                    EmailTo=jTextFieldTo.getText();
                    System.out.println(EmailTo);
                }
            }
        });
        JLabel jLabelSubject = new JLabel("主题");
        jLabelSubject.setLocation(110,150);
        jLabelSubject.setSize(50,50);
        JTextField jTextFieldSubject = new JTextField(1);
        jTextFieldSubject.setLocation(150, 160);
        jTextFieldSubject.setSize(300, 30);
        jTextFieldSubject.setToolTipText("请输入邮件主题");
        jTextFieldSubject.setText("请输入邮件主题");
        jTextFieldSubject.setBackground(new Color(204, 204, 204));
        // 设置焦点监听
        jTextFieldSubject.addFocusListener(new FocusListener(){

            @Override
            public void focusGained(FocusEvent e) {
                if ("请输入邮件主题".equals(jTextFieldSubject.getText())){
                    jTextFieldSubject.setText("");
                    jTextFieldSubject.setBackground(Color.white);
                }
            }
            @Override
            public void focusLost(FocusEvent e) {
                if (jTextFieldSubject.getText().isEmpty()){
                    jTextFieldSubject.setText("请输入邮件主题");
                    jTextFieldSubject.setBackground(new Color(204, 204, 204));
                }else {
                    Subject=jTextFieldSubject.getText();
                    System.out.println(Subject);
                }
            }
        });
        JLabel jLabelText = new JLabel("正文");
        jLabelText.setSize(50,50);
        jLabelText.setLocation(110,250);
        JTextArea jTextAreaText= new JTextArea();
        jTextAreaText.setSize(300,300);
        jTextAreaText.setLocation(150,250);
        jTextAreaText.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
            }
            @Override
            public void focusLost(FocusEvent e) {
                if (jTextAreaText.getText().isEmpty() && jTextFieldTo.getText().length()>1 && jLabelSubject.getText().length()>1){
                    JOptionPane.showMessageDialog(jTextAreaText,"输入内容为空","提示",JOptionPane.INFORMATION_MESSAGE);
                } else {
                    Text=jTextAreaText.getText();
                }
            }
        });
        JButton jButton=new JButton("发送");
        jButton.setSize(200,50);
        jButton.setLocation(390,600);
        jButton.addActionListener(e -> {
            try {

                if ("请输入QQ邮箱地址".equals(jTextFieldTo.getText())){
                    JOptionPane.showMessageDialog(jButton,"无收件人","提示",JOptionPane.ERROR_MESSAGE);

                }
                boolean state=SendMessageState(EmailTo,Subject,Text,FileName);
                if(state){
                    JOptionPane.showMessageDialog(jButton,"发送成功","提示",JOptionPane.INFORMATION_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(jButton,"发送失败","提示",JOptionPane.ERROR_MESSAGE);
                }

            } catch (GeneralSecurityException generalSecurityException) {
                generalSecurityException.printStackTrace();
            }
        });
        JButton jButtonSelectFile=new JButton("选择附件");
        jButtonSelectFile.setSize(200,50);
        jButtonSelectFile.setLocation(10,600);
        jButtonSelectFile.addActionListener(e -> {
            JFileChooser chooser = new JFileChooser();
            //设置选择目录
            chooser.setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);

            int reg = chooser.showOpenDialog(null);
            if(reg == JFileChooser.APPROVE_OPTION)
            {
                //获得选择到的文件
                File file = chooser.getSelectedFile();
                try {
                    FileName=file.getCanonicalPath();
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
                System.out.println(FileName);
            }
        });
        setLayout(null);
        add(jLabelTo);
        add(jTextFieldTo);
        add(jLabelSubject);
        add(jTextFieldSubject);
        add(jLabelText);
        add(jTextAreaText);
        add(jButton);
        add(jButtonSelectFile);
    }
    public static Boolean SendMessageState(String to,String subject,String text,String fileName) throws GeneralSecurityException {
        boolean state=false;
        // 收件人邮箱
        // 发件人邮箱
        String from="3453863492@qq.com";
        // 发送邮件的主机
        String host="smtp.qq.com";
        // 获取系统的属性
        Properties properties=System.getProperties();

        // 设置邮件服务器
        properties.setProperty("mail.smtp.host",host);
        // 需要验证用户名密码
        properties.put("mail.smtp.auth",true);

        // QQ邮箱使用SSL加密
        MailSSLSocketFactory mailSSLSocketFactory = new MailSSLSocketFactory();
        mailSSLSocketFactory.setTrustAllHosts(true);
        properties.put("mail.smtp.ssl.enable",true);
        properties.put("mail.smtp.ssl.socketFactory",mailSSLSocketFactory);
        Session session = Session.getDefaultInstance(properties, new Authenticator() {
            @Override
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication("3453863492@qq.com","nylidkclyffhcgjg") ;
            }
        });
        MimeMessage mimeMessage=new MimeMessage(session);
        try {
            // 发送方
            mimeMessage.setFrom(new InternetAddress(from));
            // 接受方
            mimeMessage.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(to));
            // 邮件的标题/主题
            mimeMessage.setSubject(subject);
            //创建消息部分
            MimeBodyPart MessagePart = new MimeBodyPart();
            //添加正文
            MessagePart.setText(text);
            // 创建多重消息
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(MessagePart);
            if (fileName!=null){
                // 截取路径后面的文件名称
                String name= fileName.substring(fileName.lastIndexOf("\\")+1);
                System.out.println(name);
                MessagePart=new MimeBodyPart();
                FileDataSource fileDataSource = new FileDataSource(fileName);
                MessagePart.setDataHandler(new DataHandler(fileDataSource));
                MessagePart.setFileName(name);
                multipart.addBodyPart(MessagePart);
            }
            // 发送完整消息
            mimeMessage.setContent(multipart);
            // 发送信息
            Transport.send(mimeMessage);
            state= true;

        } catch (MessagingException e) {
            e.printStackTrace();
        }
        System.out.println(state);
        return state;
    }
}