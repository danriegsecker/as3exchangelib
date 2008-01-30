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
	[Event(name="exchangeErrorEvent",       type="com.adobe.exchange.events.ExchangeErrorEvent")]
	[Event(name="exchangeAppointmentListEvent", type="com.adobe.exchange.events.ExchangeAppointmentListEvent")]

	import com.adobe.exchange.events.*;
	import com.adobe.utils.DateUtil;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;

	public class Calendar
		extends ExchangeStore
	{
		public function Calendar()
		{
			super();
		}

		public function getAppointments(startDate:Date, endDate:Date, username:String = null):void
		{
			var url:String = (this.requestConfig.protocol) +
							 "://" +
							 this.requestConfig.server +
							 "/exchange/" +
							 ((username != null) ? username : this.requestConfig.username) +
							 "/Calendar";

			var req:URLRequest = this.getURLRequest(url, getSelectAppointmentXML(url, startDate, endDate));
			req.method = "SEARCH";
			var stream:URLStream = this.getURLStream();
			stream.addEventListener(Event.COMPLETE,
				function(e:Event):void
				{
					var appts:Array = new Array();
					var stream:URLStream = e.target as URLStream;
					var responseStr:String = stream.readUTFBytes(stream.bytesAvailable);
					stream.close();
					var responseXML:XML = new XML(responseStr);
					var nsd:Array = responseXML.namespaceDeclarations();
					for each (var responseNode:XML in responseXML..dav_ns::response)
					{
						var appt:Appointment = new Appointment();

						appt.url = Util.nullCheck(responseNode.dav_ns::href);

						appt.uid = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::uid);

						appt.subject = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.email_ns::subject);

						var startDateStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::dtstart);
						appt.startDate = (startDateStr != null) ? DateUtil.parseW3CDTF(startDateStr) : null;

						var endDateStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::dtend);
						appt.endDate = (endDateStr != null) ? DateUtil.parseW3CDTF(endDateStr) : null;

						var createdStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::created);
						appt.created = (createdStr != null) ? DateUtil.parseW3CDTF(createdStr) : null;

						var lastModifiedStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::lastmodified);
						appt.lastModified = (lastModifiedStr != null) ? DateUtil.parseW3CDTF(lastModifiedStr) : null;

						appt.organizer = Util.parsePersonString(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::organizer);

						var rAttendeeStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.mail_header_ns::to);
						appt.requiredAttendees = (rAttendeeStr != null) ? Util.parsePersonStrings(rAttendeeStr) : null;

						var oAttendeeStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.mail_header_ns::cc);
						appt.optionalAttendees = (oAttendeeStr != null) ? Util.parsePersonStrings(oAttendeeStr) : null;

						appt.location = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::location);

						appt.allDay = (responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::alldayevent == "1") ? true : false;

						var reminderOffsetStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::reminderoffset);
						appt.reminderOffset = (reminderOffsetStr != null) ? uint(reminderOffsetStr) : 0;

						appt.recurring = (responseNode.dav_ns::propstat.dav_ns::prop.mapi_ns::is_recurring == "1") ? true : false;

						appt.textDescription = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.email_ns::textdescription);

						appt.htmlDescription = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.email_ns::htmldescription);
						
						var rruleStr:String = Util.nullCheck(responseNode.dav_ns::propstat.dav_ns::prop.cal_ns::rrule.xml_ns::v);
						appt.repeatRule = (rruleStr != null) ? rruleStr : null;

						appts.push(appt);
					}
					var eale:ExchangeAppointmentListEvent = new ExchangeAppointmentListEvent();
					eale.startDate = startDate;
					eale.appointments = appts;
					dispatchEvent(eale);
				});
			stream.load(req);
		}
		
		private function getSelectAppointmentXML(url:String, startDate:Date, endDate:Date):XML
		{
			return  <d:searchrequest xmlns:d="DAV:">
						<d:sql>
							SELECT
							    "DAV:contentclass",
								"urn:schemas:calendar:uid",
								"urn:schemas:calendar:dtstart",
								"urn:schemas:calendar:dtend", 
								"urn:schemas:httpmail:subject",
								"urn:schemas:calendar:organizer",
								"urn:schemas:calendar:location",
								"urn:schemas:calendar:lastmodified",
								"urn:schemas:calendar:created",
								"urn:schemas:calendar:alldayevent",
								"urn:schemas:calendar:reminderoffset",
								"urn:schemas:calendar:rrule",
								"urn:schemas:httpmail:textdescription",
								"urn:schemas:httpmail:htmldescription",
								"urn:schemas:mailheader:to",
								"urn:schemas:mailheader:cc",
								"http://schemas.microsoft.com/mapi/is_recurring"
							FROM
								"{url}"
							WHERE 
								"http://schemas.microsoft.com/exchange/outlookmessageclass" = 'IPM.Appointment'
								AND "urn:schemas:calendar:dtstart" &gt; '{this.dateFormatter.format(startDate)}' 
								AND "urn:schemas:calendar:dtend" &lt; '{this.dateFormatter.format(endDate)}' 
						</d:sql>
					</d:searchrequest>;		
		}
		
	}
}