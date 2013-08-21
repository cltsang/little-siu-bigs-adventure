package{
	import flash.display.Shape;
	import flash.display.GradientType;
	
	// draw the bounds of the menu, called by Stage10.as
	public class Block extends Shape{
		public function Block(){
			graphics.lineStyle(5, 0x000000);
			var colors:Array = [0xFF6600, 0xFF9900,0xFFCC00, 0xFF9900,0xFF6600];
			var alphas:Array = [1, 1, 1, 1, 1];
			var ratios:Array = [0, 50,130, 200, 255];
			graphics.beginGradientFill(
				GradientType.LINEAR,
				colors,
				alphas,
				ratios
			);
			graphics.drawRoundRect(-150, -100, 300, 330, 20, 20);
			graphics.endFill();
		}
	}
}