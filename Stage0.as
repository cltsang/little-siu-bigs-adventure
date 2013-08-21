package{
	import flash.events.MouseEvent;
	import flash.display.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Stage0 extends MovieClip {
		var mStage:Stage = null;
		var mmain:Main = null
		var snd:Sound = new Sound();   
		var channel:SoundChannel;
		
		public function Stage0(_stage:Stage, _main:Main) {
			mmain = _main;
			mStage = _stage;
			
			snd.load(new URLRequest("MySound/sleeping.mp3"));
			channel=snd.play(0,100);
			
			S0_start.addEventListener(MouseEvent.CLICK, start);
			S0_load.addEventListener(MouseEvent.CLICK, load);
		}
		
		function start(me:MouseEvent):void {
			mmain.removeChild(mmain.currentStage);
			channel.stop();
//			me.currentTarget.parent.parent.removeChild(this);
			mmain.changeStage(3);
		}
		
		function load(me:MouseEvent):void {
			mmain.load();
			channel.stop();
		}
	}
}