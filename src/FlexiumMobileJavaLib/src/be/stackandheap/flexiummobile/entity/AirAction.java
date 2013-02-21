package be.stackandheap.flexiummobile.entity;

public class AirAction {
    private String name;
    private String message;
    private Boolean succes;
    private String args;
    private String element;

    public AirAction(String name,String element,String args){
           this.name = name;
           this.element = element;
           this.args = args;
    }
    public AirAction(String name,String element){
        this.name = name;
        this.element = element;
        this.args = null;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Boolean getSucces() {
        return succes;
    }

    public void setSucces(Boolean succes) {
        this.succes = succes;
    }

    public String getArgs() {
        return args;
    }

    public void setArgs(String args) {
        this.args = args;
    }

    public String getElement() {
        return element;
    }

    public void setElement(String element) {
        this.element = element;
    }
}
