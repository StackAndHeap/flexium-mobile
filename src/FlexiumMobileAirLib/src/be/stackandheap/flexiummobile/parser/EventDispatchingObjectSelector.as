package be.stackandheap.flexiummobile.parser {
import org.as3commons.stageprocessing.IObjectSelector;

public class EventDispatchingObjectSelector implements IObjectSelector {
    public function approve(object:Object):Boolean {
        return object.hasOwnProperty("id");
        //return object is UIComponent;
    }
}
}
