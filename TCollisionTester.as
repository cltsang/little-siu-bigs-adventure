package{
	import flash.display.*;
	 
	public class TCollisionTester extends Object{
		protected var mEntities:Array = new Array();
		
		protected var mMain:Stage3 = null;
		
		public function TCollisionTester(main:Stage3 = null):void{
			mMain = main;
		}
		
		public function Detect():void{
			var i:int;
			
			for (i = 0; i < mEntities.length; i++){
				if (!mEntities[i].IsActive()){
					mEntities.splice(i, 1);
					i--;
				}
			}
			
			// hit tests for each pair
			for (i = 0; i < mEntities.length; i++){
				for (var j:int = 0; j < mEntities.length; j++){
					if (i != j){
						if (!AreSameType(mEntities[i], mEntities[j])){						
							if (mEntities[i].hitTestObject(mEntities[j]) == true){
								mEntities[i].SetCollided(true);
								mEntities[j].SetCollided(true);
							}
						}
					}
				}
			}
			
			for (i = 0; i < mEntities.length; i++){
				if (mEntities[i].IsCollided()){
					if (mEntities[i] is Players)
						mEntities[i].Deactivate();
					else if (mEntities[i] is Monsters){
						// TBallon being hitted
						mEntities[i].play();
						
						if (mMain){
							mMain.AddScore(100);
						}
					}
					
					mEntities.splice(i, 1);
					i--;
				}
			}
		}
		
		protected function AreSameType(obj1:TEntity, obj2:TEntity):Boolean{
			if (obj1 is Monsters && obj2 is Monsters)
				return true;
			
			if (obj1 is Players && obj2 is Players)
				return true;
			
			return false;
		}
		
		public function AddEntity(entity:TEntity):void{
			if (entity)
				mEntities.push(entity);
		}		
	}
	
}