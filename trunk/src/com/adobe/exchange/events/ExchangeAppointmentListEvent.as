package com.adobe.exchange.events
{
	import flash.events.Event;
	
	public class ExchangeAppointmentListEvent
		extends Event
	{

		public static const EXCHANGE_APPOINTMENT_LIST_EVENT:String = "exchangeAppointmentListEvent";

		public var appointments:Array;

		public function ExchangeAppointmentListEvent()
		{
			super(ExchangeAppointmentListEvent.EXCHANGE_APPOINTMENT_LIST_EVENT);
		}
	}
}