package com.adobe.exchange.events
{
	import flash.events.Event;
	
	public class ExchangeErrorEvent
		extends Event
	{

		public static const EXCHANGE_ERROR_EVENT:String = "exchangeErrorEvent";

		public var responseCode:int;
		public var message:String;

		public function ExchangeErrorEvent()
		{
			super(ExchangeErrorEvent.EXCHANGE_ERROR_EVENT);
		}
	}
}