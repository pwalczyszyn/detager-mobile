package com.detager.mobile.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class GlobalDispatcher
	{
		private static var instance:IEventDispatcher = new EventDispatcher();
		
		public static function dispatchEvent(event:Event):Boolean
		{
			return instance.dispatchEvent(event);
		}
		
		public static function addEventListener(type:String, listener:Function):void
		{
			instance.addEventListener(type, listener);
		}
	}
}