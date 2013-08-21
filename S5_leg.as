package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class S5_leg extends S5_objects {
		var s5:Stage5 = null;
		var mStage:Stage = null;
		var player:S5_player = null;
		var down_phase:Boolean;
		
		public function S5_leg(_stage:Stage, _s5:Stage5, _player:S5_player) {
			mStage = _stage;
			s5 = _s5;
			player = _player;
			down_phase = true;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		function update(e:Event):void {
			if (down_phase) {
				if(this.y+this.height < 500)
					this.y += 25;
				else
					down_phase = false;
			}
			else {
				this.y -= 20;
				
				if (this.y+this.height < 0)
					destructor();
			}
			
			if (this.hitTestObject(player)) {
				if (player.x >= this.x && player.x <= this.x + this.width) {
					destructor();
					s5.endStage(10);
				}
				else{
					player.x -= 10;
				}
			}
		}
		
		public override function destructor():void {
			removeEventListener(Event.ENTER_FRAME, update);
			parent.removeChild(this);
			delete this;
		}
	}
}