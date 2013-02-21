package be.stackandheap.flexiummobile;

import be.stackandheap.flexiummobile.entity.AirAction;

public class FlexiumMobile extends Server {


    public AirAction clickElement( String elementId ) throws Exception{
        AirAction sendAction = new AirAction("doFlexClick",elementId);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }

    public AirAction clickItemInElement(String elementId,String itemLabel) throws Exception{
        AirAction sendAction = new AirAction("doFlexClick",elementId,itemLabel);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction setText(String elementId,String value) throws Exception{
        AirAction sendAction = new AirAction("doFlexType",elementId,value);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction getTextFromTitleContent() throws Exception{
        AirAction sendAction = new AirAction("getTextFromTitleContent",null);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction testSocketConnection() throws Exception{
        AirAction sendAction = new AirAction("doHandshake",null);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction elementHasItem(String elementId,String itemLabel) throws Exception{
        AirAction sendAction = new AirAction("hasItem",elementId,itemLabel);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction tapElement(String elementId) throws Exception{
        AirAction sendAction = new AirAction("doTap",elementId);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction openContextMenu(String elementId) throws Exception{
        AirAction sendAction = new AirAction("doPressAndTap",elementId);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction selectElement(String elementId,String selected) throws Exception{
        AirAction sendAction = new AirAction("selectElement",elementId,selected);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction swipe(String elementId,String toDirection) throws Exception{
        AirAction sendAction = new AirAction("doSwipeGesture",elementId,toDirection);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction pan(String elementId,String toDirection) throws Exception{
        AirAction sendAction = new AirAction("doPanGesture",elementId,toDirection);
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction rotate(String elementId,Number degrees) throws Exception{
        AirAction sendAction = new AirAction("doRotateGesture",elementId,degrees.toString());
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
    public AirAction zoom(String elementId,Number zoomPercentage) throws Exception{
        AirAction sendAction = new AirAction("doZoomGesture",elementId,zoomPercentage.toString());
        AirAction receivedAction = call(sendAction);
        return receivedAction;
    }
}
