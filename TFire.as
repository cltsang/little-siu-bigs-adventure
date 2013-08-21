package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TFire extends Players{
		protected var mSpeed:Number = 2;
		
		public function TFire(speed:Number = 2):void{
			mSpeed = speed;
			this.addEventListener(Event.ENTER_FRAME, Update);
			this.mIsActive = true;
		}
		
		protected function Update(e:Event):void{
			this.x += mSpeed;
			
			if (this.x > 810 || this.x < -10 || this.y < -10 || this.y > 610){
				this.mIsActive = false;
			}/*
			if(boss)
				if (this.hitTestObject(boss)){
					boss.decreaseHP();
				}*/
		}
	}
	
}