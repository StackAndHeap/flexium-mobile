package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.AppParser;

public class Actions {
    private var actionClasses:Array;

    public function Actions(parser:AppParser) {
        addActions(parser);
        attachActions();
    }

    private function addActions(parser:AppParser):void {
        actionClasses = [];
        actionClasses.push(new MouseAction(parser));
        actionClasses.push(new KeyboardAction(parser));
        actionClasses.push(new ApplicationAction(parser));
        actionClasses.push(new ComponentAction(parser));
    }

    private function attachActions():void {
        for each (var actionClass:IAction in actionClasses) {
            actionClass.attachActions();
        }
    }



}
}
