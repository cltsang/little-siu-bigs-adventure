package com.five3d {
	import flash.display.StageDisplayState;	
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;	
	import flash.events.Event;	
	
	import five3D.typography.HelveticaBold;
	import five3D.display.Sprite3D;	
	import five3D.display.Scene3D;	
	import flash.display.Sprite;
	
	public class Text3D extends Sprite{
		private var scene:Scene3D;
		private var container3d:Sprite3D;
		private var setScatter:Boolean = false;
		
		private static var amount:Number;
		private static var radiusX:Number = 200;
		private static var radiusZ:Number = 200;
		private static var msg:String = "GAME OVER";
		
		var mstage:Stage;

		public function Text3D(_stage:Stage){
			mstage = _stage;
			
			scene = new Scene3D();
			scene.x = mstage.stageWidth/2;
			scene.y = mstage.stageHeight/2;
			addChild(scene);
			
			container3d = new Sprite3D();
			scene.addChild(container3d);
			
			amount = msg.split("").length;
			for(var i:Number=0; i<amount; i++)
			{
				var angle:Number = i * (Math.PI*2 / amount);
				var s:Letter3D = new Letter3D( HelveticaBold );
				s.angle = angle;
				s.text = msg.substr(i, 1);
				s.size = 45;
				s.color = Math.random() * 0xffffff;
				s.x = Math.cos(angle) * radiusX;
				s.z = Math.sin(angle) * radiusZ;
				s.rotationY = angle*-180/Math.PI - 90;
				s.addEventListener( Event.ENTER_FRAME, handleEnterFrame);
				container3d.addChild(s);
			}
			
			container3d.childrenSorted = true;
			container3d.rotationX = 10;
			mstage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
//			mstage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
//			mstage.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOverstage);
			mstage.addEventListener(Event.MOUSE_LEAVE, handleMouseLeave);
			mstage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseDoubleClick);
		}

		private function handleEnterFrame(event:Event):void
		{
			var letter3d:Letter3D = event.target as Letter3D;
			letter3d.angle -= 0.01;
			letter3d.x = Math.cos( letter3d.angle ) * radiusX;
			letter3d.z = Math.sin( letter3d.angle ) * radiusZ;
			letter3d.rotationY = letter3d.angle*-180/Math.PI;
			
			if(setScatter) {
				letter3d.y += (letter3d.randomY - letter3d.y) * 0.1;
			} else {
				letter3d.y += (0 - letter3d.y) * 0.1;
			}
		}
		
		function handleMouseMove(event:MouseEvent):void
		{
			radiusX = Math.abs( scene.mouseX );
			container3d.rotationZ = scene.mouseY/10;
			container3d.rotationX = scene.mouseY/10;
		}
/*		
		function handleMouseDown(event:MouseEvent):void
		{			
			trace("clicked!!");
		}
*/
		function handleMouseLeave(event:Event):void
		{
//			mstage.addEventListener( MouseEvent.MOUSE_OVER, handleMouseOverStage);
			mstage.removeEventListener(Event.MOUSE_LEAVE, handleMouseLeave);
			mstage.removeEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove);
//			mstage.removeEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown);
			mstage.removeEventListener(MouseEvent.MOUSE_WHEEL, handleMouseDoubleClick);
		}
		
		function handleMouseDoubleClick(event:MouseEvent):void
		{
			setScatter = !setScatter;
		}
		
		function handleMouseOverStage(event:Event):void
		{
			mstage.removeEventListener( MouseEvent.MOUSE_OVER, handleMouseOverStage);
			mstage.addEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove);
//			mstage.addEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown);
			mstage.addEventListener(Event.MOUSE_LEAVE, handleMouseLeave);
			mstage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseDoubleClick);
		}
	}
}
