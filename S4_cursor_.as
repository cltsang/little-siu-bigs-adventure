package{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Mouse;
	
	public class S4_cursor_ extends MovieClip{
		private var mstage:Stage = null;
		
		public function S4_cursor_(_stage:Stage):void{
			mstage = _stage;
			
			mstage.addEventListener(Event.MOUSE_LEAVE, cursorLeave);
			mstage.addEventListener(Event.MOUSE_LEAVE, cursorLeave);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			mstage.addChild(this);
			this.visible = false;
		}
		
		private function cursorMove(me:MouseEvent):void{
			Mouse.hide();
			this.visible = true;
			this.x = me.stageX;
			this.y = mouseY;
		}
		
		private function cursorLeave(e:Event):void{
			this.visible = false;
			cursorOut(new MouseEvent(MouseEvent.MOUSE_OUT));
		}
		
		private function cursorOut(me:MouseEvent):void {
            Mouse.show();
            this.visible = false;
        }
	}
}