package com.adobe.exchange.rrule
{
	public class Monthly
		extends Recurrence
	{
		public static const ABSOLUTE_TYPE:String = "absolute";
		public static const RELATIVE_TYPE:String = "relative";

		public static const FIRST:String  = "first";
		public static const SECOND:String = "second";
		public static const THIRD:String  = "third";
		public static const FOURTH:String = "fourth";
		public static const LAST:String   = "last";

		public static const DAY:String         = "day";
		public static const WEEKDAY:String     = "weekday";
		public static const WEEKEND_DAY:String = "weekendDay";
		public static const SUNDAY:String      = "sunday";
		public static const MONDAY:String      = "monday";
		public static const TUESDAY:String     = "tuesday";
		public static const WEDNESDAY:String   = "wednesday";
		public static const THURSDAY:String    = "thursday";
		public static const FRIDAY:String      = "friday";
		public static const SATURDAY:String    = "saturday";

		public var monthlyType:String;
		public var absoluteDay:uint;
		public var every:uint;
		public var relativePosition:String;
		public var day:String;
	}
}