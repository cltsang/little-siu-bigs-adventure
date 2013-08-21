package{
	import flash.display.MovieClip;

	public class TEntity extends MovieClip{
		protected var mIsActive:Boolean = true;
		protected var mIsCollided:Boolean = false;
		
		public function TEntity():void{			
		}
		
		public function SetCollided(flag:Boolean):void{
			mIsCollided = flag;
		}
		
		public function IsCollided():Boolean{
			return mIsCollided;
		}
		
		public function Deactivate():void{
			mIsActive = false;
		}
		
		public function IsActive():Boolean{
			return mIsActive;
		}
	}
	
}