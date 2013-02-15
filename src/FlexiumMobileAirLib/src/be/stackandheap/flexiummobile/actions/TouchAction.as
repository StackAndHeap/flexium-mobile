package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.utils.Errors;

import flash.events.PressAndTapGestureEvent;
import flash.events.TouchEvent;
import flash.events.TransformGestureEvent;

import mx.core.mx_internal;

use namespace mx_internal;

public class TouchAction extends AbstractAction implements IAction {
    public function TouchAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("doTap", doTap);
        attach("doPressAndTap", doPressAndTap);
        attach("doPanGesture", doPanGesture);
        attach("doRotateGesture", doRotateGesture);
        attach("doSwipeGesture", doSwipeGesture);
        attach("doZoomGesture", doZoomGesture);
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

    public function doZoomGesture(zoomPercentage:Number):String{
        var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_ZOOM);
        e.scaleX = e.scaleY = zoomPercentage;
        return String(parser.thisApp.dispatchEvent(e));
    }
    public function doPanGesture(toDirection:String):String{
        var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_PAN);
        switch(toDirection.toUpperCase()){
            case "UP":
                e.offsetY = -1;
                break;
            case "DOWN":
                e.offsetY = 1;
                break;
            case "LEFT":
                e.offsetX = -1;
                break;
            case "RIGHT":
                e.offsetX = 1;
                break;
            default:
                return Errors.PROPERTY_DOESNT_EXIST;
                break;

        }
        return String(parser.thisApp.dispatchEvent(e));
    }
    public function doRotateGesture(rotation:Number):String{
        var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_ROTATE);
        e.rotation = rotation;
        return String(parser.thisApp.dispatchEvent(e));
    }
    public function doSwipeGesture(toDirection:String):String{
        var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_SWIPE);
        switch(toDirection.toUpperCase()){
            case "UP":
                e.offsetY = -1;
                break;
            case "DOWN":
                e.offsetY = 1;
                break;
            case "LEFT":
                e.offsetX = -1;
                break;
            case "RIGHT":
                e.offsetX = 1;
                break;
            default:
                return Errors.PROPERTY_DOESNT_EXIST;
                break;

        }
        return String(parser.thisApp.dispatchEvent(e));
    }

}
}
