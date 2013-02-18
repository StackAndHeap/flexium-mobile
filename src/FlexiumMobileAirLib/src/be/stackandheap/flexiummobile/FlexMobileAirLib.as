package be.stackandheap.flexiummobile {

import be.stackandheap.flexiummobile.actionregister.ActionRegister;
import be.stackandheap.flexiummobile.actions.Actions;
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.socket.*;
import flash.display.Sprite;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import mx.events.FlexEvent;

[Mixin]
public class FlexMobileAirLib extends Sprite {
    public static var airtester:FlexMobileAirLib;
    public static var application:Object;
    public var appParser:AppParser;
    public var actions:Actions;
    public var socketConnection:SocketConnection;
    public var config:XML;

    public function FlexMobileAirLib(app:Object) {
        super();
        app.addEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
    }


    public static function init(systemRoot:Object):void {
        if(!airtester) {
            application = systemRoot;
            airtester = new FlexMobileAirLib(systemRoot);
        }
    }

    private function applicationCompleteHandler(event:FlexEvent):void {
        try{
            var file:File = File.applicationDirectory.resolvePath( "config.xml" );
            var stream:FileStream = new FileStream();
            stream.open( file, FileMode.READ );
            config = new XML( stream.readUTFBytes( stream.bytesAvailable ));
            stream.close();
        }catch(e:Error){
            trace('No config file found in source folder, loading defaults...');
            config = new XML();
            config.server = "localhost";
            config.port = "4444";
            config.enableFlexium = "true";
        }

        if(config.enableFlexium=='true'){
            application.removeEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
            appParser = new AppParser(application.getChildAt(0));
            appParser.setTooltipsToID();
            actions = new Actions(appParser);
            connectToServer();
        }
    }

    private function connectToServer():void {
        //socketConnection = new SocketConnection("10.1.179.201",  4444);
        //socketConnection = new SocketConnection("87.64.218.110",  4444);
        //socketConnection = new SocketConnection("192.168.1.5",  4444);
        socketConnection = new SocketConnection(config.server,  config.port);
        socketConnection.addEventListener(SocketEvent.CONNECTED, socketConnectHandler);
        socketConnection.addEventListener(SocketEvent.RECEIVED_DATA, socketDataReceivedHandler);
        socketConnection.addEventListener(SocketEvent.CLOSED, socketClosedHandler);
        socketConnection.addEventListener(SocketEvent.ERROR, socketErrorHandler);
        socketConnection.connect();
    }

    private function socketErrorHandler(event:SocketEvent):void {
        trace('error: '+event.data);
    }
    private function socketClosedHandler(event:SocketEvent):void {
        trace('server closed');
    }
    private function socketConnectHandler(event:SocketEvent):void {
        trace('connected');
    }
    private function socketDataReceivedHandler(event:SocketEvent):void {
        var receivedString:String = event.data.toString();
        trace('data receivedString: ' + receivedString);

        var command:Array = receivedString.split(":");
        var functionName:String = command[0];
        var arguments:String = command[1];
        var stringToSend:String = JSON.stringify(ActionRegister.call(functionName,arguments));
        socketConnection.sendToSocket(stringToSend);
    }
}
}