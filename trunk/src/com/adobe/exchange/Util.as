package com.adobe.exchange
{
	import mx.utils.StringUtil;

	public class Util
	{
		/**
		 * Parses a string like this into a Person object:
		 * "Christian Cantrell" <ccantrel@adobe.com>
		 */
		public static function parsePersonString(personStr:String):Person
		{
			var name:String = new String()
			var email:String = new String();
			var inName:Boolean = false;
			var inEmail:Boolean = false;

			for (var i:uint = 0; i < personStr.length; ++i)
			{
				var token:String = personStr.charAt(i);
				if (token == "\"")
				{
					inName = !inName;
					continue;	
				}			
				if (token == "<")
				{
					inEmail = true; continue;
				}
				if (token == ">")
				{
					break;
				}

				if (inName) name += token;
				if (inEmail) email += token;
			}

			var person:Person = new Person();
			person.firstName = name.substring(0, name.indexOf(" "));
			person.lastName = name.substring(name.indexOf(" ")+1, name.length);
			person.emailAddress = email;
			return person;
		}

		public static function parsePersonStrings(personStr:String):Array
		{
			var peopleStrings:Array = personStr.split(",");
			var people:Array = new Array();
			for each (var pStr:String in peopleStrings)
			{
				people.push(parsePersonString(StringUtil.trim(pStr)));
			}
			return people;
		}

		public static function nullCheck(x:XMLList):String
		{
			var s:String = String(x);
			if (StringUtil.trim(s).length == 0)
			{
				return null;
			}
			return s;
		}
	}
}