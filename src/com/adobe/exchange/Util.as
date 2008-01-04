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