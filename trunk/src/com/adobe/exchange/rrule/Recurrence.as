package com.adobe.exchange.rrule
{
	public class Recurrence
	{
		public static const NO_END_DATE:String  = "noEndDate";
		public static const END_AFTER:String    = "endAfter";
		public static const END_BY:String       = "endBy";
		
		public var rangeType:String;
		public var endAfter:uint;
		public var endBy:Date;
	}
}