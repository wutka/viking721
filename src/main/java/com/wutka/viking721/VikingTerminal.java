package com.wutka.viking721;

import javax.swing.*;
import java.awt.*;

public class VikingTerminal {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Viking 721 Terminal");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new BorderLayout());
        frame.add(new TerminalPanel());
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}
