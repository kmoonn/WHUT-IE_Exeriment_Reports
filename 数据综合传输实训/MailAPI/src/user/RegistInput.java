package user;

import javax.swing.*;

public class RegistInput {
    JTextField nameInput = null;
    JPasswordField pwdInput = null;

    public JTextField getNameInput() {
        return nameInput;
    }

    public void setNameInput(JTextField nameInput) {
        this.nameInput = nameInput;
    }

    public JPasswordField getPwdInput() {
        return pwdInput;
    }

    public void setPwdInput(JPasswordField pwdInput) {
        this.pwdInput = pwdInput;
    }
}

