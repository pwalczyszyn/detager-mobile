package com.detager.mobile.events
{
	import flash.events.Event;
	
	public class SwitchViewEvent extends Event
	{
		
		public static const SWITCH_VIEW:String = "switchView";
		
		public var viewClass:Class;
		
		public function SwitchViewEvent(type:String, viewClass:Class, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
			this.viewClass = viewClass;
		}
		
		override public function clone():Event
		{
			return new SwitchViewEvent(type, viewClass, bubbles, cancelable);
		}
	}
}