package be.stackandheap.flexiummobile;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

public class Connection {
    private Socket client = null;
    private OutputStreamWriter oos = null;
    public BufferedReader in = null;

    public Connection(Socket clientSocket) {
        client = clientSocket;
        try {
            in = new BufferedReader(new InputStreamReader(client.getInputStream()));
            oos = new OutputStreamWriter(client.getOutputStream());
        } catch (Exception e1) {
            System.out.println(e1);
            killSocket();
        }
    }
    public void sendMessage(String msg) {
        try {
            oos.write(msg);
            oos.flush();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    public void killSocket(){
        try {
            client.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
