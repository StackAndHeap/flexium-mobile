package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.actionregister.ActionRegister;
import be.stackandheap.flexiummobile.parser.AppParser;

public class AbstractAction {

    private var _parser:AppParser;

    public function AbstractAction(parser:AppParser) {
        this.parser = parser
    }

    public function get parser():AppParser {
        return _parser;
    }

    public function set parser(value:AppParser):void {
        _parser = value;
    }

    public static function attach(action:String, callback:Function):void {
        //ExternalInterface.addCallback(action, callback);
        ActionRegister.register(action, callback);
    }

}
}
