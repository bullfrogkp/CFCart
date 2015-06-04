<cfcomponent output="false" accessors="true">
	<cfproperty name="shippingMethodId" type="numeric"> 
	<cfproperty name="productId" type="numeric"> 
    <cfproperty name="address" type="struct"> 
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingFee" access="public" returntype="numeric">
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",getShippingMethodId()) />
		<cfset LOCAL.siteInfo = EntityLoad("site_info",{},true) /> 
		<cfset LOCAL.product = EntityLoadByPK("product",getProductId()) /> 
				
		<cfsavecontent variable="xmlRequest">
			<?xml version="1.0" encoding="utf-8"?>
			<mailing-scenario xmlns="http://www.canadapost.ca/ws/ship/rate-v3">
				<quote-type>counter</quote-type>
				<parcel-characteristics>
					<weight>#LOCAL.product.getWeight()#</weight>
				</parcel-characteristics>
				<origin-postal-code>#LOCAL.siteInfo.getPostalCode()#</origin-postal-code>
				<destination>
					<cfif getAddress().countryCode EQ "CA">
						<domestic>
							<postal-code>#getAddress().postalCode#</postal-code>
						</domestic>
					<cfelseif getAddress().countryCode EQ "US">
						<united-states>
							<zip-code>#getAddress().postalCode#</zip-code>
						</united-states>
					<cfelse>
						<international>
							<country-code>#getAddress().countryCode#</country-code>
						</international>
					</cfif>
			</mailing-scenario>
		</cfsavecontent>

		<cfhttp
		url="#APPLICATION.canadapost.rate_url#"
		method="post"
		result="httpResponse"
		username="#APPLICATION.canadapost.username#" password="#APPLICATION.canadapost.password#">
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
</cfcomponent>