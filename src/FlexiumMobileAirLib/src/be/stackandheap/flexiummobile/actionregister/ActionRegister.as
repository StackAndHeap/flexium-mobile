package be.stackandheap.flexiummobile.actionregister {
import be.stackandheap.flexiummobile.entity.FlexiumObject;

public class ActionRegister {
    private static var actions:Array = new Array();

    public static function register(actionName:String, callBack:Function):void{
        actions[actionName] = callBack;
    }
    public static function call(actionName:String,args:String=null):FlexiumObject{
        var returnObj:FlexiumObject = new FlexiumObject();
        returnObj.action = actionName;
        if(actions[actionName]){
            var id:String = null;
            var otherArgs:String = null;
            var arguments:Array = null;
            if(args){
                arguments =  args.split(",");
                id = arguments[0];
                otherArgs = arguments[1];
            }
            returnObj.id = id;
            returnObj.args = otherArgs;
            return actions[actionName](returnObj);
        }
        //action not found
        returnObj.succes = false;
        returnObj.message = "action not found";
        return returnObj;
    }
}
}
