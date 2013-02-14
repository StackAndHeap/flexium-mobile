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
        attach("getCurrentViewTitle", getCurrentViewTitle);
    }
    public static function getFlexCursorState(id:String,args:String):String {
        return CursorManager.currentCursorID.toString();
    }
    public static function doHandshake():String {
        return "Hello!";
    }
    public function getCurrentViewTitle():String{
        try{
            var titleObject:Object = parser.thisApp['navigator'].activeView.titleContent[0];
            if(titleObject.hasOwnProperty("text")){
                return titleObject.text;
            }
            if(titleObject.hasOwnProperty("label")){
                return titleObject.label;
            }
            return titleObject.toString();
        }catch(e:Error){
            return "No title-object found in currentview";
        }
        return null;
    }
}
}
