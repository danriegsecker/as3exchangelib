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
	[Event(name="exchangeErrorEvent",           type="com.adobe.exchange.events.ExchangeErrorEvent")]
	[Event(name="exchangeContactListEvent",     type="com.adobe.exchange.events.ExchangeContactListEvent")]

	import com.adobe.exchange.events.*;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;

	public class AddressBook
		extends ExchangeStore
	{
		public function AddressBook()
		{
			super();
		}

		public function getContacts(folder:String = null):void
		{
			var url:String = (this.requestConfig.protocol) +
							 "://" +
							 this.requestConfig.server +
							 "/exchange/" +
							 this.requestConfig.username +
							 "/Contacts";
							 
			if (folder != null)
			{
				url += ("/" + folder);
			}

			var req:URLRequest = this.getURLRequest(url, getSelectAllContactsXML(url));
			req.method = "SEARCH";
			var stream:URLStream = this.getURLStream();
			stream.addEventListener(Event.COMPLETE,
				function(e:Event):void
				{
					if (lastResponseCode != 207) return;
					var contacts:Array = new Array();
					var stream:URLStream = e.target as URLStream;
					var responseStr:String = stream.readUTFBytes(stream.bytesAvailable);
					stream.close();
					var responseXML:XML = new XML(responseStr);
					var nsd:Array = responseXML.namespaceDeclarations();
					for each (var responseNode:XML in responseXML.dav_ns::response)
					{
						var status:String = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::status);
						if (status == null || status.indexOf("200") == -1) continue;
						var abEntry:AddressBookEntry = new AddressBookEntry();
						var href:String = Util.nullCheck(responseNode.dav_ns::href);
						abEntry.href = href;
						if (href.lastIndexOf("/") == (href.length - 1))
						{
							abEntry.isFolder = true;
							var pathArray:Array = href.split("/");
							abEntry.folderName = pathArray[pathArray.length-2];
							contacts.push(abEntry);
							continue;
						}
						abEntry.isFolder = false;
						var person:Person = new Person();
						person.fullName = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::prop.contacts_ns::cn);
						person.organization = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::prop.contacts_ns::o);
						person.title = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::prop.contacts_ns::title);
						person.emailAddress = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::prop.contacts_ns::email1);
						person.telephoneNumber = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::prop.contacts_ns::telephoneNumber);
						person.homeAddress = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::prop.contacts_ns::homepostaladdress);
						person.workAddress = Util.nullCheck(responseNode.dav_ns::propstat[0].dav_ns::prop.contacts_ns::workaddress);
						abEntry.contact = person;
						contacts.push(abEntry);
					}
					var ecle:ExchangeContactListEvent = new ExchangeContactListEvent();
					ecle.entries = contacts;
					dispatchEvent(ecle);
				});
			stream.load(req);
		}

		private function getSelectAllContactsXML(url:String):XML
		{
			return  <d:searchrequest xmlns:d="DAV:">
						<d:sql>
							SELECT
								"a:href",
								"urn:schemas:contacts:o",
								"urn:schemas:contacts:cn",
								"urn:schemas:contacts:title",
								"urn:schemas:contacts:email1",
								"urn:schemas:contacts:telephoneNumber",
								"urn:schemas:contacts:homepostaladdress",
								"urn:schemas:contacts:workaddress"
							FROM
								"{url}"
							ORDER BY
								"urn:schemas:contacts:cn"
						</d:sql>
					</d:searchrequest>;		
		}
	}
}