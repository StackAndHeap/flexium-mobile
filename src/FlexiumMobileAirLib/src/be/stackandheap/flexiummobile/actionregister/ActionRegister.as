package be.stackandheap.flexiummobile.actionregister {
import be.stackandheap.flexiummobile.entity.AirAction;

public class ActionRegister {
    private static var actions:Array = new Array();

    public static function register(actionName:String, callBack:Function):void{
        actions[actionName] = callBack;
    }
    public static function call(action:AirAction):AirAction{
        if(actions[action.name])
            return actions[action.name](action);

        action.succes = false;
        action.message = "action not found";
        return action;
    }
}
}
