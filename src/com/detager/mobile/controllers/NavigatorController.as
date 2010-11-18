package com.detager.mobile.controllers
{
	import com.detager.mobile.events.ChangeViewEvent;
	
	import spark.components.ViewNavigator;

	public class NavigatorController
	{
		
		private var _navigator:ViewNavigator;
		
		public function set navigator(value:ViewNavigator):void
		{
			_navigator = value;
			$.addEventListener(ChangeViewEvent.PUSH_VIEW, changeView_eventHandler);
			$.addEventListener(ChangeViewEvent.POP_VIEW, changeView_eventHandler);
		}
		
		private function changeView_eventHandler(event:ChangeViewEvent):void
		{
			switch (event.type)
			{
				case ChangeViewEvent.PUSH_VIEW:
					_navigator.pushView(event.viewClass, event.data, event.transition);
					break;
				case ChangeViewEvent.POP_VIEW:
					_navigator.popView(event.transition);
					break;
			}
		}
	}
}