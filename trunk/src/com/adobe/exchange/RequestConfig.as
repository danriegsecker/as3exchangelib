package com.adobe.exchange
{
	import flash.net.URLRequest;
	
	public class RequestConfig
	{
		private var _username:String;
		private var _server:String;
		private var _secure:Boolean;
		private var _protocol:String = "http";
		
		public function set username(username:String):void
		{
			this._username = username;
		}

		public function get username():String
		{
			return this._username;
		}

		public function set server(server:String):void
		{
			this._server = server;
		}

		public function get server():String
		{
			return this._server;
		}

		public function set secure(secure:Boolean):void
		{
			this._secure = secure;
			this._protocol = (secure) ? "https" : "http";
		}

		public function get secure():Boolean
		{
			return this._secure;
		}		

		public function get protocol():String
		{
			return this._protocol;
		}		
	}
}