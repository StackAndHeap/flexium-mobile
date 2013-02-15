package be.stackandheap.flexiummobile {

import be.stackandheap.flexiummobile.actionregister.ActionRegister;
import be.stackandheap.flexiummobile.actions.Actions;
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.socket.*;
import flash.display.Sprite;
import mx.events.FlexEvent;

[Mixin]
public class FlexMobileAirLib extends Sprite {
    private static var airtester:FlexMobileAirLib;
    public static var application:Object;
    public var appParser:AppParser;
    private var actions:Actions;
    private var socketConnection:SocketConnection;

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
        application.removeEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
        appParser = new AppParser(application.getChildAt(0));
        appParser.setTooltipsToID();
        actions = new Actions(appParser);
        connectToServer();
    }

    private function connectToServer():void {
        //socketConnection = new SocketConnection("10.1.179.201",  4444);
        socketConnection = new SocketConnection("localhost",  4444);
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
        var stringToSend:String = ActionRegister.call(functionName,arguments);
        socketConnection.sendToSocket(stringToSend);
    }
}
}