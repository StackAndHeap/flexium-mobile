package be.stackandheap.flexiummobile;

public class FlexiumMobile extends Server {

    private int pause = 0;

    public FlexiumMobile(){
    }
    public int getPause() {
        return pause;
    }
    public void setPause(int pause) {
        this.pause = pause;
    }
    public String clickElement(String elementId) throws Exception{
        return call("doFlexClick",elementId,pause);
    }
    public String clickItemInElement(String elementId,String itemLabel) throws Exception{
        String args =  elementId +","+itemLabel;
        return call("doFlexClick",args,pause);
    }
    public String setText(String elementId,String value) throws Exception{
        String args =  elementId +","+value;
        return call("doFlexType",args,pause);
    }
    public String getActiveViewTitle() throws Exception{
        return call("getCurrentViewTitle","",pause);
    }
    public Boolean testSocketConnection() throws Exception{
        String handshakeReturn =  call("doHandshake","",pause);
        return handshakeReturn.equals("Hello!");
    }
    public Boolean elementHasItem(String elementId,String itemLabel) throws Exception{
        String args =  elementId +","+itemLabel;
        String hasItemReturn =  call("hasItem",args,pause);
        return hasItemReturn.equals("true");
    }
}
