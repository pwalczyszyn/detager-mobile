package com.detager.mobile.models.presentation
{
	import com.detager.mobile.events.ChangeViewEvent;
	import com.detager.mobile.events.GlobalDispatcher;
	import com.detager.mobile.services.IBookmarkService;
	import com.detager.mobile.services.ServiceHelper;
	import com.detager.mobile.services.ServiceLocator;
	import com.detager.mobile.views.BookmarkView;
	import com.detager.models.domain.Bookmark;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class HomePM
	{
		
		private var bookmarkService:IBookmarkService;
		
		private var since:Date;
		
		[Bindable]
		public var bookmarks:ArrayCollection;
		
		private var allBookmarks:ArrayCollection;
		
		private var userBookmarks:ArrayCollection;
		
		public function HomePM()
		{
			bookmarkService = ServiceLocator.instance.bookmarkService;
		}

		private var _showAll:Boolean = true;
		
		[Bindable]
		public function set showAll(value:Boolean):void
		{
			_showAll = value;
			setBookmarks();
		}

		public function get showAll():Boolean
		{
			return _showAll;
		}
		
		private function setBookmarks():void
		{
			if (_showAll)
				bookmarks = allBookmarks;
			else
				bookmarks = userBookmarks;
		}
		
		public function lstBookmarks_changeHandler(bookmark:Bookmark):void
		{
			GlobalDispatcher.dispatchEvent(new ChangeViewEvent(ChangeViewEvent.CHANGE_VIEW, BookmarkView, bookmark)); 
		}

		public function loadBookmarks():void
		{
			ServiceHelper.call(bookmarkService.loadLatest(since), loadLatest_resultHandler, load_faultHandler);
			ServiceHelper.call(bookmarkService.loadUserBookmarks(), loadUserBookmarks_resultHandler, load_faultHandler);
		}
		
		private function loadUserBookmarks_resultHandler(event:ResultEvent):void
		{
			userBookmarks = ArrayCollection(event.result);
			setBookmarks();
		}
		
		private function loadLatest_resultHandler(event:ResultEvent):void
		{
			allBookmarks = ArrayCollection(event.result);
			setBookmarks();
		}
		
		private function load_faultHandler(event:FaultEvent):void
		{
			trace("error loading latest bookmarks!");
		}
	}
}