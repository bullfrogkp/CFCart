<cfcomponent extends="shipping" output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingFee" access="public" returntype="numeric">
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",getShippingMethodId()) />
		<cfset LOCAL.siteInfo = EntityLoad("site_info",{},true) /> 
		
		
		
		<cfsavecontent variable="xmlRequest">
<?xml version="1.0" encoding="utf-8"?>
<mailing-scenario xmlns="http://www.canadapost.ca/ws/ship/rate-v3">
<quote-type>counter</quote-type>
<parcel-characteristics>
<weight>1</weight>
</parcel-characteristics>
<origin-postal-code>K2B8J6</origin-postal-code>
<destination>
<domestic>
<postal-code>J0E1X0</postal-code>
</domestic>
</destination>
</mailing-scenario>

</cfsavecontent>

<!--- Step3: Post request to Canada Post API --->
<cfhttp
url="https://soa-gw.canadapost.ca/rs/ship/price"
method="post"
result="httpResponse"
username="03ac5bc25c8f08e5" password="e87558a6b864af93152ab1">

<cfhttpparam
type="header"
name="Accept"
value="application/vnd.cpc.ship.rate-v3+xml"
/>
<cfhttpparam
type="xml"
value="#trim(xmlRequest)#"
/>
<cfhttpparam type="header" name="Content-type" value="application/vnd.cpc.ship.rate-v3+xml">
<cfhttpparam type="header" name="Accept-language" value="en-CA">
</cfhttp>

<cfdump var="#httpResponse#" abort>
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_parseResponse" access="private" returntype="struct">
		<cfargument name="response" type="any" required="true">
	
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfdump var="#response#" abort>
		<cfset LOCAL.retStruct.rate = ARGUMENTS.response["RatingServiceSelectionResponse"]["RatedShipment"]["TotalCharges"]["MonetaryValue"].xmlText />
		
		<cfreturn LOCAL.retStruct>
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	<cffunction name="_createShippingRateXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="string">
		<cfargument name="fromAddress" type="struct" required="true">
		<cfargument name="toAddress" type="struct" required="true">
		<cfargument name="serviceCode" type="string" required="true">
		
		<cfset var LOCAL = {} />
		
		<cfsavecontent variable="LOCAL.xmlShippingData">
			<get-rates-request>
<mailing-scenario>
<customer-number>1111111</customer-number>
<contract-id>12345678</contract-id>
<parcel-characteristics>
<weight>1</weight>
</parcel-characteristics>
<services>
<service-code>DOM.XP</service-code>
</services>
<origin-postal-code>V6B4A2</origin-postal-code>
<destination>
<domestic>
<postal-code>J0E1X0</postal-code>
</domestic>
</destination>
</mailing-scenario>
</get-rates-request>
		</cfsavecontent>	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_submitXml" displayname="Submit XML" description="Submits XML documents to UPS to get the response data" access="private" output="false" returntype="any">
		<cfargument name="submitUrl" type="string" required="true">
		<cfargument name="xmlData" type="string" required="true">
				
		<cfhttp
			url="https://ct.soa-gw.canadapost.ca/rs/soap/rating/v3*"
			method="post"
			result="httpResponse"
			 username="c99f11dd351dff97" password="07f7734b06eff2abd252ab">
			<cfhttpparam
			type="header"
			name="accept-encoding"
			value="no-compression"
			/>
			<cfhttpparam
			type="xml"
			value="#trim(xmlData)#"
			/>
			<cfhttpparam type="header" name="Content-type" value="application/vnd.cpc.ship.rate+xml">
			</cfhttp>
<cfdump var="#httpResponse#" abort>		
		<cfset LOCAL.xmlDataParsed = xmlparse(LOCAL.shippingData.filecontent)>
		
		<cfreturn LOCAL.xmlDataParsed>
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>