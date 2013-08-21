﻿package{
	import flash.events.*;
	
	public class S3_bullet3 extends Monsters {
		protected var mSpeed:Number = 2;
		
		public function S3_bullet3(speed:Number = 2) {
			mSpeed = speed;
			
			this.scaleX = this.scaleY = 0.65;
			
			this.addEventListener(Event.ENTER_FRAME, Update);
			this.mIsActive = true;
		}
		
		protected function Update(e:Event):void{
			this.x -= mSpeed;
			
			if (this.x > 810 || this.x < -10 || this.y < -10 || this.y > 610){
				this.mIsActive = false;
			}
		}
	}
}