package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.AirAction;
import be.stackandheap.flexiummobile.parser.StageParser;
import be.stackandheap.flexiummobile.utils.Errors;

public class KeyboardAction extends AbstractAction implements IAction {
    public function KeyboardAction(parser:StageParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("doFlexType", doFlexType);
    }

    public function doFlexType(obj:AirAction):AirAction{
        
        if(obj.element.hasOwnProperty("text")){
            if((obj.element.hasOwnProperty('visible') && obj.element.visible != true)
                    || (obj.element.hasOwnProperty('enabled') && obj.element.enabled != true)
                    || (obj.element.hasOwnProperty('editable') && obj.element.editable != true)) {
                obj.message = Errors.OBJECT_NOT_TYPEABLE;
            } else {
                obj.element.setFocus();
                obj.element.text = obj.args;
                //TextOperationEvent is auto dispatched if text property is changed (only in Air Mobile)
                //return String(obj.element.dispatchEvent(new TextOperationEvent(TextOperationEvent.CHANGE)));
                obj.succes = true;
            }
        }
        else
            obj.message = Errors.OBJECT_NOT_TYPEABLE;

        return obj;
    }
}
}
