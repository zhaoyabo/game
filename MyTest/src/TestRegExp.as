package 
{
	public class TestRegExp
	{
		public function TestRegExp()
		{
			var s:String = "    ads    fa    d";
			var reg:RegExp = /\s*/g;
			s = s.replace(reg,"");
			
			var str1:String = "a2bc12 def34"; 
			var pattern:RegExp = /([a-z]+)([0-9]+)/g; 
			var str2:String = str1.replace(pattern, replFN);
			trace (str2); 
			// 12abc 34def 
			function replFN():String { return arguments[2] + arguments[1]; }
			
			testReg();
		}
		
		public static  function testReg():void
		{
			var reg:RegExp = /^Backpack\.items\.(\d{1,})\.number$/;
			var str:String = "Backpack.items.312212.number1";
			var boo:Boolean = reg.test(str);
			trace("匹配背包物品:"+boo);
			
			var obj:Object = reg.exec(str);
			trace(">>>>>>>>>>>："+obj);
			
			var name:String = "ad fads    f";
			var r:RegExp = /\s/g;
			name = name.replace(r,"");
			trace("name:"+name);
			
			var numReg:RegExp = /\d{1,}/;   
			var numStr:String = "Backpack.132.asdf.sd21";
//			numStr = numStr.replace(numReg,"");
			numStr = numReg.exec(numStr);
			trace("numStr:"+numStr);
			
			var num:String = "123134154";
			var arrNum:Array = num.split("");
			trace("arrNum:"+arrNum);
		}
		
		public static function testSort():void
		{
			var arr:Array = [[20,"dafas"],[15,"adf"],[55,""]];
			trace(arr);
			arr = arr.sortOn(arr,Array.DESCENDING);
			trace(arr);
		}
	}
}