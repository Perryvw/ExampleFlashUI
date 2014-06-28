package {
	import flash.display.MovieClip;

	//import some stuff from the valve lib
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	
	public class CustomUI extends MovieClip{
		
		//these three variables are required by the engine
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		
		//constructor, you usually will use onLoaded() instead
		public function CustomUI() : void {
		}
		
		//this function is called when the UI is loaded
		public function onLoaded() : void {			
			//make this UI visible
			visible = true;
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);
			
			//this is not needed, but it shows you your UI has loaded (needs 'scaleform_spew 1' in console)
			trace("Custom UI loaded!");
			
			//pass the gameAPI on to the module
			this.myModule.setup(this.gameAPI, this.globals);
		}
		
		//this handles the resizes - credits to SinZ
		public function onResize(re:ResizeManager) : * {
			//calculate the scaling ratio in the X and Y direction and apply it to the state
			var resWidth:int = 0;
			var resHeight:int = 0;
			if (re.IsWidescreen()) {
				if (re.Is16by9()) {
					//16:9
					resWidth = 1600;
					resHeight = 900;
				} else {
					//16:10
					resWidth = 1280;
					resHeight = 768;
				}
			} else {
				//4:3
				resWidth = 1024;
				resHeight = 768;
			}

			var maxStageHeight:int = re.ScreenHeight / re.ScreenWidth * resWidth;
			var maxStageWidth:int = re.ScreenWidth / re.ScreenHeight * resHeight;
            // Scale hud to screen
			var scaleRatioX:Number = re.ScreenWidth/maxStageWidth;
			var scaleRatioY:Number = re.ScreenHeight/maxStageHeight;
			
			//apply scale ratios to stage
            this.scaleX = scaleRatioX;
            this.scaleY = scaleRatioY;
			
			//You will probably want to scale your elements by 1/scale to keep their original resolution
			
			//Elements are aligned to the top left of the screen in the engine, if you have panels that are not, reposition them here.
			//notice we scale this module by the INVERSE of the scale of the stage
			this.myModule.screenResize(re.ScreenWidth, re.ScreenHeight, 1/scaleRatioX, 1/scaleRatioY);
		}
	}
}