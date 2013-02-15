package be.stackandheap.flexiummobile;

public class FlexiumMobile extends Server {

    public FlexiumMobile(){
    }

    public String clickElement(String elementId) throws Exception{
        return call("doFlexClick",elementId);
    }
    public String clickItemInElement(String elementId,String itemLabel) throws Exception{
        String args =  elementId +","+itemLabel;
        return call("doFlexClick",args);
    }
    public String setText(String elementId,String value) throws Exception{
        String args =  elementId +","+value;
        return call("doFlexType",args);
    }
    public String getActiveViewTitle() throws Exception{
        return call("getCurrentViewTitle");
    }
    public Boolean testSocketConnection() throws Exception{
        String handshakeReturn =  call("doHandshake");
        return handshakeReturn.equals("Hello!");
    }
    public Boolean elementHasItem(String elementId,String itemLabel) throws Exception{
        String args =  elementId +","+itemLabel;
        String hasItemReturn =  call("hasItem",args);
        return hasItemReturn.equals("true");
    }
    public String tapElement(String elementId) throws Exception{
        return call("doTap",elementId);
    }
    public void openContextMenu() throws Exception{
        call("doPressAndTap");
    }
    public Boolean selectElement(String elementId,String selected) throws Exception{
        String args =  elementId +","+selected;
        String hasItemReturn =  call("selectElement",args);
        return hasItemReturn.equals(selected);
    }
}
