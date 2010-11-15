package com.detager.mobile.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;

	public class ServiceHelper
	{
		public static function call(token:AsyncToken, result:Function, fault:Function):void
		{
			token.addResponder(new Responder(result, fault));
		}
	}
}