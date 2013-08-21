package{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Stage6 extends MovieClip {
		var mButtonS:Button_S = null;
		var mButtonD:Button_D = null;
		var mButtonF:Button_F = null;
		var mButtonJ:Button_J = null;
		var mButtonK:Button_K = null;
		var mButtonL:Button_L = null;
		var mBirdandboy:Bird_and_boy = null;
		var mBomb:Bomb = null;
		var randresult:Array = new Array();
		protected var mSKeyDown:Boolean = false;
		protected var mDKeyDown:Boolean = false;
		protected var mFKeyDown:Boolean = false;
		protected var mJKeyDown:Boolean = false;
		protected var mKKeyDown:Boolean = false;
		protected var mLKeyDown:Boolean = false;
		protected var mSIsPressed:Boolean = false;
		protected var mDIsPressed:Boolean = false;
		protected var mFIsPressed:Boolean = false;
		protected var mJIsPressed:Boolean = false;
		protected var mKIsPressed:Boolean = false;
		protected var mLIsPressed:Boolean = false;
		public var mStage:Stage = null;  
		var channel:SoundChannel;
		var bombchannel:SoundChannel;
		var mmain:Main = null;
		protected var fruit:Array = new Array(7);
		var correct:int = 0;
		var userinput:int = 0;
		var win:int = 0;
		var WON:Boolean = false;
		var IsRemoved:Boolean = false;
		var changeState:Boolean = true;
		
		public function Stage6(_stage:Stage, _main:Main):void{
			mStage = _stage;
			mmain = _main;
			var counter:int = 0 ;

			
			var mBg:stage6bg = new stage6bg();
			renderObject(mBg);
			
			mBirdandboy = new Bird_and_boy();
			renderObject_l(mBirdandboy, 295, 458, 500, 70);
			
			mButtonS = new Button_S();
			renderObject(mButtonS, 40, 330);
			mButtonD = new Button_D();
			renderObject(mButtonD, 145, 330);
			mButtonF = new Button_F();
			renderObject(mButtonF, 250, 330);
			mButtonJ = new Button_J();
			renderObject(mButtonJ, 40, 430);
			mButtonK = new Button_K();
			renderObject(mButtonK, 145, 430);
			mButtonL = new Button_L();
			renderObject(mButtonL, 250, 430);
			
			mBomb = new Bomb();
			renderObject_l(mBomb, 78, 110, 190, 240);
			mStage.addEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			mStage.addEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
			mStage.addEventListener(Event.ENTER_FRAME, Update);
			
			mBomb.setCounter(4);
			mBomb.startTimer();
			var snd:Sound = new Sound(); 
			snd.load(new URLRequest("MySound/bomb2.mp3"));
			bombchannel = snd.play(0, 1);
			myplay(gen_fruit_number(win), 5);
		}
		
		function endStage(signal:int):void{
			mStage.removeEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			mStage.removeEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
			mStage.removeEventListener(Event.ENTER_FRAME, Update);
			channel.stop();
			bombchannel.stop();
			mBomb.timer.stop();
			parent.removeChild(this);
			mmain.changeStage(signal);
		}
		
		private function renderObject_l(obj:DisplayObject, xl:Number, yl:Number, xpos:int=0, ypos:int=0){
			this.addChild(obj);
			obj.width = xl;
			obj.height = yl;
			obj.x = xpos;
			obj.y = ypos;
		}
		
		private function renderObject(obj:DisplayObject, xpos:int=0, ypos:int=0){
			this.addChild(obj);
			obj.x = xpos;
			obj.y = ypos;
		}
		
		private function myplay(number:int, counter:int): void{
			var a:int = 0 ;
			var rand:int = 0 ;
			var posX :int = 5 ;
			var dummy:int = 2;
			if (counter == 5) {
				correct = 0;
				for (a = 0; a < number;a++ ){
					rand = 1 + 6 * Math.random();
					randresult[a] = rand;
					Randfruit(posX, rand, a);
					posX = posX + 75;
					IsRemoved = false;
					WON = false;
				}
			}
		}		
		private function gen_fruit_number(win:int ):int {
			switch(win) {
				case 0:
				case 1:
				case 2:
					changeState = false;
					return (2);
					break;
				case 3:
					changeState = true;
					return (3);
					break;
				case 4:
				case 5:
					changeState = false;
					return (3);
					break;
				case 6:
					changeState = true;
					return (4);
					break;
				case 7:
				case 8:
					changeState = false;
					return (4);
					break;
				case 9:
					changeState = true;
					return (5);
					break;
				case 10:
				case 11:
					changeState = false;
					return (5);
					break;
				case 12:
					changeState = true;
					return (6);
					break;
				case 13:
				case 14:
					changeState = false;
					return (6);
					break;
					
			}
			return (6);
		}
		private function remove():void {
			var a : int = 0;
			for (a = 0 ; a < gen_fruit_number(win); a++) {
				if(fruit[a]!=null){
					fruit[a].visible = false;
					fruit[a] = null;
				}
			}
			IsRemoved = true;
		}
		private function check(randresult:Array,counter:int,keyCode:int):int {
			mBirdandboy.normal();

			if (counter < gen_fruit_number(win) && randresult[counter] == keyCode) {
				correct++;
				if(fruit[counter]!=null)
					fruit[counter].Hit();
				if (correct == gen_fruit_number(win)) {
					var snd:Sound = new Sound(); 
					snd.load(new URLRequest("MySound/bird2.mp3"));
					channel = snd.play(0, 1);
					mBirdandboy.right();
					if(IsRemoved == false)
						remove();
					WON = true;
					win++;	
				}
				
			}
			else if (counter < gen_fruit_number(win) && randresult[counter] != keyCode) {
				correct = 0;
				mBirdandboy.normal();
				for (var loop:int = 0; loop < gen_fruit_number(win); loop++ ) 
					if(fruit[loop]!=null)
						fruit[loop].nonHit();
			}
			return(correct);
		}
		protected function HandleKeyDown(e:KeyboardEvent):void{
			if (e.keyCode == 83 || e.keyCode == 114) {	//S & s
				mSKeyDown = true;
				mButtonS.Hit();
			}
			else if (e.keyCode == 68 || e.keyCode == 100){	//D & d
				mDKeyDown = true;
				mButtonD.Hit();
			}
			else if (e.keyCode == 70|| e.keyCode == 102){	//F & f
				mFKeyDown = true;
				mButtonF.Hit();
			}
			else if (e.keyCode == 74|| e.keyCode == 106){	//J & j
				mJKeyDown = true;
				mButtonJ.Hit();
			}
			else if (e.keyCode == 75|| e.keyCode == 107){	//K & k
				mKKeyDown = true;
				mButtonK.Hit();
			}
			else if (e.keyCode == 76|| e.keyCode == 108){	//L & l
				mLKeyDown = true;
				mButtonL.Hit();
			}
		}
		protected function HandleKeyUp(e:KeyboardEvent):void{
			if (e.keyCode == 83 || e.keyCode == 114) {
				mSIsPressed = false;
				mSKeyDown = false;
				mButtonS.nonHit();
			}
			else if (e.keyCode == 68 || e.keyCode == 100) {
				mDIsPressed = false;
				mDKeyDown = false;
				mButtonD.nonHit();
			}
			else if (e.keyCode == 70 || e.keyCode == 102) {
				mFIsPressed = false;
				mFKeyDown = false;
				mButtonF.nonHit();
			}
			else if (e.keyCode == 74 || e.keyCode == 106) {
				mJIsPressed = false;
				mJKeyDown = false;
				mButtonJ.nonHit();
			}
			else if (e.keyCode == 75 || e.keyCode == 107) {
				mKIsPressed = false;
				mKKeyDown = false;
				mButtonK.nonHit();
			}
			else if (e.keyCode == 76 || e.keyCode == 108) {
				mLIsPressed = false;
				mLKeyDown = false;
				mButtonL.nonHit();
			}
		}
		protected function Update(e:Event):void{
			if (mSKeyDown == true && !mSIsPressed) {
				mSIsPressed = true;
				if(check(randresult, userinput, 1)==0)
					userinput = 0;
				else 
					userinput++;
			}
			if (mDKeyDown == true && !mDIsPressed) {
				mDIsPressed = true;
				if(check(randresult, userinput, 2)==0)
					userinput = 0;
				else 
					userinput++;
			}
			if (mFKeyDown == true && !mFIsPressed) {
				mFIsPressed = true;
				if(check(randresult, userinput, 3)==0)
					userinput = 0;
				else 
					userinput++;
			}

			if (mJKeyDown == true && !mJIsPressed) {
				mJIsPressed = true;
				if(check(randresult, userinput, 4)==0)
					userinput = 0;
				else 
					userinput++;
			}
			if (mKKeyDown == true && !mKIsPressed) {
				mKIsPressed = true;
				if(check(randresult, userinput, 5)==0)
					userinput = 0;
				else 
					userinput++;
			}
			if (mLKeyDown == true && !mLIsPressed) {
				mLIsPressed = true;
				if(check(randresult, userinput, 6)==0)
					userinput = 0;
				else 
					userinput++;
			}
			
			if (WON == true && mBomb.getCounter()<2 && mBomb.getCounter()>=-1) {
				bombchannel.stop();
				userinput = 0;
				mBomb.setCounter(5);		
				myplay(gen_fruit_number(win), mBomb.getCounter());
				mBomb.startTimer();
				var snd3:Sound = new Sound(); 
				snd3.load(new URLRequest("MySound/bomb3.mp3"));
				bombchannel = snd3.play(0, 1);
			}
			if (correct != gen_fruit_number(win) && mBomb.getCounter() == -1 && changeState ==false || (correct+1) != gen_fruit_number(win) && mBomb.getCounter() == -1 && changeState ==true ) { 
				mBirdandboy.wrong();
				changeState = false;
				WON = false;
				var snd:Sound = new Sound(); 
				var snd2:Sound = new Sound(); 
				snd.load(new URLRequest("MySound/monster.mp3"));
				snd2.load(new URLRequest("MySound/shout4.mp3"));
				channel = snd.play(0, 1);
				channel = snd2.play(0, 1);
				var timer:Timer = new Timer(1000*15/mStage.frameRate, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, die);
				timer.start();
			}
			var snd4:Sound = new Sound();
			while (mBomb.getCounter() == -1 && WON ==false) {
				correct = 0;
				userinput = 0;
				if(IsRemoved == false)
					remove();
				mBomb.setCounter(5);		
				myplay(gen_fruit_number(win), mBomb.getCounter());
				mBomb.startTimer();
				snd4.load(new URLRequest("MySound/bomb3.mp3"));
				bombchannel = snd4.play(0, 1);
			}
			
			if (win == 13) {
				channel.stop();
				bombchannel.stop();
				endStage(9);
			}
		}
		
		function die(te:TimerEvent):void {
			channel.stop();
			bombchannel.stop();
			endStage(10);
		}
		
		function Randfruit(posX:int, number:int, fruitPos:int) :void{	
			var mfruit:Graph = null;
		
			switch(number){
				case 1:
					mfruit = new Graph_apple();
					break;
				case 2:
					mfruit = new Graph_durian();
					break;
				case 3: 
					mfruit = new Graph_banana();
					break;
				case 4:
					mfruit = new Graph_watermelon();
					break;
				case 5:
					mfruit = new Graph_mango();
					break;
				case 6:
					mfruit = new Graph_starburry();
					break;
			}
			
			fruit[fruitPos] = mfruit;
			this.addChild(mfruit);
			fruit[fruitPos].nonHit();
			mfruit.x = posX;
			mfruit.y = 100;
		}
	}
}