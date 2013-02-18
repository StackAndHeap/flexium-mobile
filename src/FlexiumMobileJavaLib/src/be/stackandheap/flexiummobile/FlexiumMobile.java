package be.stackandheap.flexiummobile;


import org.json.simple.JSONObject;

public class FlexiumMobile extends Server {

    public FlexiumMobile(){
    }

    public void clickElement(String elementId) throws Exception{
        JSONObject jsonObject = call("doFlexClick",elementId);

    }
    public void clickItemInElement(String elementId,String itemLabel) throws Exception{
        String args =  elementId +","+itemLabel;
        JSONObject jsonObject = call("doFlexClick",args);
    }
    public void setText(String elementId,String value) throws Exception{
        String args =  elementId +","+value;
        JSONObject jsonObject = call("doFlexType",args);
    }
    public String getActiveViewTitle() throws Exception{
        JSONObject jsonObject = call("getCurrentViewTitle");
        return ""+jsonObject.get("message");
    }
    public Boolean testSocketConnection() throws Exception{
        JSONObject handshakeReturn =  call("doHandshake");
        return handshakeReturn.get("message").equals("Hello!");
    }
    public Boolean elementHasItem(String elementId,String itemLabel) throws Exception{
        String args =  elementId +","+itemLabel;
        JSONObject jsonObject =  call("hasItem",args);
        return (Boolean) jsonObject.get("succes");
    }
    public void tapElement(String elementId) throws Exception{
        JSONObject jsonObject = call("doTap",elementId);
    }
    public void openContextMenu() throws Exception{
        call("doPressAndTap");
    }
    public void selectElement(String elementId,String selected) throws Exception{
        String args =  elementId +","+selected;
        JSONObject jsonObject =   call("selectElement",args);
    }
    public void swipe(String elementId,String toDirection) throws Exception{
        String args =  elementId +","+toDirection;
        call("doSwipeGesture",args);
    }
    public void pan(String elementId,String toDirection) throws Exception{
        String args =  elementId +","+toDirection;
        call("doPanGesture",args);
    }
    public void rotate(String elementId,Number degrees) throws Exception{
        String args =  elementId +","+degrees.toString();
        call("doRotateGesture",args);
    }
    public void zoom(String elementId,Number zoomPercentage) throws Exception{
        String args =  elementId +","+zoomPercentage.toString();
        call("doZoomGesture",args);
    }
}
