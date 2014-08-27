package
{
	public class TestRect
	{
		private static var arr_2:Array;
		public function TestRect()
		{
			
		}
		
		private static function setArr2():void{
			arr_2 = [];
			for(var i:int = 0;i<48;i++){
				arr_2.push(0);
			}
		}
		
		public static function changeArr2(start:int =  15):void{
			setArr2();
			var arr_4_4:Array = [0,1,4,5,8,9];
			var index:int;
			for(var i:int = 0;i<arr_4_4.length;i++){
				index = arr_4_4[i];
				var ss :int = (index%4) + int((index/4))*8  + start;
				arr_2[ss] = 1;
			}
			trace(arr_2.slice(0,8));
			trace(arr_2.slice(8,16));
			trace(arr_2.slice(16,24));
			trace(arr_2.slice(24,32));
			trace(arr_2.slice(32,40));
			trace(arr_2.slice(40,48));
			trace(arr_2);
		}
		
		public static function  callArgs():void{
			var a:Array = [];
			var value:Array = [0,0,1,1,1];
			a.splice.apply(value,value);
			trace("apply:"+ a,a.length);
		}
		
		public static function  callArgs1():void{
			var mc1:Object = new Object()
			var mc2:Object = new Object()
			
			mc1.name = "mc1"
			mc2.name = "mc2"
			
			mc1.i = 123;
			mc1.samcall = function():void{
				trace("当前对象域是:" + this.name + " ,i的值是" + this.i)
			}
			
			mc1.samcall()
			
			mc2.i = 6765;
			mc1.samcall.call(mc2) ; //这里改变了this的引用到mc2中，所以引用this.i时 变为 mc2的 6765
			mc1.samcall.apply(mc2);
		}
		
		public static function testFun():void{
			var t1:test = new test();
			var t2:test = new test();
		}
		
	}
}

class test{
	public var name:String = "";
	public function testFunc():void{
		trace("this name: "+name);
	}
}