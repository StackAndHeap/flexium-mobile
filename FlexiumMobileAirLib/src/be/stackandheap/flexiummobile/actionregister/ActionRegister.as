package be.stackandheap.flexiummobile.actionregister {
public class ActionRegister {
    private static var actions:Array = new Array();

    public static function register(actionName:String, callBack:Function):void{
        actions[actionName] = callBack;
    }
    public static function call(actionName:String,args:String=null):String{
        var id:String = null;
        var otherArgs:String = null;
        if(args){
            var arguments:Array = args.split(",");
            id = arguments[0];
            otherArgs = arguments[1];
        }
        if(actions[actionName]){
            return actions[actionName](id,otherArgs);
        }
        return "action failed";
    }
}
}
