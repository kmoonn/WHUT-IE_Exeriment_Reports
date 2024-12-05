package user;

import index.indexUI;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Arrays;

public class LoginListener implements ActionListener {
    //为了将两个输入框中的内容传进监听器中，我们将两个输入框封装成一个类，作为监听器的成员变量，同时在登录和注册界面中，将输入框传入该类。
    RegistInput registInput = new RegistInput();
    LoginInput loginInput = new LoginInput();
    ArrayList<User> userList = new ArrayList<>();
    @Override
    public void actionPerformed(ActionEvent e){
        String action = e.getActionCommand();

        switch (action) {
            case "登录" -> {
                //没有被注册时，直接输出：用户名不存在
                if (userList.isEmpty()) {
                    JOptionPane.showMessageDialog(null, "用户名不存在！");
                }
                //将输入框中的字符串取出来放在name,pwd中
                String name = loginInput.getNameInput().getText();
                String pwd = Arrays.toString(loginInput.getPwdInput().getPassword());

                //遍历List集合，判断能否登录成功或登录失败的原因
                for (User u : userList) {
                    if (u.name.equals(name)) {
                        if (u.pwd.equals(pwd)) {
                            JOptionPane.showMessageDialog(null, "登录成功！！");
                            new indexUI().initUI();
                        } else {
                            JOptionPane.showMessageDialog(null, "密码错误！！");
                            break;
                        }
                    }
                }

            }
            case "注册" -> {
                RegistUI registUI = new RegistUI();
                registUI.initUI(this);
            }
            case "确定" -> {
                //输入框中的数据创建一个user对象，加入到List集合中
                String name = registInput.getNameInput().getText();
                String pwd = Arrays.toString(registInput.getPwdInput().getPassword());
                User user = new User(name, pwd);
                userList.add(user);
                JOptionPane.showMessageDialog(null, "注册成功！！");

            }
            case "取消" -> System.exit(0); //退出
        }

    }
}

