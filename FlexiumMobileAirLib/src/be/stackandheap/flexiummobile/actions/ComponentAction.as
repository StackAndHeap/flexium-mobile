package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.utils.Errors;
import be.stackandheap.flexiummobile.utils.References;
import be.stackandheap.flexiummobile.utils.Utils;

import spark.components.List;

public class ComponentAction extends AbstractAction implements IAction {
    public function ComponentAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("isVisible",isVisible);
        attach("hasItem",hasItem);
        attach("getCurrentViewTitle",getCurrentViewTitle);
    }

    public function isVisible(id:String):String {
        var child:Object = parser.getElement(id);
        if(child) {
            if(child.hasOwnProperty("visible")) {
                return child.visible;
            } else {
                return Errors.PROPERTY_DOESNT_EXIST;
            }
        } else {
            return Errors.OBJECT_NOT_FOUND;
        }
    }
    public function hasItem(id:String, label:String):String {
        var child:Object = parser.getElement(id);
        if (Utils.isA(child, References.LIST_DESCRIPTION)) {
            return sparkListHasItem(child as List, label);
        }
        return Errors.OBJECT_NOT_COMPATIBLE;
    }

    private function sparkListHasItem(list:List, label:String):String {
        for each (var item:Object in list.dataProvider) {
            if (list.itemToLabel(item) == label) {
                return "true";
            }
        }
        return "false";
    }

    public function getCurrentViewTitle(id:String, args:String):String{
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
