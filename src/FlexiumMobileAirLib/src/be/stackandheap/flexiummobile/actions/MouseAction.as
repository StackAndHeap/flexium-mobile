package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.FlexiumObject;
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.utils.*;
import flash.events.MouseEvent;
import mx.core.mx_internal;
import spark.components.List;

use namespace mx_internal;

public class MouseAction extends AbstractAction implements IAction {
    public function MouseAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("doFlexClick", doFlexClick);
    }

    public function doFlexClick(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);

        if (child == null){
            obj.message = Errors.OBJECT_NOT_FOUND;
            return obj;
        }

        // if stand alone control, just click it
        if (!obj.args) {
            obj.succes = child.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }

        // for a List control
        if (Utils.isA(child, References.LIST_DESCRIPTION)) {
            obj.succes =  clickSparkList(child as List, obj.args);
        }else{
            obj.message = Errors.OBJECT_NOT_COMPATIBLE;
        }
        return obj;
    }

    private static function clickSparkList(list:List, selectItemLabel:String):Boolean {
        for each (var item:Object in list.dataProvider) {
            if (list.itemToLabel(item) == selectItemLabel) {
                list.mx_internal::setSelectedItem(item, true);
                return true;
            }
        }
        return false;
    }
}
}
