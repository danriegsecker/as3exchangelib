package com.adobe.exchange
{
	public class Person
	{
		private var _firstName:String;
		private var _lastName:String;
		private var _emailAddress:String;

		public function toString():String
		{
			return "firstName: ["+this.firstName+"], " +
				   "lastName: ["+this.lastName+"], " +
				   "emailAddress: ["+this.emailAddress+"]";
		}

		public function set firstName(firstName:String):void
		{
			this._firstName = firstName;
		}

		public function get firstName():String
		{
			return this._firstName;
		}

		public function set lastName(lastName:String):void
		{
			this._lastName = lastName;
		}

		public function get lastName():String
		{
			return this._lastName;
		}

		public function set emailAddress(emailAddress:String):void
		{
			this._emailAddress = emailAddress;
		}

		public function get emailAddress():String
		{
			return this._emailAddress;
		}
	}
}