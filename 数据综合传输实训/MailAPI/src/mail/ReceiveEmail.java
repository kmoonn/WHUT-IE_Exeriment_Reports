package mail;

import javax.mail.*;
import javax.mail.internet.*;
import javax.swing.*;
import java.awt.*;
import java.util.Properties;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;

public class ReceiveEmail extends JFrame {
    private final DefaultTableModel tableModel;
    private final JTable emailTable;

    public ReceiveEmail() {
        try {
            // 设置外观为 Nimbus
            UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
        } catch (Exception e) {
            e.printStackTrace();
        }

        setTitle("收件箱");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(1000, 600);

        String[] columnNames = {"发件人", "邮箱","主题", "发送日期", "邮件内容"};
        tableModel = new DefaultTableModel(columnNames, 0);
        emailTable = new JTable(tableModel);
        emailTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
        JScrollPane scrollPane = new JScrollPane(emailTable);
        add(scrollPane, BorderLayout.CENTER);

        fetchEmails(); // 获取邮件列表

        adjustColumnWidth(4, 500); // 调整邮件内容列的宽度
        adjustColumnWidth(3, 200); // 调整主题列的宽度
        adjustColumnWidth(2, 150); // 调整主题列的宽度

        setVisible(true);
    }

    private void adjustColumnWidth(int columnIndex, int width) {
        TableColumn column = emailTable.getColumnModel().getColumn(columnIndex);
        column.setPreferredWidth(width);
    }

    private void fetchEmails() {
        String host = "imap.qq.com";
        String username = "3453863492@qq.com"; // 替换为你的 QQ 邮箱
        String password = "nylidkclyffhcgjg"; // 替换为你的 QQ 邮箱密码

        Properties properties = new Properties();
        properties.put("mail.imap.host", host);
        properties.put("mail.imap.port", "993");
        properties.put("mail.imap.ssl.enable", "true");

        Session session = Session.getDefaultInstance(properties);
        try {
            Store store = session.getStore("imap");
            store.connect(host, username, password);

            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_ONLY);

            Message[] messages = inbox.getMessages();
            for (Message message : messages) {
                String[] fromDetails = getFromDetails(message);
                String subject = message.getSubject();
                String sentDate = message.getSentDate().toString();
                String content = getTextFromMessage(message);

                Object[] rowData = {fromDetails[0], fromDetails[1], subject, sentDate, content};
                tableModel.addRow(rowData);
            }

            inbox.close(false);
            store.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String[] getFromDetails(Message message) throws Exception {
        String[] fromDetails = new String[2];
        Address[] fromAddresses = message.getFrom();
        if (fromAddresses != null && fromAddresses.length > 0) {
            InternetAddress from = (InternetAddress) fromAddresses[0];
            fromDetails[0] = from.getPersonal() != null ? from.getPersonal() : "";
            fromDetails[1] = from.getAddress();
        }
        return fromDetails;
    }

    private String getTextFromMessage(Message message) throws Exception {
        String result = "";
        if (message.isMimeType("text/plain")) {
            result = message.getContent().toString();
        } else if (message.isMimeType("multipart/*")) {
            MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
            result = getTextFromMimeMultipart(mimeMultipart);
        }
        return result;
    }

    private String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws Exception {
        StringBuilder result = new StringBuilder();
        int count = mimeMultipart.getCount();
        for (int i = 0; i < count; i++) {
            BodyPart bodyPart = mimeMultipart.getBodyPart(i);
            if (bodyPart.isMimeType("text/plain")) {
                result.append("\n").append(bodyPart.getContent());
                break; // 只获取纯文本部分的内容
            } else if (bodyPart.isMimeType("text/html")) {
                // 如果需要 HTML 内容，可以选择处理
                String html = (String) bodyPart.getContent();
                result.append("\n").append(html);
            } else if (bodyPart.getContent() instanceof MimeMultipart) {
                result.append(getTextFromMimeMultipart((MimeMultipart) bodyPart.getContent()));
            }
        }
        return result.toString();
    }

    public static void receive() {
        SwingUtilities.invokeLater(ReceiveEmail::new);
    }
}
