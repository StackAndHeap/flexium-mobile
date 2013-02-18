package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.entity.FlexiumObject;
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

    public function doTap(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);

        if (child == null){
            obj.message = Errors.OBJECT_NOT_FOUND;
            return obj;
        }

        if (!obj.args) {
            obj.succes = child.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_TAP));
        }else{
            obj.message = Errors.OBJECT_NOT_COMPATIBLE;
        }

        return obj;
    }

    public function doPressAndTap(obj:FlexiumObject):FlexiumObject {
        obj.succes = parser.thisApp.dispatchEvent(
                    new PressAndTapGestureEvent(PressAndTapGestureEvent.GESTURE_PRESS_AND_TAP));
        return obj;
    }

    public function doZoomGesture(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);

        if (child == null){
            obj.message = Errors.OBJECT_NOT_FOUND;
            return obj;
        }

        if (obj.args) {
            var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_ZOOM);
            e.scaleX = e.scaleY = obj.args as Number;
            obj.succes = child.dispatchEvent(e);
        }else{
            obj.message = Errors.OBJECT_NOT_COMPATIBLE;
        }

        return obj;
    }
    public function doPanGesture(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);
        if (child == null){
            obj.message = Errors.OBJECT_NOT_FOUND;
            return obj;
        }

        var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_PAN);
        switch(obj.args.toUpperCase()){
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
                obj.message = Errors.PROPERTY_DOESNT_EXIST;
                return obj;

        }
        obj.succes = child.dispatchEvent(e);
        return obj;
    }
    public function doRotateGesture(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);
        if (child == null){
            obj.message = Errors.OBJECT_NOT_FOUND;
            return obj;
        }

        var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_ROTATE);
        e.rotation = obj.args as Number;
        obj.succes = child.dispatchEvent(e);
        return obj;
    }
    public function doSwipeGesture(obj:FlexiumObject):FlexiumObject {
        var child:Object = parser.getElement(obj.id);
        if (child == null){
            obj.message = Errors.OBJECT_NOT_FOUND;
            return obj;
        }
        var e:TransformGestureEvent = new TransformGestureEvent(TransformGestureEvent.GESTURE_SWIPE);
        switch(obj.args.toUpperCase()){
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
                obj.message = Errors.PROPERTY_DOESNT_EXIST;
                return obj;
        }
        obj.succes = child.dispatchEvent(e);
        return obj;
    }
}
}
