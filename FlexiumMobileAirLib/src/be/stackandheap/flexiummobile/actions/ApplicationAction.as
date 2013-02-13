package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.AppParser;

import mx.managers.CursorManager;

public class ApplicationAction extends AbstractAction implements IAction {
    public function ApplicationAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("getFlexCursorState", getFlexCursorState);
        attach("doHandshake", doHandshake);
    }
    public static function getFlexCursorState(id:String,args:String):String {
        return CursorManager.currentCursorID.toString();
    }
    public static function doHandshake(id:String,args:String):String {
        return "Hello!";
    }
}
}
