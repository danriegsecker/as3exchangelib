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