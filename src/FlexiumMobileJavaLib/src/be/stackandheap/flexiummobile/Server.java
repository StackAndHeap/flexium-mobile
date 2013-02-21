package be.stackandheap.flexiummobile;

import be.stackandheap.flexiummobile.entity.AirAction;
import com.google.gson.Gson;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    private static ServerSocket serverSocket;
    private static Connection connection;
    private static Socket client;
    private int pause = 0;
    private Gson gson;

    public Server() {
        gson = new Gson();
    }
    public int getPause() {
        return pause;
    }
    public void setPause(int pause) {
        this.pause = pause;
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
    public AirAction call(AirAction action) throws Exception{
        Thread.sleep(getPause());

        String jsonAction = gson.toJson(action);
        connection.sendMessage(jsonAction);

        return readReturnAction();
    }
    public AirAction readReturnAction() throws Exception{
        //todo a lot here
        String returnVal = connection.in.readLine();
        AirAction action = gson.fromJson(returnVal, AirAction.class);
        return action;
    }
    public void close() throws Exception{
        serverSocket.close();
    }
}
