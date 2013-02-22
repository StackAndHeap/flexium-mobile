package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.AirAction;
import be.stackandheap.flexiummobile.parser.StageParser;
import be.stackandheap.flexiummobile.utils.*;
import flash.events.Event;
import flash.events.FocusEvent;

import spark.components.List;

public class ComponentAction extends AbstractAction implements IAction {
    public function ComponentAction(parser:StageParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("isVisible",isVisible);
        attach("hasItem",hasItem);
        attach("selectElement",selectElement);
        attach("setFocus",setFocus);
    }

    public function isVisible(obj:AirAction):AirAction {
        
        if(obj.element.hasOwnProperty("visible")) {
            obj.succes = true;
            obj.message = obj.element.visible;
        } else {
            obj.message = Errors.PROPERTY_DOESNT_EXIST;
        }
            
        return obj;
    }
    public function hasItem(obj:AirAction):AirAction {
        if (Utils.isA(obj.element, References.LIST_DESCRIPTION)) {
            if(sparkListHasItem(obj.element as List, obj.args)){
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
    public function selectElement(obj:AirAction):AirAction{
        if(obj.element.hasOwnProperty("selected")) {
            obj.element.selected = obj.args=='true';
            obj.element.dispatchEvent(new Event(Event.CHANGE));
            obj.message = obj.element.selected;
            obj.succes = true;
        } else {
            obj.message = Errors.PROPERTY_DOESNT_EXIST;
        }
        return obj;
    }
    public function setFocus(obj:AirAction):AirAction{
        obj.succes = obj.element.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
        return obj;
    }
}
}
