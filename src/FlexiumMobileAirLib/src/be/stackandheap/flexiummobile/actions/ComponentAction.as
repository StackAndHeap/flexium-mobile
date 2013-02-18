package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.FlexiumObject;
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.utils.*;
import flash.events.Event;
import spark.components.List;

public class ComponentAction extends AbstractAction implements IAction {
    public function ComponentAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("isVisible",isVisible);
        attach("hasItem",hasItem);
        attach("selectElement",selectElement);
    }

    public function isVisible(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);
        if(child) {
            if(child.hasOwnProperty("visible")) {
                obj.succes = true;
                obj.message = child.visible;
            } else {
                obj.message = Errors.PROPERTY_DOESNT_EXIST;
            }
        } else {
            obj.message = Errors.OBJECT_NOT_FOUND;
        }
        return obj;
    }
    public function hasItem(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);
        if (Utils.isA(child, References.LIST_DESCRIPTION)) {
            if(sparkListHasItem(child as List, obj.args)){
                obj.succes = true;
            }else{
                obj.message = Errors.OBJECT_NOT_FOUND;
            }
        }else{
            obj.message = Errors.OBJECT_NOT_COMPATIBLE;
        }
        return obj;
    }
    private function sparkListHasItem(list:List, label:String):Boolean {
        for each (var item:Object in list.dataProvider) {
            if (list.itemToLabel(item) == label) {
                return true;
            }
        }
        return false;
    }
    public function selectElement(obj:FlexiumObject):FlexiumObject{
        var child:Object = parser.getElement(obj.id);
        if(child) {
            if(child.hasOwnProperty("selected")) {
                child.selected = obj.args=='true';
                child.dispatchEvent(new Event(Event.CHANGE));
                obj.message = child.selected;
                obj.succes = true;
            } else {
                obj.message = Errors.PROPERTY_DOESNT_EXIST;
            }
        } else {
            obj.message = Errors.OBJECT_NOT_FOUND;
        }
        return obj;
    }
}
}
