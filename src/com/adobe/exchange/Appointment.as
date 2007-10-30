package com.adobe.exchange
{
	public class Appointment
	{
		private var _uid:String;
		private var _url:String;
		private var _subject:String;
		private var _startDate:Date;
		private var _endDate:Date;
		private var _created:Date;
		private var _requiredAttendees:Array;
		private var _optionalAttendees:Array;
		private var _lastModified:Date;
		private var _organizer:Person;
		private var _location:String;
		private var _allDay:Boolean;
		private var _reminderOffset:uint;
		private var _recurring:Boolean;
		private var _repeatRule:String;
		private var _textDescription:String;
		private var _htmlDescription:String;

		public function toString():String
		{
			return "uid: ["+this.uid+"], " +
				   "url: ["+this.url+"], " +
				   "subject: ["+this.subject+"], " +
				   "startDate: ["+this.startDate+"], " +
				   "endDate: ["+this.endDate+"], " +
				   "created: ["+this.created+"], " +
				   "lastModified: ["+this.lastModified+"], " +
				   "organizer: ["+this.organizer+"], " +
				   "requiredAttendees: ["+this.requiredAttendees+"], " +
				   "optionalAttendees: ["+this.optionalAttendees+"], " +
				   "location: ["+this.location+"], " +
				   "allDay: ["+this.allDay+"], " +
				   "reminderOffset: ["+this.reminderOffset+"], " +
				   "recurring: ["+this.recurring+"], " +
				   "repeatRule: ["+this.repeatRule+"], " +
				   "textDescription: ["+this.textDescription+"], " +
				   "htmlDescription: ["+this.htmlDescription+"]";
		}

		public function set uid(uid:String):void
		{
			this._uid = uid;
		}

		public function get uid():String
		{
			return this._uid;
		}

		public function set url(url:String):void
		{
			this._url = url;
		}

		public function get url():String
		{
			return this._url;
		}

		public function set subject(subject:String):void
		{
			this._subject = subject;
		}

		public function get subject():String
		{
			return this._subject;
		}

		public function set startDate(startDate:Date):void
		{
			this._startDate = startDate;
		}

		public function get startDate():Date
		{
			return this._startDate;
		}

		public function set endDate(endDate:Date):void
		{
			this._endDate = endDate;
		}

		public function get endDate():Date
		{
			return this._endDate;
		}

		public function set created(created:Date):void
		{
			this._created = created;
		}

		public function get created():Date
		{
			return this._created;
		}

		public function set requiredAttendees(requiredAttendees:Array):void
		{
			this._requiredAttendees = requiredAttendees;
		}

		public function get requiredAttendees():Array
		{
			return this._requiredAttendees;
		}

		public function set optionalAttendees(optionalAttendees:Array):void
		{
			this._optionalAttendees = optionalAttendees;
		}

		public function get optionalAttendees():Array
		{
			return this._optionalAttendees;
		}

		public function set lastModified(lastModified:Date):void
		{
			this._lastModified = lastModified;
		}

		public function get lastModified():Date
		{
			return this._lastModified;
		}

		public function set organizer(organizer:Person):void
		{
			this._organizer = organizer;
		}

		public function get organizer():Person
		{
			return this._organizer;
		}

		public function set location(location:String):void
		{
			this._location = location;
		}

		public function get location():String
		{
			return this._location;
		}

		public function set textDescription(textDescription:String):void
		{
			this._textDescription = textDescription;
		}

		public function get textDescription():String
		{
			return this._textDescription;
		}

		public function set htmlDescription(htmlDescription:String):void
		{
			this._htmlDescription = htmlDescription;
		}

		public function get htmlDescription():String
		{
			return this._htmlDescription;
		}

		public function set allDay(allDay:Boolean):void
		{
			this._allDay = allDay;
		}

		public function get allDay():Boolean
		{
			return this._allDay;
		}

		public function set reminderOffset(reminderOffset:uint):void
		{
			this._reminderOffset = reminderOffset;
		}

		public function get reminderOffset():uint
		{
			return this._reminderOffset;
		}

		public function set recurring(recurring:Boolean):void
		{
			this._recurring = recurring;
		}

		public function get recurring():Boolean
		{
			return this._recurring;
		}

		public function set repeatRule(repeatRule:String):void
		{
			this._repeatRule = repeatRule;
		}

		public function get repeatRule():String
		{
			return this._repeatRule;
		}
	}
}