package com.detager.mobile.services
{
	import mx.rpc.AsyncToken;

	public interface IUserService
	{
		function signIn(username:String,password:String):AsyncToken;
		
		function signOut():AsyncToken;
	}
}