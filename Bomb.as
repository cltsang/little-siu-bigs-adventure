package{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Bomb extends MovieClip {
		var counter:int = 5;
		public var timer:Timer = new Timer(1000);
		public function Bomb():void{
			
		}
		function startTimer():void {
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();

		}
		function onTimer(e:TimerEvent):void {
			switch(counter){
				case 5:
					gotoAndStop("five");
					break;
				case 4:
					gotoAndStop("four");
					break;
				case 3:
					gotoAndStop("three");
					break;
				case 2:
					gotoAndStop("two");
					break;
				case 1:
					gotoAndStop("one");
					break;
				case 0:
					timer.stop();
					gotoAndStop("zero");
					break;
				default:
					break;
			}
			counter--;
 		}
 		function getCounter():int{
			return counter;
		}
		function setCounter(counter:int):void {
			this.counter = counter;
		}
	}
}
								