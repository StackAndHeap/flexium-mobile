package be.stackandheap.flexiummobile.actionregister {
public class ActionRegister {
    private static var actions:Array = new Array();

    public static function register(actionName:String, callBack:Function):void{
        actions[actionName] = callBack;
    }
    public static function call(actionName:String,args:String=null):String{
        if(actions[actionName]){
            var id:String = null;
            var otherArgs:String = null;
            var arguments:Array = null;
            if(args){
                arguments =  args.split(",");
                id = arguments[0];
                otherArgs = arguments[1];
            }
            if(!arguments)
                return actions[actionName]();
            if(arguments.length == 1)
                return actions[actionName](id);
            if(arguments.length > 1)
                return actions[actionName](id,otherArgs);

        }
        return "action failed";
    }
}
}
