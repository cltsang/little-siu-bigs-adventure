package{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.*;
	import flash.events.*;

	// draw a simple menu displaying a menu, which is displayed when one life is lost
	public class Stage10 extends Sprite {
		var mStage:Stage = null;
		var mmain:Main = null;
		
		public function Stage10(_stage:Stage, _main:Main) {
			mStage = _stage;
			mmain = _main;
			
			var mBlock:Block = new Block();		
			var mTextField:TextField = new TextField();
			var mTextField2:TextField = new TextField();
			var mTextField3:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			
			addChild(mBlock);
			addChild(mTextField);
			addChild(mTextField2);
			addChild(mTextField3);
			
			mBlock.x = mStage.stageWidth / 2;
			mBlock.y = mStage.stageHeight / 2;
			
			mTextField.x = 300;
			mTextField.y = 240;
			mTextField.text = "Continue";
			mTextField.border = true;
			mTextField.borderColor = 0x660000;
			mTextField.width = 200;
			mTextField.height  = 50;
			
			mTextField2.x = 300;
			mTextField2.y = 320;
			mTextField2.text = "Quit";
			mTextField2.border = true;
			mTextField2.borderColor = 0x660000;
			mTextField2.width = 200;
			mTextField2.height  = 50;
			
			mTextField3.x = 80;
			mTextField3.y = 50;
			mTextField3.text = "You lose one life";
			mTextField3.border = false;
			mTextField3.background = false;
			mTextField3.width = 700;
			mTextField3.height  = 100;
			
			format.font = "Arial";
			format.size = 80;
			format.bold = true;
			mTextField3.setTextFormat(format);
			
			format.font = "Arial";
			format.size = 40;
			format.bold = true;
			format.color = 0x660000;
			format.align = "center";
			mTextField.setTextFormat(format);
			mTextField2.setTextFormat(format);
			
			mTextField.addEventListener(MouseEvent.CLICK, contin);
			mTextField2.addEventListener(MouseEvent.CLICK, quit);
		}
		
		function contin(me:MouseEvent):void {
			parent.removeChild(this);
			// restart from the current stage
			mmain.contin();
		}
		
		function quit(me:MouseEvent):void {
			parent.removeChild(this);
			// go back to the welcome scene
			mmain.changeStage(0);
		}
	}
}