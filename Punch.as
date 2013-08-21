package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	
	public class Punch extends S5_objects {
		var s5:Stage5 = null;
		var mStage:Stage = null;
		var player:S5_player = null;
		var left_phase:Boolean;
		
		public function Punch(_stage:Stage, _s5:Stage5, _player:S5_player) {
			mStage = _stage;
			s5 = _s5;
			player = _player;
			left_phase = true;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void {
			if (left_phase) {
				if(this.x+this.width > mStage.stageWidth)
					this.x -= 5;
				else
					left_phase = false;
			}
			else {
				this.x += 1;
				
				if (this.x > mStage.stageWidth)
					destructor();
			}
			
			if (this.hitTestObject(player)) {
				if(left_phase)
					player.x -= 200;
				else
					player.x -= 50;
			}
		}
		
		public override function destructor():void {
			removeEventListener(Event.ENTER_FRAME, update);
			parent.removeChild(this);
			s5.hasPunch = false;
			delete this;
		}
	}
}