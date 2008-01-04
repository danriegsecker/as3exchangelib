/*
    Adobe Systems Incorporated(r) Source Code License Agreement
    Copyright(c) 2005 Adobe Systems Incorporated. All rights reserved.
    
    Please read this Source Code License Agreement carefully before using
    the source code.
    
    Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive, 
    no-charge, royalty-free, irrevocable copyright license, to reproduce,
    prepare derivative works of, publicly display, publicly perform, and
    distribute this source code and such derivative works in source or 
    object code form without any attribution requirements.  
    
    The name "Adobe Systems Incorporated" must not be used to endorse or promote products
    derived from the source code without prior written permission.
    
    You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
    against any loss, damage, claims or lawsuits, including attorney's 
    fees that arise or result from your use or distribution of the source 
    code.
    
    THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT 
    ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
    BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  ALSO, THERE IS NO WARRANTY OF 
    NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT.  IN NO EVENT SHALL ADOBE 
    OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
    EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
    OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
    WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
    OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
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
			dateFormatter.formatString = "YYYY/MM/DD JJ:NN:SS";
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
			req.authenticate = true;
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
		}

		private function onIOError(e:IOErrorEvent):void
		{
			this.dispatchEvent(e);
		}
	}
}