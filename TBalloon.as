package{
	import flash.display.*;
	import flash.events.*;
	
	public class TBalloon extends Monsters{
		protected var mSpeed:Number = 0;
		
		protected var mInitX:Number = 0;
		protected var mTime:Number = 0;
		protected var mMagX:Number = 10;
		
		public function TBalloon(speed:Number):void{
			mSpeed = speed;
			this.addEventListener(Event.ENTER_FRAME, Update);
			
			mMagX = 10 + 40 * Math.random();
			
			this.mIsActive = true;
		}
		
		protected function Update(e:Event):void{			
			if (mTime == 0)
				mInitX = this.x;
			
			this.y -= mSpeed;
			this.x = mInitX + Math.sin(mTime) * mMagX;
			
			if (this.x > 850 || this.x < -50 || this.y < -50 || this.y > 650){
				this.mIsActive = false;
			}
			
			mTime += 0.1;
		}
	}
}