package{
	import flash.display.MovieClip;
	
	public class Bird_and_boy extends MovieClip{
		public function Bird_and_boy():void{
			this.normal();
		}
		
		function normal():void {
			this.gotoAndStop("stand");
		}
		function wrong():void {
			this.gotoAndPlay("angry");
		}
		function right():void {
			this.gotoAndPlay("eat");
		}
	}
}