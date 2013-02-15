package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.AppParser;

public interface IAction {

    function attachActions():void;
    function get parser():AppParser;
    function set parser(value:AppParser):void;

}
}
