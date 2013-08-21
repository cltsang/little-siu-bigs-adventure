package{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Stage3 extends MovieClip{
		var mTimer:Timer = null;
		var mScore:int = 100;
		var mS3player:S3player = null;
		var mStage:Stage = null;
		var mmain:Main = null;
		var channel:SoundChannel;
		
		protected var mKiller:TKiller = new TKiller();
		protected var mCollisionTester:TCollisionTester = null;
		
		public function Stage3(_stage:Stage, main:Main):void {
			var snd:Sound = new Sound();   
			mStage = _stage;
			mStage.frameRate = 30;
			mmain = main;
			mCollisionTester = new TCollisionTester(this);
			
			this.addEventListener(Event.ENTER_FRAME, Update);
			
			mTimer = new Timer(1000, 30);
			mTimer.addEventListener(TimerEvent.TIMER, CallTimer1);
			mTimer.addEventListener(TimerEvent.TIMER_COMPLETE, complete1);
			mTimer.start();
			
			mS3player = new S3player(mStage, this, 5, mKiller, mCollisionTester, 200);
			this.addChild(mS3player);
			snd.load(new URLRequest("MySound/swim.mp3"));
			channel=snd.play(0,100);
			mS3player.scaleX = mS3player.scaleY = 0.2;
			mS3player.x = 100;
			mS3player.y = 100;
		}
		
		protected function Update(e:Event):void{
			mKiller.Kill();
			mCollisionTester.Detect();
			
			for (var i:int = 0; i < this.numChildren; i++ ) {
				if (getChildAt(i) is Monsters) {
					if (getChildAt(i).hitTestObject(mS3player)) {
						endStage(10);
					}
				}
			}
		}
		
		function endStage(signal:int):void{
			mTimer.stop();
			mTimer = null;
			mS3player.destructor();
			channel.stop();
			this.removeEventListener(Event.ENTER_FRAME, Update);
			mmain.removeChild(mmain.currentStage);
			mmain.changeStage(signal);
		}
		
		function complete1(te:TimerEvent):void{
			mTimer.removeEventListener(TimerEvent.TIMER, CallTimer1);
			mTimer = new Timer(1001, 6);
			if(mTimer.hasEventListener(TimerEvent.TIMER))
				mTimer.removeEventListener(TimerEvent.TIMER, CallTimer1);
			mTimer.addEventListener(TimerEvent.TIMER, CallTimer2);
			mTimer.addEventListener(TimerEvent.TIMER_COMPLETE, complete2);
			mTimer.start();
		}
		
		function complete2(te:TimerEvent):void{
			mTimer.removeEventListener(TimerEvent.TIMER, CallTimer2);
			mTimer = new Timer(1002, 1);
			if(mTimer.hasEventListener(TimerEvent.TIMER))
				mTimer.removeEventListener(TimerEvent.TIMER, CallTimer2);
			mTimer.addEventListener(TimerEvent.TIMER, complete3);
			mTimer.start();
		}
		
		function complete3(te:TimerEvent):void{
			mTimer.removeEventListener(TimerEvent.TIMER, complete3);
			endStage(4);
		}
		
		function CallTimer2(te:TimerEvent):void{
			rendMonster(3);
		}
		
		protected function CallTimer1(te:TimerEvent):void{
			rendMonster((int)(1+2*Math.random()));
		}
		
		function rendMonster(flag:int):void{
			var m1:Monsters = null;

			switch(flag){
				case 1:
					m1 = new S3_monster1(mStage, this, mKiller, mCollisionTester);
					break;
				case 2:
					m1 = new S3_monster2(mStage, this, mKiller, mCollisionTester);
					break;
				case 3:
					m1 = new S3_monster3(mStage, this, mKiller, mCollisionTester);
					break;
			}
			this.addChild(m1);
			m1.x = 500 + 200 * Math.random();
			m1.y = 100 + 200 * Math.random();
			mKiller.AddEntity(m1);
			mCollisionTester.AddEntity(m1);
		}
		
		public function AddScore(score:Number):void{
			mScore += score;
//			iScore.text = " " + mScore;
		}
	}
}