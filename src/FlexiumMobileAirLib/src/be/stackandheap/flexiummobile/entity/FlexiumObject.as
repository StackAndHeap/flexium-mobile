/**
 * Created with IntelliJ IDEA.
 * User: pieter
 * Date: 18/02/13
 * Time: 8:27
 * To change this template use File | Settings | File Templates.
 */
package be.stackandheap.flexiummobile.entity {
public class FlexiumObject {
    private var _id:String;
    private var _action:String;
    private var _message:String;
    private var _succes:Boolean;
    private var _args:String;

    public function FlexiumObject() {

    }

    public function get id():String {
        return _id;
    }

    public function set id(value:String):void {
        _id = value;
    }

    public function get action():String {
        return _action;
    }

    public function set action(value:String):void {
        _action = value;
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
}
}
