package com.detager.mobile.models.presentation
{
	import com.detager.mobile.events.ChangeViewEvent;
	import com.detager.mobile.events.GlobalDispatcher;
	import com.detager.mobile.services.IUserService;
	import com.detager.mobile.services.ServiceHelper;
	import com.detager.mobile.services.ServiceLocator;
	import com.detager.mobile.views.HomeView;
	import com.detager.models.domain.User;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

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
		
		private var userService:IUserService;
		
		public function SignInPM()
		{
			init();
		}
		
		private function init():void
		{
			userService = ServiceLocator.instance.userService;
			
			username = "pwalczyszyn";
			password = "password";
		}
		
		public function btnSignIn_clickHandler():void
		{
			ServiceHelper.call(userService.signIn(username, password), signIn_resultHandler, signIn_faultHandler);
		}

		private function signIn_resultHandler(event:ResultEvent):void
		{
			GlobalDispatcher.dispatchEvent(new ChangeViewEvent(ChangeViewEvent.CHANGE_VIEW, HomeView));
		}
		
		private function signIn_faultHandler(event:FaultEvent):void
		{
			trace("error signing in!");
		}
	}
}