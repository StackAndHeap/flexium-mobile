package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.AirAction;
import be.stackandheap.flexiummobile.parser.StageParser;

import mx.managers.CursorManager;

public class ApplicationAction extends AbstractAction implements IAction {
    public function ApplicationAction(parser:StageParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("getFlexCursorState", getFlexCursorState);
        attach("doHandshake", doHandshake);
        attach("getTextFromTitleContent", getTextFromTitleContent);
    }
    public function getFlexCursorState(obj:AirAction):AirAction {
        obj.message =  CursorManager.currentCursorID.toString();
        obj.succes = true;
        return obj;
    }
    public function doHandshake(obj:AirAction):AirAction {
        obj.message =  "Hello!";
        obj.succes = true;
        return obj;
    }
    public function getTextFromTitleContent(obj:AirAction):AirAction{
        var actionBar:Object = parser.getElementById("actionBar");
        var titleContentObjects:Array = actionBar.titleContent;
        for each(var titleObject:Object in titleContentObjects){
            if(titleObject.hasOwnProperty("text")){
                obj.message = titleObject.text;
                obj.succes = true;
                return obj;
            }
            if(titleObject.hasOwnProperty("label")){
                obj.message = titleObject.label;
                obj.succes = true;
                return obj;
            }
        }
        obj.succes = false;
        obj.message = "No text found found in titleContent";
        return obj;
    }
}
}
