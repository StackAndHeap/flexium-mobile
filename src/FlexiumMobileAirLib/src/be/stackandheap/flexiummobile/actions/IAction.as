package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.StageParser;

public interface IAction {

    function attachActions():void;
    function get parser():StageParser;
    function set parser(value:StageParser):void;

}
}
