package com.detager.mobile.models.presentation
{
	import com.detager.mobile.events.GlobalDispatcher;
	import com.detager.mobile.events.SwitchViewEvent;
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
		public var user:User;
		
		[Bindable]
		public var rememberMe:Boolean = false;
		
		[Bindable]
		public var formEnabled:Boolean = true;
		
		private var userService:IUserService;
		
		public function SignInPM()
		{
			userService = ServiceLocator.instance.userService;
			user = new User();
			user.username = "pwalczyszyn";
			user.password = "password";
		}
		
		public function btnSignIn_clickHandler():void
		{
			ServiceHelper.call(userService.signIn(user.username, user.password), signIn_resultHandler, signIn_faultHandler);
		}

		private function signIn_resultHandler(event:ResultEvent):void
		{
			GlobalDispatcher.dispatchEvent(new SwitchViewEvent(SwitchViewEvent.SWITCH_VIEW, HomeView));
		}
		
		private function signIn_faultHandler(event:FaultEvent):void
		{
			trace("error signing in!");
		}
	}
}