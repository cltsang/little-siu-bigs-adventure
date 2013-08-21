package{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class S5_player extends S5_objects{
		var mStage:Stage = null;
		var channel:SoundChannel;
		
		protected var mLeftKeyDown:Boolean = false;
		protected var mRightKeyDown:Boolean = false;
		protected var mSpaceKeyDown:Boolean = false;
		
		var ySpeed:Number = 0;
		var speed:Number = 10;
		var gravity:Number = 0.5;
		
		public function S5_player(_stage:Stage){
			mStage = _stage;
			
			this.scaleX = this.scaleY = 0.2;
			
			mStage.addEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			mStage.addEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
			mStage.addEventListener(Event.ENTER_FRAME, Update);
			this.gotoAndStop("stay");
		}
		
		public override function destructor():void{
			mStage.removeEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			mStage.removeEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
			mStage.removeEventListener(Event.ENTER_FRAME, Update);
			
			parent.removeChild(this);
		}
		
		protected function HandleKeyUp(ke:KeyboardEvent):void{
			if (ke.keyCode == 37)
				mLeftKeyDown = false;
			else if (ke.keyCode == 39)
				mRightKeyDown = false;
			else if (ke.keyCode == 32)
				mSpaceKeyDown = false;
			this.gotoAndStop("stay");
		}
		
		protected function HandleKeyDown(ke:KeyboardEvent):void{
			var snd:Sound;
			
			if (ke.keyCode == 37){
				mLeftKeyDown = true;
				this.scaleX = -0.2;
				this.gotoAndPlay("run");
			}
			else if (ke.keyCode == 39){
				mRightKeyDown = true;
				this.scaleX = 0.2;
				this.gotoAndPlay("run");
			}
			else if (ke.keyCode == 32) {
				
				if(!isFalling() && this.x < 650){
					mSpaceKeyDown = true;
					ySpeed = speed;
					this.gotoAndStop("stay");
				}
			}
		}
		
		private function Update(e:Event):void {
			ySpeed += gravity;
			
			if(!isFalling()){
				if (mLeftKeyDown && this.x-this.width>0)
					this.x -= speed;
				if (mRightKeyDown && this.x+this.width<mStage.stageWidth)
					this.x += speed;
			}
			
			if (mSpaceKeyDown && !isFalling()) {
				ySpeed -= 10;
				var snd:Sound = new Sound();   
				snd.load(new URLRequest("MySound/jump.mp3"));
				channel=snd.play(0,1);
			}
		
			this.y += ySpeed;
		}
		
		private function isFalling():Boolean {
			if (this.y+this.height<520){//((this.y < 520-this.height && this.x < 650) || (this.x >= 650 && this.y < 459+this.height)) {	
				return true;
			}
			else {
				ySpeed = 0;
				return false;
			}
			channel.stop();
		}
	}
}