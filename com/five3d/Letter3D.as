package com.five3d {
	import five3D.display.*;	
	
	public class Letter3D extends DynamicText3D {
		
		private var _angle:Number;
		private var _randomY:Number;
				
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle( n:Number ):void
		{
			_angle = n;	
		}
		
		public function get randomY():Number
		{
			return _randomY;
		}
		
		public function set randomY( n:Number ):void
		{
			_randomY = n;	
		}

		private function randRange(min:Number, max:Number):Number 
		{
		    var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
		    return randomNum;
		}
		
		
		public function Letter3D(typography:Object) {
			super( typography );
			randomY = randRange( -250, 250 );
		}
	}
}
