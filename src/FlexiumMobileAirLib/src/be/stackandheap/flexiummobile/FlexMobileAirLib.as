package be.stackandheap.flexiummobile {

import be.stackandheap.flexiummobile.actionregister.ActionRegister;
import be.stackandheap.flexiummobile.actions.Actions;
import be.stackandheap.flexiummobile.entity.AirAction;
import be.stackandheap.flexiummobile.parser.StageParser;
import be.stackandheap.flexiummobile.socket.*;
import be.stackandheap.flexiummobile.utils.Errors;
import flash.display.Sprite;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import mx.events.FlexEvent;

[Mixin]
public class FlexMobileAirLib extends Sprite {
    public static var airtester:FlexMobileAirLib;
    public static var application:Object;
    public var stageParser:StageParser;
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
        loadConfigFile();
        if(config.enableFlexium=='true'){
            application.removeEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
            stageParser = new StageParser();
            actions = new Actions(stageParser);
            connectToServer();
        }
//        var recorder:Recorder = new Recorder(application);
    }

    private function loadConfigFile():void {
        var file:File = File.applicationDirectory.resolvePath( "config.xml" );
        var stream:FileStream = new FileStream();
        try{
            stream.open( file, FileMode.READ );
            config = new XML( stream.readUTFBytes( stream.bytesAvailable ));
            stream.close();
            trace('config found');
        }catch(e:Error){
            trace('No config file found in source folder, loading defaults...');
            createNewConfigFile(file);
        }
    }

    private function createNewConfigFile(file:File):void {
        var stream:FileStream = new FileStream();
        var newFile:File = new File( file.nativePath );
        stream.open(newFile, FileMode.WRITE);
        config = new XML("<?xml version='1.0' encoding='ISO-8859-1'?><config><server>localhost</server><port>4444</port><enableFlexium>true</enableFlexium></config>");
        stream.writeUTFBytes(config);
        stream.close();
    }

    private function connectToServer():void {

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
        trace('data receivedString: ' + event.data.toString());
        var returnAction:AirAction = executeAction(event.data.toString());
        if(returnAction.element != null)
            returnAction.element = returnAction.element.id;

        var stringToSend:String = JSON.stringify(returnAction);
        socketConnection.sendToSocket(stringToSend);
    }

    private function executeAction(jsonString:String):AirAction {
        var receivedAction:AirAction = new AirAction();
        var obj:Object = JSON.parse(jsonString);

        receivedAction.name = obj.name;
        receivedAction.args = obj.args;
        if (obj.element != null){
            try{
                var element:Object = stageParser.getElementById(obj.element);
                receivedAction.element = element;
            }catch(e:Error){
                receivedAction.message = Errors.OBJECT_NOT_FOUND;
                receivedAction.succes = false;
                return receivedAction;
            }
        }
        return ActionRegister.call(receivedAction);
    }
}
}