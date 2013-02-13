package be.stackandheap.flexiummobile;

import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    private static ServerSocket serverSocket;
    private static Connection connection;
    private static Socket client;

    public Server() {
    }
    public void start(int port) throws Exception{
        try{
            serverSocket = new ServerSocket(port);
            System.out.println("Server listening on port: "+port);
            System.out.println("Waiting for connections");
            client = serverSocket.accept();
            System.out.println("Accepted a connection from: " + client.getInetAddress());
            connection = new Connection(client);
        }catch (Exception e){
             throw new Exception("connection failed ",e);
        }

    }
    public String call(String functionName,String args) throws Exception{
        connection.sendMessage(functionName + ":" + args);
        return connection.in.readLine();
    }
    public String call(String functionName,String args,int pause) throws Exception{
        Thread.sleep(pause);
        return call(functionName,args);
    }
    public void close() throws Exception{
        serverSocket.close();
    }
}
