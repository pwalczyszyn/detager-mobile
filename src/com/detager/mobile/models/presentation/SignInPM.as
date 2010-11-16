package com.detager.mobile.models.presentation
{
	import com.detager.mobile.events.ChangeViewEvent;
	import com.detager.mobile.views.HomeView;
	import com.detager.models.domain.SignInResult;
	import com.detager.models.domain.User;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SignInPM extends EventDispatcher
	{
		
		[Bindable]
		public var username:String;

		[Bindable]
		public var password:String;

		[Bindable]
		public var rememberMe:Boolean = false;
		
		[Bindable]
		public var formEnabled:Boolean = true;
		
		public function SignInPM()
		{
			init();
		}
		
		private function init():void
		{
//			username = "pwalczyszyn";
//			password = "password";
		}
		
		public function btnSignIn_clickHandler():void
		{
			var remoteObject:RemoteObject = remoteService.getRemoteObject("usersService");
			remoteObject.setCredentials(username, password);
			remoteService.callDirectly(remoteObject.signIn(), signIn_resultHandler, signIn_faultHandler);
		}

		private function signIn_resultHandler(event:ResultEvent):void
		{
			applicationContext.currentUser = SignInResult(event.result).user; 
			eventDispatcher.dispatchEvent(new ChangeViewEvent(ChangeViewEvent.CHANGE_VIEW, HomeView));
		}
		
		private function signIn_faultHandler(event:FaultEvent):void
		{
			trace("error signing in!");
		}
	}
}