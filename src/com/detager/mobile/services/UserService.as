package com.detager.mobile.services
{
	import mx.messaging.ChannelSet;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;

	public class UserService implements IUserService
	{
		private var remoteObject:RemoteObject;
		
		public function UserService(channels:ChannelSet)
		{
			remoteObject = new RemoteObject("zend");
			remoteObject.source = "UsersService";
			remoteObject.channelSet = channels;
		}
		
		public function signOut():AsyncToken
		{
			return remoteObject.signOut();
		}

		public function signIn(username:String, password:String):AsyncToken
		{
			remoteObject.setCredentials(username, password);
			return remoteObject.signIn();
		}
	}
}