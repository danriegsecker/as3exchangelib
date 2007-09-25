package com.adobe.exchange.rrule
{
	public class Daily
		extends Recurrence
	{
		public static const INTERVAL_TYPE:String      = "interval";
		public static const EVERY_WEEKDAY_TYPE:String = "everyWeekday";
		
		public var dailyType:String;
		public var intervalValue:uint;
	}
}