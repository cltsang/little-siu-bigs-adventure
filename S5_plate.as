package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class S5_plate extends S5_objects {
		var s5:Stage5 = null;
		var mStage:Stage = null;
		var player:S5_player = null;
		
		public function S5_plate(_stage:Stage, _s5:Stage5, _player:S5_player) {
			mStage = _stage;
			s5 = _s5;
			player = _player;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		function update(e:Event):void {
			if(this.y+this.height < 500)
				this.y += 35;
			else
				this.play();
			
			if (this.hitTestObject(player)) {
					destructor();
				s5.endStage(10);
			}
			else if(this.currentFrame==10)
				destructor();
		}
		
		public override function destructor():void {
			if(this.hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, update);
			parent.removeChild(this);
			delete this;
		}
	}
}