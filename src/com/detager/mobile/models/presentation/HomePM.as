package com.detager.mobile.models.presentation
{
	import com.detager.mobile.services.IBookmarkService;
	import com.detager.mobile.services.ServiceHelper;
	import com.detager.mobile.services.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class HomePM
	{
		
		private var bookmarkService:IBookmarkService;
		
		private var since:Date;
		
		[Bindable]
		public var othersBookmarks:ArrayCollection;
		
		public function HomePM()
		{
			bookmarkService = ServiceLocator.instance.bookmarkService;
		}
		
		public function view_viewActivateHandler():void
		{
			ServiceHelper.call(bookmarkService.loadLatest(since), loadLatest_resultHandler, loadLatest_faultHandler);
		}

		private function loadLatest_resultHandler(event:ResultEvent):void
		{
			othersBookmarks = ArrayCollection(event.result);
		}
		
		private function loadLatest_faultHandler(event:FaultEvent):void
		{
			trace("error loading latest bookmarks!");
		}
	}
}