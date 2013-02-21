package be.stackandheap.flexiummobile.recorder {
import flash.events.MouseEvent;

public class Recorder {
    public function Recorder(app:Object) {
        app.addEventListener(MouseEvent.CLICK, app_clickHandler, true);
    }

    private function app_clickHandler(event:MouseEvent):void {
        //trace('full link: '+event.target);
        var componentToString:Object = getFirstParentWithID(event.target);
        trace('id clicked item: ' + componentToString);
    }

    private function getFirstParentWithID(obj:Object):Object {
        if(obj.hasOwnProperty('id')){
            if(obj.id !="" && obj.id != null)
                return obj.id;
        }
        if(obj.hasOwnProperty('label')){
            if(obj.label !="" && obj.label != null)
                return obj.label;
        }
        if(obj.hasOwnProperty('text')){
            if(obj.text !="" && obj.text != null)
                return obj.text;
        }
        if(obj.hasOwnProperty('parent')){
            return getFirstParentWithID(obj.parent);
        }

        return null;
    }
}
}
