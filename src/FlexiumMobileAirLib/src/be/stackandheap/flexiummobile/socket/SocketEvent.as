package be.stackandheap.flexiummobile.socket {

import flash.events.Event;

public class SocketEvent extends Event
{
    public static const CONNECTED:String = "connected";
    public static const RECEIVED_DATA:String = "receivedData";
    public static const CLOSED:String = "closed";
    public static const ERROR:String = "error";

    public var data:Object;

    public function SocketEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false):void
    {
        super(type, bubbles, cancelable);
        this.data = data;
    }

}
}
