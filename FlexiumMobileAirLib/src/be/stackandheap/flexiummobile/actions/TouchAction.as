package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.utils.Errors;

import flash.events.PressAndTapGestureEvent;
import flash.events.TouchEvent;
import mx.core.mx_internal;

use namespace mx_internal;

public class TouchAction extends AbstractAction implements IAction {
    public function TouchAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("doTap", doTap);
        attach("doPressAndTap", doPressAndTap);
    }

    public function doTap(elementId:String, args:String=null):String {
        var child:Object = parser.getElement(elementId);

        if (child == null) {
            return Errors.OBJECT_NOT_FOUND;
        }

        if (!args) {
            return String(child.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_TAP)));
        }

        return Errors.OBJECT_NOT_COMPATIBLE;
    }

    public function doPressAndTap():String{
            return String(parser.thisApp.dispatchEvent(
                    new PressAndTapGestureEvent(PressAndTapGestureEvent.GESTURE_PRESS_AND_TAP)));
    }

}
}
