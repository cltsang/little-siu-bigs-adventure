package{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.Timer;
	import flash.net.*;
	import com.five3d.Text3D;
	import flash.media.SoundMixer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Main extends MovieClip{
		public var currentStage:DisplayObjectContainer = null;
		public var stageCount:int = 0;
		var life:int = 3;
		
		// LifeIcon is a heart-shaped picture
		var life1:LifeIcon = new LifeIcon();
		var life2:LifeIcon = new LifeIcon();
		var life3:LifeIcon = new LifeIcon();
		
		// ani is cut scenes, and timer for the length of sepcific cut scenes
		var ani:MovieClip = null;
		var timer:Timer = null;

		// loader to load a previously saved game from a text file
		var loader:Loader;
		
		// handle right click
		var csMenu:ContextMenu = new ContextMenu();
		// two items to be added to the right click menu
		var skip:ContextMenuItem = new ContextMenuItem("skip");
		var save:ContextMenuItem = new ContextMenuItem("save");
		
		// all BGM and sound of cut scenes
		var channel:SoundChannel;
		
		public function Main(){
			// remove useless items in the right click menu
			csMenu.hideBuiltInItems();
			this.contextMenu = csMenu;
			skip.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onSkip);
			save.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onSave);
			
			// place the LifeIcons on the top-left hand corner
			life1.y = life2.y = life3.y = 38;
			life1.x = 90;
			life2.x = 130;
			life3.x = 170;
			// put them onto the top layer
			addChildAt(life1, 0);
			addChildAt(life2, 0);
			addChildAt(life3, 0);
			life1.visible = life2.visible = life3.visible = false;
			
			changeStage(0);
		}
		
		// called when the user choose to continue after losing one life
		function contin():void {
			changeStage(stageCount);
		}
		
		// read the content of the file
		private function progressListener(e:Event):void{
			if(e.currentTarget.bytesAvailable != 0){
				stageCount = (int)(e.currentTarget.readByte()-48);
				life = (int)(e.currentTarget.readByte()-48);
				
				changeStage(stageCount);
			}
		}
		
		// load saved game from a text file
		function load():void {
			removeChild(currentStage);
			
			var request:URLRequest = new URLRequest("data.txt");
			var	streamer:URLStream = new URLStream();
			streamer.load(request);
			streamer.addEventListener(ProgressEvent.PROGRESS, progressListener);
		}
		
		function remove(me:MouseEvent):void{
			me.currentTarget.removeEventListener(MouseEvent.CLICK, remove);
			me.currentTarget.parent.removeChild(me.currentTarget);
			channel.stop();
			//removeChild(loader);
			//me.currentTarget.parent.removeChild(me.currentTarget);
			changeStage(0);
		}
		
		// run the desingated stage
		function changeStage(signal:int) {
			life1.visible = life2.visible = life3.visible = false;
			stage.frameRate = 12;
			
			if(channel)
				channel.stop();
			
			switch(signal) {
				case 10: // the 'you lose' scene
					life--;
					
					// remove the skip and save options from the right click menu
					csMenu.customItems.pop();
					csMenu.customItems.pop();
					
					// check if there is remaining lifes
					if(life >= 0){
						currentStage = new Stage10(stage, this);
						addChild(currentStage);
					}
					else{
						// display the 'Game Over' movieclip
						var text3d:Text3D = new Text3D(stage);
						channel.stop();
						var snd:Sound = new Sound();
						snd.load(new URLRequest("MySound/gameover.mp3"));
						channel=snd.play(0,1);
						addChild(text3d);
						text3d.addEventListener(MouseEvent.CLICK, remove);
						/*
						loader = new Loader();
						loader.load(new URLRequest("game_over.swf"));
						addChild(loader);
						trace("exe");
						stage.addEventListener(MouseEvent.CLICK, remove);
						*/
					}
					break;
				case 0: // the welcome scene
					life = 3;
					stageCount = 0;
					
					// the welcome scene dose not need the 'skip' or 'save' option on the right-click menu
					csMenu.customItems.pop();
					csMenu.customItems.pop();
					
					stageCount = 0;
					currentStage = new Stage0(stage, this);
					addChild(currentStage);
					break;
				case 3:
					stageCount = 3;
					
					// allow users to skip the cut scene through the 'skip' option on the right click menu
					csMenu.customItems.push(skip);
					ani = new cs_0to3();
					
					// put the cut scene movieclip onto the Stage
					this.addChild(ani);
					
					// 270 is the number of frames of the cut scene, 60 is the number of frames of the instruction page
					timer = new Timer(1000*(270+60)/stage.frameRate, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete3);
					timer.start();
					break;
				case 4:
					stageCount = 4;
					csMenu.customItems.push(skip);
					ani = new cs_3to4();
					this.addChild(ani);
					timer = new Timer(1000*(162+60)/stage.frameRate, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete4);
					timer.start();
					break;
				case 5:
					stageCount = 5;
					csMenu.customItems.push(skip);
					ani = new cs_4to5();
					this.addChild(ani);
					timer = new Timer(1000*(75+60)/stage.frameRate, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete5);
					timer.start();
					break;
				case 6:
					stageCount = 6;
					csMenu.customItems.push(skip);
					ani = new cs_5to6();
					this.addChild(ani);
					timer = new Timer(1000*(230+60)/stage.frameRate, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete6);
					timer.start();
					break;
				case 9:
					stageCount = 9;
					ani = new cs_6to9();
					this.addChild(ani);
					timer = new Timer(1000/97/stage.frameRate, 1);
			}
		}
		
		function timerComplete(url:String):void{
			// remove the cut scene movie clip
			this.removeChild(ani);
			// put the stage onto the Stage object
			this.addChild(currentStage);
			renderLifeIcon();
			
			var snd:Sound = new Sound();
			snd.load(new URLRequest(url));
			channel=snd.play();
			
			csMenu.customItems.pop();
			csMenu.customItems.push(save);
		}
		
		function timerComplete3(te:TimerEvent):void {
			var url:String = "MySound/bg_sound3.mp3";
			currentStage = new Stage3(stage, this);
			timerComplete(url);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete3);
		}
		function timerComplete4(te:TimerEvent):void {
			var url:String = "MySound/bg_sound4.mp3";
			currentStage = new Stage4(stage, this);
			timerComplete(url);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete4);
		}
		function timerComplete5(te:TimerEvent):void {
			var url:String = "MySound/bg_sound5.mp3";
			currentStage = new Stage5(stage, this);
			timerComplete(url);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete5);
		}
		function timerComplete6(te:TimerEvent):void{
			var url:String = "MySound/bg_sound6.mp3";
			currentStage = new Stage6(stage, this);
			timerComplete(url);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete6);
		}
		
		// skip the cutscene when the 'skip' option in the right-click menu is clicked
		function onSkip(cme:ContextMenuEvent):void {
			timer.stop();
			switch(stageCount){
				case 3:
					timerComplete3(null);
					break;
				case 4:
					timerComplete4(null);
					break;
				case 5:
					timerComplete5(null);
					break;
				case 6:
					timerComplete6(null);
					break;
			}
		}
		
		// save is not implemented since this game is supposed to be run in standalone mode
		function onSave(cme:ContextMenuEvent):void {
			
		}
		
		// remove a display object and all its children recursively
		function clearDisplayObjects(obj:DisplayObjectContainer){
			while(obj.numChildren>0){
				if(obj.getChildAt(0) is DisplayObjectContainer)
					clearDisplayObjects(obj.getChildAt(0) as DisplayObjectContainer);
				else
					obj.parent.removeChildAt(0);
			}
		}
		
		// show the LifeIcons and position them onto the top layer
		function renderLifeIcon(){
			switch(life){
				case 3:
					life1.visible = life2.visible = life3.visible = true;
					break;
				case 2:
					life1.visible = life2.visible = true;
					break;
				case 1:
					life1.visible = true;
					break;
				default:
					break;
			}
			setChildIndex(life1, numChildren-1);
			setChildIndex(life2, numChildren-1);
			setChildIndex(life3, numChildren-1);
		}
	}
}