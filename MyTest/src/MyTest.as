package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
	public class MyTest extends Sprite
	{
		public function MyTest()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
//			add(1,2);
//			adda("110000","adfs",123123);
//			trace(add.length,add.prototype);
//			fun(1,32);
//			var f = new fun(1,2,"fuck");
//			f.namee = "sada";
//			trace("f.name:"+f.name,f.namee);
			
			/*var a:TestRegExp;
			var b:TestRegExp = a;
			a = new TestRegExp();
			if(b)
			{
				
			}*/
			
			return;
			this.testRand();
			TestRegExp.testReg();
		}
		
		
		private var fun:Function = function(a:int,b:int,n:String):void
		{
				trace(" a   b  "+(a+b));
				this.name = n;
		}
		
		private function add(a:int,b:int):void
		{
			for(var i:int = 0;i<arguments.length;i++)
			{
				trace(arguments[i]);
			}
		}
		
		private function adda(...a):void
		{
			trace(a);
		}
		
		private function testRand():void
		{
		
			/**
			 * 
			 * 
			 * function lcg(seed){
					return {
						random:function(){
							seed = (1103515245 * seed + 12345) % 0x80000000;
							return seed / 0x80000000;
						}
					}
				}
			 * 
			 * 
			 * **/
			
			index++;
			var st :uint = setTimeout(testRand,1);
			if(index>=100)
			{
				clearTimeout(st);
			}
			
			trace(randomer.random())
		}
		private var index:int = 0;
		public var randomer:Object = lcg(new Date().getTime());
		public function lcg(seed):Object{
			trace("seed = ",seed);
			return {
				random:function():Number{
					seed = (1103515245 * seed + 12345) % 0x80000000;
					return seed / 0x80000000;
				}
			}
		}
			
	}
}