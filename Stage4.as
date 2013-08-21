package{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Stage4 extends MovieClip{
		var cursor:S4_cursor = null;
		var gotoScene:uint = 0;
		var mStage:Stage = null;
		var mmain:Main = null;
		var timer:Timer = null;
		var channel:SoundChannel;
		var hp:Number = 100;
		
		public function Stage4(_stage:Stage, _main:Main):void {
			mStage = _stage;
			mmain = _main;
			
			mStage.frameRate = 12;

			cursor = new S4_cursor();
			this.addChild(cursor);
			cursor.visible = false;
			cursor.mouseEnabled = false;
			cursor.mouseChildren = false;
			
			this.addEventListener(Event.ENTER_FRAME, update);
			
			mStage.addEventListener(MouseEvent.MOUSE_MOVE, cursorMove);
			mStage.addEventListener(Event.MOUSE_LEAVE, cursorLeave);
			
			timer = new Timer(1000, 15);
			timer.addEventListener(TimerEvent.TIMER, renderMonster1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, completeRM1);
			timer.start();
		}
		
		function update(e:Event):void{
			if(hpBar){
				hpBar.scaleX = hp/100;
		
				if(hp<=0){				
					//gotoAndStop(1, "Pause");
					endStage(10);
				}
			}
		}
		
		function renderMonster1(te:TimerEvent):void{			
			var mon:S4_monster1 = new S4_monster1(mStage, this, s4_player);
			var snd:Sound = new Sound();   
			mon.x = mStage.stageWidth/2;
			mon.y = 100 * Math.random();
			monster_L2.addChild(mon);
			snd.load(new URLRequest("MySound/mon.mp3"));
			channel=snd.play(0,1);
			te.updateAfterEvent();
		}
		
		function completeRM1(te:TimerEvent):void{
			clearDisplayObjects(monster_L2);
			clearDisplayObjects(monster_L1);
			channel.stop();
			gotoAndPlay("turn");
			
			timer = new Timer(1800, 10);
			timer.addEventListener(TimerEvent.TIMER, renderMonster2);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, completeRM2);
			timer.start();
		}
		
		function renderMonster2(te:TimerEvent):void {
			var mon:S4_monster2 = new S4_monster2(mStage, this, s4_player);
			var snd:Sound = new Sound();   
			monster_L2.addChild(mon);
			snd.load(new URLRequest("MySound/cock.mp3"));
			channel=snd.play(0,1);
			mon.x = mStage.stageWidth / 2;
			mon.y = 100;

			te.updateAfterEvent();
		}
		
		function completeRM2(te:TimerEvent):void {
			clearDisplayObjects(monster_L2);
			clearDisplayObjects(monster_L1);
			channel.stop();
			gotoAndPlay("turn");
			
			timer = new Timer(1000,2);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, renderMonster3);
			timer.start();
		}
		
		function renderMonster3(te:TimerEvent):void {
			var mon:S4_monster3 = new S4_monster3(mStage, this, s4_player);
			var snd:Sound = new Sound(); 
			monster_L2.addChild(mon);
			snd.load(new URLRequest("MySound/mouse.mp3"));
			channel=snd.play(0,2);
			mon.x = mStage.stageWidth / 2 - mon.width/2;
			mon.y = 150;
			
			te.updateAfterEvent();
		}
		
		function clearDisplayObjects(doc:DisplayObjectContainer):void{
			while(doc.numChildren>0){
				if(doc.getChildAt(0) is Monsters2){
					(doc.getChildAt(0) as Monsters2).destructor();
				}
				else if(doc.getChildAt(0) is DisplayObjectContainer){
					clearDisplayObjects(DisplayObjectContainer(doc.getChildAt(0)));
				}
				else
					doc.removeChildAt(0);
			}
		}
		
		public function decreaseHP(hitPoint:Number):void{
			hp -= hitPoint;
		}
		
		function endStage(signal:int):void {
			timer.stop();
			clearDisplayObjects(monster_L2);
			clearDisplayObjects(monster_L1);
			channel.stop();
			this.removeEventListener(Event.ENTER_FRAME, update);
			mStage.removeEventListener(MouseEvent.MOUSE_MOVE, cursorMove);
			mStage.removeEventListener(Event.MOUSE_LEAVE, cursorLeave);
			Mouse.show();
			parent.removeChild(this);
			mmain.changeStage(signal);
		}

		private function cursorMove(me:MouseEvent):void{
			setChildIndex(cursor, numChildren-1);
			Mouse.hide();
			cursor.visible = true;
			cursor.x = me.stageX;
			cursor.y = mouseY;
		}
		
		private function cursorLeave(e:Event):void{
			cursor.visible = false;
			cursorOut(new MouseEvent(MouseEvent.MOUSE_OUT));
		}
		
		private function cursorOut(me:MouseEvent):void {
            Mouse.show();
            cursor.visible = false;
        }
	}
}