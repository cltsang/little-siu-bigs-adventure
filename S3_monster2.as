package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	
	public class S3_monster2 extends Monsters{
		protected var mSpeed:Number = 0;
		protected var mTime:uint = 0;
		private var upPhase:Boolean = false;
		
		protected var mStage:Stage = null;
		protected var mstage3:Stage3 = null;
		protected var mKiller:TKiller = null;
		protected var mCollisionTester:TCollisionTester = null;
		
		public function S3_monster2(_stage:Stage, stage3:Stage3, killer:TKiller = null, collision_tester:TCollisionTester = null) {
			mStage = _stage;
			mstage3 = stage3;
			mKiller = killer;
			mCollisionTester = collision_tester;
			
			mSpeed = 1 + 4 * Math.random();
			
			this.scaleX = this.scaleY = 0.75;
			
			this.addEventListener(Event.ENTER_FRAME, Update);
			
			this.mIsActive = true;
		}
		
		protected function Update(e:Event):void{
			if(this.upPhase){
				this.y -= mSpeed;
				if (this.y <= 0)
					upPhase = false;
			}
			else{
				this.y += mSpeed;
				if (this.y >= 600)
					upPhase = true;
			}
			
			if (mTime % 60 == 0){
				attack();
			}
			
			mTime += 1;
		}
		
		protected function attack():void {
			var bullet:S3_bullet2 = new S3_bullet2(10);
			mstage3.addChild(bullet);
			bullet.x = this.x;
			bullet.y = this.y + this.height/2;
			
			mKiller.AddEntity(bullet);
			mCollisionTester.AddEntity(bullet);
		}
	}
}