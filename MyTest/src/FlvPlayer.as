package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class FlvPlayer
	{
		
		private var stage:Stage;
		private var root:Sprite;
		public var videoConnection:NetConnection;
		public var videoStream:NetStream;
		public var sv:StageVideo;
		private var video:Video;
		public var flv:String;
		private var sprite_btn:Sprite;
		private var btn_bitmap:Bitmap;
		private static var _ins:FlvPlayer;
		public function FlvPlayer()
		{
//			this.root = Global.root;
		}
		
		public function setRoot(sprite:Sprite):void{
			this.root = sprite;
		}
		
		protected function onSkip(event:MouseEvent):void
		{
			this.closeFlv();
		}
		
		public function play(path:String = "new"):void{
			flv = "asset/video/" +path + ".mp4";
			root.stage.addEventListener("stageVideoAvailability", onStageVideoAvailability);
		}
		
		protected function onStageVideoAvailability(e:StageVideoAvailabilityEvent):void
		{
			root.stage.removeEventListener("stageVideoAvailability", onStageVideoAvailability);
			/*connectStream(false);
			return;*/
			if((e.availability == "available"))//表示硬件加速可用
			{
				connectStream(true);
			}else
			{
				connectStream(false);
			}
		}
		
		/*****判断是video 还是 stageVideo***/
		private var isVideo:Boolean = true;
		private function connectStream(boo:Boolean):void
		{
			videoConnection = new NetConnection( );
			videoConnection.connect(null);
			videoStream=new NetStream(videoConnection);
			videoStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			videoStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			//设定client属性为customclient对象。那么customclient对象的两个方法将被调用。   
			var customclient:Object = new Object();  
			customclient.onCuePoint = cuePointHandler;   
			customclient.onMetaData = metaDataHandler;
			videoStream.client = customclient;
			
			if(boo)
			{
				isVideo = false;
				sv = root.stage.stageVideos[0];
				sv.attachNetStream(videoStream);
//				sv.viewPort  = (root as MainStarling).viewPort;
				sv.viewPort = new Rectangle(0,0,960,640);
			}else
			{
				isVideo = true;
				video = new Video(960,640);
				video.smoothing = true;
				video.attachNetStream(videoStream);
				root.stage.addChild(video);
			}
			addSkipBtn();
			videoStream.play(flv);
		}
		
		private function addSkipBtn():void{
			sprite_btn = new Sprite();
			btn_bitmap = new AssetEmbeds_2x.btn_skip();
			sprite_btn.addChild(btn_bitmap);
			root.stage.addChild(sprite_btn);
			sprite_btn.addEventListener(MouseEvent.CLICK,onSkip);			
		}
		
		private function removeSkipBtn():void{
			sprite_btn.removeEventListener(MouseEvent.CLICK,onSkip);
			if(sprite_btn.parent){
				sprite_btn.parent.removeChild(sprite_btn);
			}
//			this.root.stage.removeChild(sprite_btn);
			btn_bitmap.bitmapData.dispose();
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					//					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					break;
				case "NetStream.Play.Stop":
					closeFlv();
					break;
			}
			
		}
		private function cuePointHandler(infoObject:Object):void{ 
		}
		
		private function metaDataHandler(infoObject:Object):void{ 
			videoStream.seek(videoStream.time);
		}
		
		public function closeFlv():void{
			videoStream.close();
			videoStream.dispose();
			videoConnection.close();
			removeSkipBtn();
			if(video){
				video.clear();
				root.stage.removeChild(video);
			}else if(sv){
				
			}
		}
		
		public function resume():void
		{
			videoStream.pause();
			videoStream.seek(0);
			videoStream.resume();
		}
		
		public static function get ins():FlvPlayer
		{
			return _ins ||=new FlvPlayer;
		}
	}
}