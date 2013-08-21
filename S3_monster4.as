package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	
	public class S3_monster4 extends MovieClip{
		protected var mSpeed:Number = 0;
		
		protected var mTime:uint = 0;
		private var upPhase:Boolean = false;
		
		var hp:int = 100;
		
		protected var mStage:Stage = null;
		protected var mstage3:Stage3 = null;
		protected var mKiller:TKiller = null;
		protected var mCollisionTester:TCollisionTester = null;
		
		public function S3_monster4(_stage:Stage, stage3:Stage3, killer:TKiller = null, collision_tester:TCollisionTester = null) {
			mStage = _stage;
			mstage3 = stage3;
			mKiller = killer;
			mCollisionTester = collision_tester;
			
			mSpeed = 1 + 4 * Math.random();
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
			
			if(hp<=0){
				//this.gotoAndPlay(dying);
				//mstage3.winStage(null);
			}
		}
		
		function Deactivate():void{
			//parent.remoChild(this);
		}
		
		function decreaseHP():void{
			hp -= 10;
		}
		
		protected function attack():void {
			var bullet:Monsters = null;
			switch(1+3*Math.random()){
				case 1:
					bullet = new S3_bullet1(10);
					break;
				case 2:
					bullet = new S3_bullet2(10);
					break;
				case 3:
					bullet = new S3_bullet3(10);
					break;
				default:
					bullet = new S3_bullet3(10);
					break;
			}
			mstage3.addChild(bullet);
			bullet.x = this.x;
			bullet.y = this.y + this.height/2;
			
			mKiller.AddEntity(bullet);
			mCollisionTester.AddEntity(bullet);
		}
	}
}