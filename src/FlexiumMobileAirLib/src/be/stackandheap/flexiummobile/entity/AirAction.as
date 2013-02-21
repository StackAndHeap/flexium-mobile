package be.stackandheap.flexiummobile.entity {
public class AirAction {
    private var _name:String;
    private var _message:String;
    private var _succes:Boolean;
    private var _args:String;
    private var _element:Object;

    public function AirAction() {

    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function get message():String {
        return _message;
    }

    public function set message(value:String):void {
        _message = value;
    }

    public function get succes():Boolean {
        return _succes;
    }

    public function set succes(value:Boolean):void {
        _succes = value;
    }

    public function get args():String {
        return _args;
    }

    public function set args(value:String):void {
        _args = value;
    }

    public function get element():Object {
        return _element;
    }

    public function set element(value:Object):void {
        _element = value;
    }
}
}
