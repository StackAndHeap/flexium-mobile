package be.stackandheap.flexiummobile.parser {
import flash.display.DisplayObject;
import mx.core.UIComponent;
import org.as3commons.stageprocessing.*;

public class EventDispatchingObjectProcessor implements IStageObjectProcessor, IStageObjectDestroyer {
    private var _stageParser:StageParser;

    public function EventDispatchingObjectProcessor(stageParser:StageParser) {
        _stageParser = stageParser;
    }

    public function process(displayObject:DisplayObject):DisplayObject {
        try{
            _stageParser.addElement((displayObject as UIComponent).id, displayObject);
        }catch(e:TypeError){
            //trace("processerror: "+displayObject);
        }

        return displayObject;
    }

    public function destroy(displayObject:DisplayObject):DisplayObject {
        try{
            _stageParser.removeElement((displayObject as UIComponent).id);
        }catch(e:Error){
            //trace("destroy-error: "+displayObject);
        }
        return displayObject;
    }
}
}
