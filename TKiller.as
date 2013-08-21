package{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class TKiller extends Object{
		protected var mEntities:Array = new Array();
		
		public function TKiller():void{
			
		}
		
		public function Kill():void{
			for (var i:int = 0; i < mEntities.length; i++){
				var entity:TEntity = mEntities[i] as TEntity;
				if (entity){
					if (!entity.IsActive()){
						// remove
						var parent:DisplayObjectContainer = entity.parent;
						if (parent){
							parent.removeChild(entity);
							mEntities[i] = null;
						}
					}					
				}
			}
		}
		
		public function AddEntity(entity:TEntity):void{
			if (entity)
				mEntities.push(entity);
		}		
	}
	
}