package be.stackandheap.flexiummobile;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    private static ServerSocket serverSocket;
    private static Connection connection;
    private static Socket client;
    private int pause = 0;

    public Server() {
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
    public JSONObject call(String functionName,String args) throws Exception{
        Thread.sleep(getPause());
        String msg;
        msg = (args == null) ? functionName:functionName + ":" + args;
        connection.sendMessage(msg);

        String returnVal = connection.in.readLine();
        JSONObject jsonObject = (JSONObject)new JSONParser().parse(returnVal);
        System.out.println(jsonObject.get("succes"));
        System.out.println(jsonObject.get("id"));

        if((Boolean)jsonObject.get("succes") == false){
            throw new Exception("Action failed: "+jsonObject.get("message"));
        }
        return jsonObject;
    }
    public JSONObject call(String functionName) throws Exception{
        return call(functionName,null);
    }
    public void close() throws Exception{
        serverSocket.close();
    }
}
