package index;

import mail.ReceiveEmail;
import mail.SendEmail;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class indexUI {
    public void initUI(){
        JFrame jf = new JFrame("首页");
        jf.setSize(500,450);
        jf.setLocationRelativeTo(null);
        jf.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        JMenuBar menuBar = new JMenuBar();
        //给菜单加上监听器
        JMenuItem inboxMenuItem = new JMenuItem("收件箱");
        inboxMenuItem.addActionListener(new MenuActionListener("收件箱"));

        JMenuItem composeMenuItem = new JMenuItem("发邮件");
        composeMenuItem.addActionListener(new MenuActionListener("发邮件"));

        JMenuItem exitMenuItem = new JMenuItem("退出");
        exitMenuItem.addActionListener(new MenuActionListener("退出"));

        menuBar.add(inboxMenuItem);
        menuBar.add(composeMenuItem);
        menuBar.add(exitMenuItem);
        jf.setJMenuBar(menuBar);

        FlowLayout flow = new FlowLayout();//使用流式布局
        jf.setLayout(flow);

        ImageIcon image = new ImageIcon("lib/images/index.png");
        JLabel imageJla = new JLabel(image);
        jf.add(imageJla);

        jf.setVisible(true);  //可视化
    }
    static class MenuActionListener implements ActionListener {
        private final String menuName;

        MenuActionListener(String menuName) {
            this.menuName = menuName;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            if(menuName.equals("收件箱")){
                ReceiveEmail.receive();
                JOptionPane.showMessageDialog(null, "正在获取邮件,请稍等...");
            } else if (menuName.equals("发邮件")) {
                SendEmail.send();
            }
            else{
                    System.exit(0); //退出
            }
        }
    }

    public static void main(String[] args) {
        new indexUI().initUI();
    }
}
