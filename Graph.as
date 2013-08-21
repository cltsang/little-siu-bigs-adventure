package{
	import flash.display.MovieClip;
	public class Graph extends MovieClip{
		public function Graph(){
			
		}
		
		function nonHit():void {
			this.gotoAndStop("incorrect");
		}
		function Hit():void {
			this.gotoAndStop("correct");
		}
	}
}