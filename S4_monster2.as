package{
	import flash.events.*;
	import flash.display.*;
	
	public class S4_monster2 extends Monsters2{
		var speed:Number;
		var hp:Number;
	
	//	var thisMonster:MovieClip = null;
	//	var thisParent:MovieClip = null;
		var mplayer:MovieClip = null;
		var mstage:Stage = null
		var mstage4:Stage4 = null;
		
		public function S4_monster2(_stage:Stage, _stage4:Stage4, _player:MovieClip):void{
			this.mstage = _stage;
			this.mplayer = _player;
			this.mstage4 = _stage4;
			
			speed = 10;
			hp = 100;
			
			this.scaleX = this.scaleY = 0.0;
			
			this.addEventListener(Event.ADDED, main);
		}
		
		function main(e:Event):void{
		//	thisMonster = MovieClip(this.parent.getChildByName(this.name));
		//	thisParent = e.currentTarget.parent;
			
			this.hpBar.mouseEnabled = false;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, getShot);
			this.addEventListener(Event.ENTER_FRAME, moveMonster);
		}
		
		function moveMonster(e:Event):void{
			var xDisplace:Number;
			if (Math.sqrt(Math.pow(this.x - mstage.stageWidth/2, 2) + Math.pow(this.y - mplayer.y, 2)) <= 50) {
				mstage4.decreaseHP(10);
				this.gotoAndPlay("attacks");
				this.y -= 300;
			}
			else {
				xDisplace = mstage.stageWidth/2 - this.x ;
				if (xDisplace >= 0) {
					if (xDisplace >= 50){
						xDisplace = 8;
					}
					else{
						xDisplace = 50 * Math.random();
					}
				}
				else {
					if (xDisplace <= -50){
						xDisplace = -8;
					}
					else{
						xDisplace = -50 * Math.random();
					}
				}
				
				this.x += xDisplace;
				
				if(this.x<0+this.width/2){
					this.x = 0;
				}
				else if(this.x>mstage.stageWidth-this.width/2){
					this.x = mstage.stageWidth;
				}
				
				this.y += speed; //Math.sqrt(Math.pow(50,2) - Math.pow(xDisplace, 2));
			}
			
			this.scaleX = this.scaleY = calculateScale();
		}
		
		function getShot(me:MouseEvent):void{
			hp -= 100;
			if (hp <= 0) {
				hpBar.scaleX = 0;
				this.gotoAndPlay("dies");
				destructor();
				
				//me.updateAfterEvent();
				//me.target.parent.removeChild(thisMonster);
			}
			else{
				this.gotoAndPlay("hurts");
				this.hpBar.scaleX = hp/100;
				speed -= 10;
			}
		}
		
		private function calculateScale():Number{
			var farest:Number;
			var thisDistance:Number;
			
			farest = Math.sqrt(Math.pow(mstage.stageHeight/2, 2) + Math.pow(mstage.stageWidth/2, 2));
			thisDistance = Math.sqrt(Math.pow(mstage.stageHeight-this.y , 2) + Math.pow(this.x-mstage.stageWidth/2, 2));
			
			return ((farest-thisDistance)/farest);
		}
		
		public override function destructor():void {
			this.removeEventListener(Event.ADDED, main);
			this.removeEventListener(Event.ENTER_FRAME, moveMonster);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, getShot);
			
			this.x = this.y = 0;
			
			parent.removeChild(this);
			delete this;
		}
	}
}