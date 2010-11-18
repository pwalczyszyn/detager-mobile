package com.detager.mobile.models.presentation
{
	import com.detager.mobile.events.ChangeViewEvent;
	import com.detager.mobile.views.HomeView;
	import com.detager.models.domain.SignInResult;
	
	import flash.data.EncryptedLocalStore;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SignInPM extends EventDispatcher
	{
		
		public static const FORM_VIEW:String = "FORM_VIEW";
		
		public static const PROGRESS_VIEW:String = "PROGRESS_VIEW";
		
		[Bindable]
		public var username:String;

		[Bindable]
		public var password:String;

		[Bindable]
		public var rememberMe:Boolean = false;
		
		[Bindable]
		public var viewState:String = FORM_VIEW;
		
		public function SignInPM()
		{
			init();
		}
		
		private function init():void
		{
			var so:SharedObject = SharedObject.getLocal("USER_CREDENTIALS");
			if (so.data.username)
			{
				username = so.data.username;
				if (so.data.password)
					password = so.data.password;
			}
		}
		
		public function btnSignIn_clickHandler():void
		{
			viewState = PROGRESS_VIEW;
			
			var remoteObject:RemoteObject = $.services.getRemoteObject("usersService");
			remoteObject.setCredentials(username, password);
			$.services.executeAsyncToken(remoteObject.signIn(), signIn_resultHandler, signIn_faultHandler);
		}

		private function signIn_resultHandler(event:ResultEvent):void
		{
			if (rememberMe)
			{
				var so:SharedObject = SharedObject.getLocal("USER_CREDENTIALS");
				so.data.username = username;
				so.data.password = password;
				so.flush();
			}
			
			$.inout("currentUser", SignInResult(event.result).user); 
			$.dispatchEvent(new ChangeViewEvent(ChangeViewEvent.PUSH_VIEW, HomeView));
		}
		
		private function signIn_faultHandler(event:FaultEvent):void
		{
			viewState = FORM_VIEW;
			
			trace("error signing in!");
		}
	}
}