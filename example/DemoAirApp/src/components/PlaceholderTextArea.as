/**
 * Created with IntelliJ IDEA.
 * User: pieter
 * Date: 14/01/13
 * Time: 12:06
 * To change this template use File | Settings | File Templates.
 */
package components {
import flash.events.FocusEvent;
import spark.components.TextArea;

public class PlaceholderTextArea extends TextArea{
    private var _placeHolder:String = 'placeholder';

    public function get placeHolder():String {
        return _placeHolder;
    }

    public function set placeHolder(value:String):void {
        _placeHolder = value;
        super.text = value;
        this.setInputTextStyle('italic','0xB5B5B5');
    }

    override protected function focusInHandler(event:FocusEvent):void{
        if(this.text == placeHolder || this.text.replace(' ','') == ''){
            this.text = '';
            this.setInputTextStyle('normal','0x131313');
        }
        super.focusInHandler(event);
    }
    override protected function focusOutHandler(event:FocusEvent):void{
        if(this.text == placeHolder || this.text.replace(' ','') == ''){
            this.text = placeHolder;
            this.setInputTextStyle('italic','0xB5B5B5');
        }
        super.focusOutHandler(event);
    }

    private function setInputTextStyle(fontStyle:String, color:String):void {
        this.setStyle('fontStyle',fontStyle);
        this.setStyle('color',color);
    }
}
}
