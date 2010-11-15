package com.detager.mobile.services
{
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;

	public class ServiceLocator
	{
		
		private static var _instance:ServiceLocator;
		
		private var channels:ChannelSet;
		
		public function ServiceLocator()
		{
			var amfChannel:AMFChannel = new AMFChannel();
			amfChannel.url = "http://detager.com/services/amf";
			
			channels = new ChannelSet();
			channels.addChannel(amfChannel);
		}
		
		public static function get instance():ServiceLocator
		{
			if (!_instance)
				_instance = new ServiceLocator();
			return _instance;
		}
		
		private var _userService:IUserService;
		public function get userService():IUserService
		{
			if (!_userService)
				_userService = new UserService(channels);
			return _userService;
		}
		
		private var _bookmarkService:IBookmarkService;
		public function get bookmarkService():IBookmarkService
		{
			if (!_bookmarkService)
				_bookmarkService = new BookmarkService(channels);
			return _bookmarkService;
		}

	}
}