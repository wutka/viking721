package com.wutka.viking721;

import javax.swing.*;
import java.awt.*;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class VikingTerminal {
    public static void main(String[] args) {
        String host = "localhost";
        int port = 6610;

        if (args.length > 0) {
            host = args[0];
            if (args.length > 1) {
                try {
                    port = Integer.parseInt(args[1]);
                } catch (Exception exc) {
                    System.out.printf("Invalid port number %s\n", args[1]);
                    return;
                }
            }
        }

        InputStream sockIn;
        OutputStream sockOut;
        try {
            Socket sock = new Socket(host, port);
            sockIn = sock.getInputStream();
            sockOut = sock.getOutputStream();
        } catch (Exception exc) {
            System.out.printf("Error connecting to host %s port %d: %s\n",
                    host, port, exc.getMessage());
            return;
        }

        JFrame frame = new JFrame("Viking 721 Terminal");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new BorderLayout());
        frame.add(new TerminalPanel(sockIn, sockOut));
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}
