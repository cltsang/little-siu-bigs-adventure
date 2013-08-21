package{
	import flash.events.*;
	import flash.display.*;
	
	public class S4_monster1 extends Monsters2{
		var speed:Number;
		var hp:Number;
	
		var thisMonster:MovieClip = null;
		var thisParent:MovieClip = null;
		
		var mplayer:MovieClip = null;
		var mstage:Stage = null;
		var mstage4:Stage4 = null;
//		var hpBar:MovieClip = null;
		
		protected var mInitX:Number = 0;
		protected var mTime:Number = 0;
		protected var mMagX:Number = 10;
		
		public function S4_monster1(_stage:Stage, _stage4:Stage4, _player:MovieClip):void{
			mstage = _stage;
			mplayer = _player;
			mstage4 = _stage4;
//			this.hpBar = this.getChildByName("hpBar") as MovieClip;
			
			speed = 10;
			hp = 100;
			
			this.scaleX = this.scaleY = 0.0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, main);
		}
		
		function main(e:Event):void{
			mInitX = this.x;
			mMagX = 100 + 100 * Math.random();
			
			this.addEventListener(Event.ENTER_FRAME, moveMonster);
			this.addEventListener(MouseEvent.MOUSE_DOWN, getShot);
		}
		
		function moveMonster(e:Event):void{
			var xDisplace:Number;
			
			mTime += 0.2;

			if (this.y>=mplayer.y){//(Math.sqrt(Math.pow(this.x - mplayer.x, 2) + Math.pow(this.y - mplayer.y, 2)) <= 50) {
//				e.target.root.decreaseHP(10);
				mstage4.decreaseHP(7);
				this.gotoAndPlay("attacks");
				
				destructor();
			}
			else {
				this.x = mInitX + Math.sin(mTime) * mMagX;
				this.y += speed;
			}
			
			this.scaleX = this.scaleY = calculateScale();
		}
		
		function getShot(me:MouseEvent):void {			
			if (me.target is mos2 || me.target is hitarea) {
				hp -= 50;
				if (hp <= 0) {
					hpBar.scaleX = 0;
					this.gotoAndPlay("dies");
					destructor();
				}
				else{
					this.gotoAndPlay("hurts");
					hpBar.scaleX = hp/100;
					speed -= 2;
				}
			}
		}
		
		function calculateScale():Number{
			var farest:Number;
			var thisDistance:Number;
			
			farest = Math.sqrt(Math.pow(600/2, 2) + Math.pow(400, 2));
			thisDistance = Math.sqrt(Math.pow(600-this.y , 2) + Math.pow(this.x-400, 2));
			
			return ((farest-thisDistance)/farest);
		}
		
		public override function destructor():void {
			this.removeEventListener(Event.ADDED_TO_STAGE, main);
			this.removeEventListener(Event.ENTER_FRAME, moveMonster);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, getShot);
						
			parent.removeChild(this);
			delete this;
		}
	}
}