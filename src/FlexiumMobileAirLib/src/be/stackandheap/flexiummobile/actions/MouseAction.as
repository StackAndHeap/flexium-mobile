package be.stackandheap.flexiummobile.actions {
import be.stackandheap.flexiummobile.parser.AppParser;
import be.stackandheap.flexiummobile.utils.Errors;
import be.stackandheap.flexiummobile.utils.References;
import be.stackandheap.flexiummobile.utils.Utils;
import flash.events.MouseEvent;
import mx.core.mx_internal;
import spark.components.DataGrid;
import spark.components.List;
import spark.components.gridClasses.GridColumn;
import spark.events.GridEvent;

use namespace mx_internal;

public class MouseAction extends AbstractAction implements IAction {
    public function MouseAction(parser:AppParser) {
        super(parser);
    }

    public function attachActions():void {
        attach("doFlexClick", doFlexClick);
        attach("doFlexDoubleClick", doFlexDoubleClick);
    }

    public function doFlexClick(id:String, args:String=null):String {
        var child:Object = parser.getElement(id);

        if (child == null) {
            return Errors.OBJECT_NOT_FOUND;
        }

        // if stand alone control, just click it
        if (!args) {
            return String(child.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
        }

        // for a List control
        if (Utils.isA(child, References.LIST_DESCRIPTION)) {
            return clickSparkList(child as List, args);
        }

        return Errors.OBJECT_NOT_COMPATIBLE;
    }

    public function doFlexDoubleClick(id:String, args:String=null):String {
        var child:Object = parser.getElement(id);

        if (child == null) {
            return Errors.OBJECT_NOT_FOUND;
        }

        if (child.hasOwnProperty("doubleClickEnabled") && child.doubleClickEnabled) {
            // check if child is a spark datagrid
            if (child is DataGrid) {
                return doubleClickItemInDataGrid(child as DataGrid, args);
            }

            return String(child.dispatchEvent(new MouseEvent(MouseEvent.DOUBLE_CLICK)));
        }
        return Errors.OBJECT_NOT_COMPATIBLE;
    }

    private static function clickSparkList(list:List, selectItemLabel:String):String {
        for each (var item:Object in list.dataProvider) {
            if (list.itemToLabel(item) == selectItemLabel) {
                list.mx_internal::setSelectedItem(item, true);
                return "true";
            }
        }
        return "false";
    }

    private static function doubleClickItemInDataGrid(grid:DataGrid, args:String):String {
        var argsArray:Array = args.split("||");
        var colHeader:String = argsArray[0];
        var itemLabel:String = argsArray[1];
        var selectedColumn:GridColumn;

        for each (var column:GridColumn in grid.columns.toArray()) {
            if (column.headerText == colHeader) {
                selectedColumn = column;
                break;
            }
        }

        if (selectedColumn) {
            for each (var item:Object in grid.dataProvider) {
                if (selectedColumn.itemToLabel(item) == itemLabel) {
                    grid.setSelectedIndex(grid.dataProvider.getItemIndex(item));
                    var event:GridEvent = new GridEvent(GridEvent.GRID_DOUBLE_CLICK);
                    event.item = item;
                    event.column = selectedColumn;
                    event.columnIndex = grid.columns.getItemIndex(selectedColumn);
                    return String(grid.dispatchEvent(event));
                }
            }
        }
        return Errors.OBJECT_NOT_COMPATIBLE;
    }
}
}
