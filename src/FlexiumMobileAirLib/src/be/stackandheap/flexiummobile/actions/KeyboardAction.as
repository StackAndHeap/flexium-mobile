package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.FlexiumObject;
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.utils.Errors;

public class KeyboardAction extends AbstractAction implements IAction {
    public function KeyboardAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("doFlexType", doFlexType);
    }

    public function doFlexType(obj:FlexiumObject):FlexiumObject{
        var child:Object = parser.getElement(obj.id);
        if (child == null){
            obj.message = Errors.OBJECT_NOT_FOUND;
            return obj;
        }

        if(child.hasOwnProperty("text")){
            if((child.hasOwnProperty('visible') && child.visible != true)
                    || (child.hasOwnProperty('enabled') && child.enabled != true)
                    || (child.hasOwnProperty('editable') && child.editable != true)) {
                obj.message = Errors.OBJECT_NOT_TYPEABLE;
            } else {
                child.setFocus();
                child.text = obj.args;
                //TextOperationEvent is auto dispatched if text property is changed (only in Air Mobile)
                //return String(child.dispatchEvent(new TextOperationEvent(TextOperationEvent.CHANGE)));
                obj.succes = true;
            }
        }
        else
            obj.message = Errors.OBJECT_NOT_TYPEABLE;

        return obj;
    }
}
}
