package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.FlexiumObject;
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
    public static function getFlexCursorState(obj:FlexiumObject):FlexiumObject {
        obj.message =  CursorManager.currentCursorID.toString();
        obj.succes = true;
        return obj;
    }
    public static function doHandshake(obj:FlexiumObject):FlexiumObject {
        obj.message =  "Hello!";
        obj.succes = true;
        return obj;
    }
    public function getCurrentViewTitle(obj:FlexiumObject):FlexiumObject{
        try{
            var titleObject:Object = parser.thisApp['navigator'].activeView.titleContent[0];
            if(titleObject.hasOwnProperty("text")){
                obj.message = titleObject.text;
            }else if(titleObject.hasOwnProperty("label")){
                obj.message =  titleObject.label;
            }else{
                obj.message = titleObject.toString();
            }
            obj.succes = true;
        }catch(e:Error){
            obj.succes = false;
            obj.message = "No title found for current view";
        }
        return obj;
    }
}
}
