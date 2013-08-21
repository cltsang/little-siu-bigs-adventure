package{
	import flash.display.MovieClip;
	public class Buttons extends MovieClip{
		public function Buttons():void{
			nonHit();
		}
		
		function nonHit():void {
			this.gotoAndStop("nonpush");
		}
		function Hit():void {
			this.gotoAndStop("push");
		}
	}
}