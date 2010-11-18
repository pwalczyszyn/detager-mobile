package com.detager.mobile.models.presentation
{
	import com.detager.mobile.events.ChangeViewEvent;
	import com.detager.mobile.views.BookmarkView;
	import com.detager.models.domain.Bookmark;
	import com.detager.models.domain.Tag;
	import com.detager.models.domain.TagGroup;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectProxy;

	public class SearchPM
	{
	
		public static const SEARCH_CRITERIA_STATE:String = "SEARCH_CRITERIA_STATE"; 
		
		public static const SEARCH_PROCESS_STATE:String = "SEARCH_PROCESS_STATE";
		
		public static const SEARCH_RESULTS_STATE:String = "SEARCH_RESULTS_STATE";

		[Bindable]
		public var viewState:String;
		
		[Bindable]
		public var selectedTagsLabels:String;

		[Bindable]
		public var tagGroups:ArrayCollection = $.inout("tagGroups", new ArrayCollection);
		
		[Bindable]
		public var searchResults:ArrayCollection;

		public function SearchPM()
		{
			init();
		}
		
		private function init():void
		{
			if (tagGroups.length == 0)
				loadTagGroups();
		}
		
		private function loadTagGroups():void
		{
			$.execute("appDataService", "loadAppData", null, resultHandler, faultHandler);
		}
		
		private function resultHandler(event:ResultEvent):void
		{
			for each(var tg:TagGroup in event.result as ArrayCollection)
			{
				var tags:ArrayCollection = new ArrayCollection();
				for each(var t:Tag in tg.tags)
				{
					tags.addItem(new ObjectProxy({name:t.name, tag:t, selected:false}));
				}
				tagGroups.addItem(new ObjectProxy({name:tg.name, tagGroup:tg, tags:tags}));
			}
		}
		
		private function faultHandler(event:FaultEvent):void
		{
			trace("Error loading tag groups:", event.fault.faultDetail);
		}
		
		public function btnSearch_clickHandler():void
		{
			selectedTagsLabels = "";
			
			var selectedTagsIds:ArrayCollection = new ArrayCollection();
			for each(var tgp:ObjectProxy in tagGroups)
				for each(var tp:ObjectProxy in tgp.tags)
					if (tp.selected)
					{
						selectedTagsIds.addItem(tp.tag.id);
						selectedTagsLabels += tp.tag.name + ", ";
					}
			
			// Removing ", " from the end of the string
			if (selectedTagsLabels.length > 0)
				selectedTagsLabels = selectedTagsLabels.substring(0, selectedTagsLabels.length - 2);
			
			viewState = SEARCH_PROCESS_STATE;

			$.execute("bookmarksService", "searchBookmarks", [null, selectedTagsIds], search_resultHandler, search_faultHandler);
		}
		
		private function search_resultHandler(event:ResultEvent):void
		{
			searchResults = event.result as ArrayCollection;
			viewState = SEARCH_RESULTS_STATE;
		}
		
		private function search_faultHandler(event:FaultEvent):void
		{
			viewState = SEARCH_CRITERIA_STATE;
			trace("error searching for bookmarks:", event.fault.faultDetail);
		}
		
		public function lstBookmarks_changeHandler(bookmark:Bookmark):void
		{
			$.dispatchEvent(new ChangeViewEvent(ChangeViewEvent.PUSH_VIEW, BookmarkView, bookmark)); 
		}

	}
}