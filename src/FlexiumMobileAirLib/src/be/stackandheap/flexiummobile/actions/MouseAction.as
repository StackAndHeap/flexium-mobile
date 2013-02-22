package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.AirAction;
import be.stackandheap.flexiummobile.parser.StageParser;
import be.stackandheap.flexiummobile.utils.*;

import flash.events.MouseEvent;

import mx.core.mx_internal;

import spark.components.List;
import spark.components.supportClasses.ListBase;
import spark.events.IndexChangeEvent;

use namespace mx_internal;

public class MouseAction extends AbstractAction implements IAction {
    public function MouseAction(parser:StageParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("doFlexClick", doFlexClick);
    }

    public function doFlexClick(obj:AirAction):AirAction {

        if (!obj.args) {
            if(obj.element.hasOwnProperty("enabled"))
                if(obj.element.enabled == false){
                    obj.message = Errors.OBJECT_NOT_ENABLED;
                    return obj;
                }
            obj.succes = obj.element.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }

        if (Utils.isA(obj.element, References.LIST_DESCRIPTION)
                || Utils.isA(obj.element, References.SPINNER_DESCRIPTION)) {
            obj.succes =  clickSparkList(obj.element as ListBase, obj.args);
        }else{
            obj.message = Errors.OBJECT_NOT_COMPATIBLE;
        }
        return obj;
    }

    private static function clickSparkList(list:ListBase, selectItemLabel:String):Boolean {
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
