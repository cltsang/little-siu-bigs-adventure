package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;

	public class S3player extends Players{
		protected var mStage:Stage = null;
		protected var mstage3:Stage3 = null;
		protected var mSpeed:Number = 2;
		
		protected var mUpKeyDown:Boolean = false;
		protected var mDownKeyDown:Boolean = false;
		protected var mLeftKeyDown:Boolean = false;
		protected var mRightKeyDown:Boolean = false;
		protected var mSpaceKeyDown:Boolean = false;
		
		protected var mKiller = null;
		protected var mCollisionTester:TCollisionTester = null;
		
		protected var mFireTimer:Timer = null;
		
		protected var mIsFired:Boolean = false;
		
		public function S3player(_stage:Stage, stage3:Stage3, speed:Number = 2, killer:TKiller = null, collision_tester:TCollisionTester = null, fire_hz:Number = 500):void{			
			mStage = _stage;
			mstage3 = stage3;
			this.mSpeed = speed;
			
			mStage.addEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			mStage.addEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
			mStage.addEventListener(Event.ENTER_FRAME, Update);
			
			mKiller = killer;
			mCollisionTester = collision_tester;
			
			mFireTimer = new Timer(fire_hz);
			mFireTimer.repeatCount = 1;
		}
		
		public function destructor():void{
			mFireTimer.stop();
			mStage.removeEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			mStage.removeEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
			mStage.removeEventListener(Event.ENTER_FRAME, Update);
			parent.removeChild(this);
			delete this;
		}
		
		protected function Update(e:Event):void{
			var dir_x:Number = 0;
			var dir_y:Number = 0;
			
			if (mUpKeyDown == true)
				dir_y += -2;
			
			if (mDownKeyDown == true)
				dir_y += 2;
			
			if (mLeftKeyDown == true)
				dir_x += -2;

			if (mRightKeyDown == true)
				dir_x += 2;
			
			Move(dir_x, dir_y);
			
			if (mSpaceKeyDown && !mFireTimer.running){
				// fire
				var fire:TFire = new TFire(10);
				mstage3.addChild(fire);
				fire.x = this.x + this.width;
				fire.y = this.y + this.height/2;
				
				mFireTimer.start();					
				
				if (mKiller)
					mKiller.AddEntity(fire);
				
				if (mCollisionTester)
					mCollisionTester.AddEntity(fire);
			}
		}
		
		protected function HandleKeyUp(e:KeyboardEvent):void{
			if (e.keyCode == 38)
				mUpKeyDown = false;
			else if (e.keyCode == 40)
				mDownKeyDown = false;
			else if (e.keyCode == 37)
				mLeftKeyDown = false;
			else if (e.keyCode == 39)
				mRightKeyDown = false;
			else if (e.keyCode == 32){
				mSpaceKeyDown = false;
				mIsFired = false;
			}
		}
		
		protected function HandleKeyDown(e:KeyboardEvent):void{
			if (e.keyCode == 38)
				mUpKeyDown = true;
			else if (e.keyCode == 40)
				mDownKeyDown = true;
			else if (e.keyCode == 37)
				mLeftKeyDown = true;
			else if (e.keyCode == 39)
				mRightKeyDown = true;
			else if (e.keyCode == 32)
				mSpaceKeyDown = true;
		}
		
		protected function Move(_x:Number, _y:Number):void {
			if(this.x>0 && _x<0)
				this.x += _x * mSpeed;
			if (this.x + this.width < mStage.stageWidth && _x>0)
				this.x += _x * mSpeed;
			if(this.y>0 && _y<0)
				this.y += _y * mSpeed;
			if(this.y+this.height<mStage.stageHeight && _y>0)
				this.y += _y * mSpeed;
		}
	}	
}