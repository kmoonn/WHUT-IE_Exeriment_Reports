package user;

import javax.swing.*;
import java.awt.*;

/**
 * 设计逻辑与登录界面基本相同
 */
public class RegistUI {
    public void initUI(LoginListener loginListener){
        JFrame jf = new JFrame("注册");
        jf.setSize(500,550);
        jf.setLocationRelativeTo(null);
        jf.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
        FlowLayout flow = new FlowLayout();
        jf.setLayout(flow);

        ImageIcon image = new ImageIcon("lib/images/register.png");

        JLabel nameJla = new JLabel("请输入账号：");
        JLabel pwdJla = new JLabel("请输入密码：");
        JLabel imageJla = new JLabel(image);

        Dimension dim = new Dimension(340,35);

        JTextField nameInput = new JTextField();
        JPasswordField pwdInput = new JPasswordField();
        nameInput.setPreferredSize(dim);
        pwdInput.setPreferredSize(dim);

        JButton btn1 = new JButton("确定");
        JButton btn2 = new JButton("取消");

        jf.add(imageJla);
        jf.add(nameJla);
        jf.add(nameInput);
        jf.add(pwdJla);
        jf.add(pwdInput);
        jf.add(btn1);
        jf.add(btn2);
        //将输入框传给监听器的成员变量registInput
        loginListener.registInput.setNameInput(nameInput);
        loginListener.registInput.setPwdInput(pwdInput);

        btn1.addActionListener(loginListener);
        btn2.addActionListener(loginListener);
        jf.setVisible(true);
    }

}

