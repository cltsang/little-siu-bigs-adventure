package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Stage5 extends MovieClip{
		var mStage:Stage = null;
		var mmain:Main = null;
		var player:S5_player = null;
		var timer:Timer = null;
		var hasPunch:Boolean = false;
		public var wall1, wall2:Wall;
		public var punch:Punch = null;
		var channel:SoundChannel;
		
		public function Stage5(_stage:Stage, _main:Main){
			mStage = _stage;
			mmain = _main;
			
			mStage.frameRate = 30;
			
			player = new S5_player(mStage);
			p_layer.addChild(player);
			player.x = mStage.stageWidth /2;
			player.y = 520 - player.height;
/*			
			wall1 = new Wall();
			wall1.x = -21;
			wall1.y = 520;
			wall1.width = 847;
			wall1.height = 0;
			this.addChild(wall1);
			
			wall2= new Wall();
			wall2.x = 654;
			wall2.y = 459;
			wall2.width = 130;
			wall2.height = 0;
			this.addChild(wall2);
*/			
			this.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			this.addEventListener(Event.ENTER_FRAME, update);
			
			timer = new Timer(1000, 8);
			timer.addEventListener(TimerEvent.TIMER, renderMonster1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, complete1);
			timer.start();
		}
		
		function update(e:Event):void {
			if (player.x > 650 && !hasPunch) {
				punch = new Punch(mStage, this, player);
				var snd:Sound = new Sound();   
				snd.load(new URLRequest("MySound/punch.mp3"));
				channel=snd.play(0,1);
				punch.y = 510;
				punch.x = mStage.stageWidth;
				this.addChild(punch);
				hasPunch = true;
			}
		}
		
		function renderMonster1(te:TimerEvent):void {
			var mon:S5_plate = new S5_plate(mStage, this, player);
			
			mon.x = 10 + 550 * Math.random();
			addChild(mon);
		}
		
		function complete1(te:TimerEvent):void {
			timer.removeEventListener(TimerEvent.TIMER, renderMonster1);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, complete1);
			
			timer = new Timer(2000, 5);
			timer.addEventListener(TimerEvent.TIMER, renderMonster2);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, complete2);
			timer.start();
		}
		
		function complete2(te:TimerEvent):void {
			if(channel)
				channel.stop();
			endStage(6);
		}
		
		function renderMonster2(te:TimerEvent):void {
			var mon:S5_leg = new S5_leg(mStage, this, player);
			var snd:Sound = new Sound();   
			snd.load(new URLRequest("MySound/step.mp3"));
			channel=snd.play(0,1);
			mon.x = 250 * Math.random();
			mon.y = 0 - this.height;
			addChild(mon);
		}
		
		function onWheel(me:MouseEvent):void{
			endStage(6);
		}
		
		function endStage(signal:int):void {
			timer.stop();
			if(channel)
				channel.stop();
			while (this.numChildren > 0) {
				if(this.getChildAt(0) is S5_objects)
					(this.getChildAt(0) as S5_objects).destructor();
				else
					removeChildAt(0);
			}
			this.removeEventListener(Event.ENTER_FRAME, update);
			parent.removeChild(this);
			delete this;
			mmain.changeStage(signal);
		}
	}
}