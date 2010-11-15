package com.detager.mobile.services
{
	import com.detager.models.domain.Bookmark;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.ChannelSet;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	public class BookmarkService implements IBookmarkService
	{
		private var remoteObject:RemoteObject;
		
		public function BookmarkService(channels:ChannelSet)
		{
			remoteObject = new RemoteObject("zend");
			remoteObject.source = "BookmarksService";
			remoteObject.channelSet = channels;
		}
		
		public function create(bookmark:Bookmark):AsyncToken
		{
			return remoteObject.create(bookmark);
		}
		
		public function update(bookmark:Bookmark):AsyncToken
		{
			return remoteObject.update(bookmark);
		}
		
		public function remove(bookmarkId:Number):AsyncToken
		{
			return remoteObject.remove(bookmarkId);
		}

		public function loadLatest(since:Date):AsyncToken
		{
			return remoteObject.loadLatest(since);
		}
		
		public function loadUserBookmarks():AsyncToken
		{
			return remoteObject.loadUserBookmarks();
		}
		
		public function searchBookmarks(searchString:String, searchTagsIds:ArrayCollection):AsyncToken
		{
			return remoteObject.searchBookmarks(searchString, searchTagsIds.source);
		}
		
	}
}