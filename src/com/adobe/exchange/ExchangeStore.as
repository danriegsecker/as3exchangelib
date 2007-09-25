package com.adobe.exchange
{
	[Event(name="ioError", type="flash.events.IOErrorEvent")]

	import mx.formatters.DateFormatter;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLRequestHeader;
	import flash.events.EventDispatcher;

	public class ExchangeStore
		extends EventDispatcher
	{
		private var _requestConfig:RequestConfig;
		protected var dateFormatter:DateFormatter;

		protected var dav_ns:Namespace         = new Namespace("DAV:");
		protected var xml_ns:Namespace         = new Namespace("xml:");
		protected var cal_ns:Namespace         = new Namespace("urn:schemas:calendar:");
		protected var email_ns:Namespace       = new Namespace("urn:schemas:httpmail:");
		protected var mail_header_ns:Namespace = new Namespace("urn:schemas:mailheader:");
		protected var mapi_ns:Namespace        = new Namespace("http://schemas.microsoft.com/mapi/");

		public function ExchangeStore()
		{
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYY/MM/DD";
		}
		
		public function set requestConfig(requestConfig:RequestConfig):void
		{
			this._requestConfig = requestConfig;
		}

		public function get requestConfig():RequestConfig
		{
			return this._requestConfig;
		}
		
		protected function getURLRequest(url:String, body:XML):URLRequest
		{
			var req:URLRequest = new URLRequest(url);
			req.manageCookies = true;
			req.shouldAuthenticate = true;
			req.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml"));
			req.data = body;
			return req;
		}
		
		protected function getURLStream():URLStream
		{
			var stream:URLStream = new URLStream();
			stream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onResponseStatus);
			stream.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			return stream;
		}

		private function onResponseStatus(e:HTTPStatusEvent):void
		{
			trace("onResponseStatus");
			trace(e.status);
		}

		private function onIOError(e:IOErrorEvent):void
		{
			this.dispatchEvent(e);
		}
	}
}