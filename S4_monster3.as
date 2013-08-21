package{
	import flash.events.*;
	import flash.display.*;
	import flash.utils.Timer;
	
	public class S4_monster3 extends Monsters2{
		var hp:Number;
		
		var mplayer:MovieClip = null;
		var mstage:Stage = null
		var mstage4:Stage4 = null;
		
		var ftimer:Timer = null;
		var btimer:Timer = null;
		
		public function S4_monster3(_stage:Stage, _stage4:Stage4, _player:MovieClip):void{
			this.mstage = _stage;
			this.mplayer = _player;
			this.mstage4 = _stage4;
			
			hp = 100;
			
			this.addEventListener(Event.ADDED_TO_STAGE, main);
		}
		
		function main(e:Event):void {			
			this.hpBar.mouseEnabled = false;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, getShot);
			ftimer = new Timer(3000);
			ftimer.addEventListener(TimerEvent.TIMER, goForth);
			ftimer.start();
		}
		
		function goForth(te:TimerEvent):void {
			this.y += 250;
			
			this.gotoAndPlay("attacks");
			mstage4.decreaseHP(35);
			btimer = new Timer(1000*10/12, 1);
			btimer.addEventListener(TimerEvent.TIMER_COMPLETE, goBack);
			btimer.start();
		}
		
		function goBack(te:TimerEvent):void {
			this.y -= 250;
			
			this.gotoAndPlay("moves");
		}
		
		function getShot(me:MouseEvent):void{
			hp -= 2;
			if (hp <= 0) {
				hpBar.scaleX = 0;
				this.gotoAndPlay("dies");
				destructor();
				mstage4.endStage(5);
			}
			else{
				this.gotoAndPlay("hurts");
				this.hpBar.scaleX = hp/100;
			}
		}
		
		public override function destructor():void {
			this.removeEventListener(Event.ADDED_TO_STAGE, main);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, getShot);
			ftimer.stop();
			btimer.stop();
			
			this.x = this.y = 0;
			
			parent.removeChild(this);
			delete this;
		}
	}
}