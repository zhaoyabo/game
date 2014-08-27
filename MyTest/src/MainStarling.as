package
{
	import flash.display.Sprite;
	import flash.display3D.Context3DProfile;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	[SWF(width="960", height="640", frameRate="40", backgroundColor="#0")] 
	public class MainStarling extends Sprite
	{
		private var mStarling:Starling;
		public var viewPort:Rectangle;
		public var screenWidth:Number;
		public var screenHeight:Number;
		
		public function MainStarling()
		{
			trace("fuck");
			FlvPlayer.ins.setRoot(this);
			/*FlvPlayer.ins.play();
			return;*/
			initStarling();
		}
		
		private function initStarling():void{
			viewPort = new Rectangle();
			if(isAndroid || isIOS){
				screenWidth  = stage.fullScreenWidth;
				screenHeight = stage.fullScreenHeight;
			}else{
				screenWidth  = stage.stageWidth;
				screenHeight = stage.stageHeight;
			}
			if (screenHeight / screenWidth < ASPECT_RATIO)
			{
				viewPort.height = screenHeight;
				viewPort.width  = int(viewPort.height / ASPECT_RATIO);
				viewPort.x = int((screenWidth - viewPort.width) / 2);
			}
			else
			{
				viewPort.width = screenWidth; 
				viewPort.height = int(viewPort.width * ASPECT_RATIO);
				viewPort.y = int((screenHeight - viewPort.height) / 2);
			}
			
			Starling.handleLostContext = !isIOS;  // not necessary on iOS. Saves a lot of memory!
			mStarling = new Starling(Vedio,stage,viewPort,null,"auto",Context3DProfile.BASELINE);
			mStarling.stage.stageWidth = STAGE_WIDTH;//设置starling舞台宽为我们制作时宽
			mStarling.stage.stageHeight = STAGE_HEIGHT;//设置starling舞台高为我们制作时高
			mStarling.antiAliasing =1; 
			mStarling.showStats=true;
			mStarling.start();
			FlvPlayer.ins.play();
			mStarling.stage3D.visible = false;
		}
		
		public function get isIOS():Boolean
		{
			var t:String=Capabilities.manufacturer;
			if(Capabilities.manufacturer.indexOf("iOS") >-1){
				return true;
			}else{
				return false;
			}
		}
		public function get isAndroid():Boolean
		{
			if(Capabilities.manufacturer.indexOf("Android")>-1){
				return true;
			}else{
				return false;
			}
		}
		public static const STAGE_WIDTH:int  = 960;
		public static const STAGE_HEIGHT:int = 640;
		public static const ASPECT_RATIO:Number = STAGE_HEIGHT / STAGE_WIDTH;
	}
}