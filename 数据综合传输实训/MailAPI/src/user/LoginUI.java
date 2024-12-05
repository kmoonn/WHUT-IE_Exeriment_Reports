package user;

import javax.swing.*;
import java.awt.*;

public class LoginUI {
    public void initUI(){
        JFrame jf = new JFrame("登录");
        jf.setSize(500,550);
        jf.setLocationRelativeTo(null);
        jf.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        FlowLayout flow = new FlowLayout();//使用流式布局
        jf.setLayout(flow);

        JPanel imPanel=(JPanel) jf.getContentPane();//注意内容面板必须强转为JPanel才可以实现下面的设置透明
        imPanel.setOpaque(false);//将内容面板设为透明

        //注意调整图片尺寸，图片比框体大的话会无法显示，此处图片尺寸为500*498。
        ImageIcon image = new ImageIcon("lib/images/login.png");
        JLabel imageJla = new JLabel(image);

        JLabel nameJla = new JLabel("账号：");
        JLabel pwdJla = new JLabel("密码：");

        //为输入框设置大小
        Dimension dim = new Dimension(400,35);
        JTextField nameInput = new JTextField();
        JPasswordField pwdInput = new JPasswordField();

        nameInput.setPreferredSize(dim);
        pwdInput.setPreferredSize(dim);

        JButton btn1 = new JButton("登录");
        JButton btn2 = new JButton("注册");

        jf.add(imageJla);
        jf.add(nameJla);
        jf.add(nameInput);
        jf.add(pwdJla);
        jf.add(pwdInput);
        jf.add(btn1);
        jf.add(btn2);
        //创建监听器
        LoginListener loginListener = new LoginListener();
        //将输入框传给监听器的成员变量loginInput
        loginListener.loginInput.setNameInput(nameInput);
        loginListener.loginInput.setPwdInput(pwdInput);
        //给按钮加上监听器
        btn1.addActionListener(loginListener);
        btn2.addActionListener(loginListener);
        jf.setVisible(true);  //可视化
    }

    public static void main(String[] args) {
        new LoginUI().initUI();
    }
}

