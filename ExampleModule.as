package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	
	public class ExampleModule extends MovieClip {
				
		var gameAPI:Object;
		var globals:Object;
		
		public function ExampleModule() {
		}
		
		public function setup(api:Object, globals:Object) {
			//set our needed variables
			this.gameAPI = api;
			this.globals = globals;
			
			//set the listeners, this one for the button
			this.button1.addEventListener(MouseEvent.CLICK, onButtonClicked);
			//this listener listens to the game event
			this.gameAPI.SubscribeToGameEvent("cgm_player_gold_changed", this.onGoldUpdate);
		}
		
		public function onGoldUpdate(args:Object) : void {
			//get the ID of the player this UI belongs to
			var pID:int = globals.Players.GetLocalPlayer();
			
			//check of the player in the event is the owner of this UI
			if (args.player_ID == pID) {
				//if we can not afford another ability point, we will make the button fly out of the screen
				if (args.gold_amount < 200) {
					this.removeChild(this.button1);
				}
			}
		}
		
		private function onButtonClicked(event:MouseEvent) : void {
			//send the BuyAbilityPoint command to the server with parameter 1 (we don't actually use this, just for demonstration)
			this.gameAPI.SendServerCommand("BuyAbilityPoint 1");
		}
		
		public function screenResize(stageX:int, stageY:int, xScale:Number, yScale:Number){
			//position 'this', being this module, at the center of the screen
			this.x = stageX/2;
			this.y = stageY/2;
			//set the scale of this module
			this.scaleX = xScale;
			this.scaleY = yScale;
		}
	}	
}
