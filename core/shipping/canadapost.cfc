<cfcomponent output="false" accessors="true">
	<cfproperty name="shippingMethodId" type="numeric"> 
	<cfproperty name="productId" type="numeric"> 
    <cfproperty name="address" type="struct"> 
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingMethodsArray" access="public" returntype="array">
		<cfargument name="toAddress" type="struct" required="true">
		<cfargument name="productId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		<cfargument name="shippingCarrierId" type="numeric" required="true">
		<cfargument name="productShippingCarrierRelaId" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.productShippingCarrierRela = EntityLoadByPK("product_shipping_carrier_rela",ARGUMENTS.productShippingCarrierRelaId) />
		<cfif LOCAL.productShippingCarrierRela.getUseDefaultPrice() EQ true>
			<cfset LOCAL.shippingMethods = [] />
			<cfset LOCAL.shippingMethod = EntityLoad("shipping_method",{shippingCarrier = LOCAL.productShippingCarrierRela.getShippingCarrier(), isDefault = true},true) />
			<cfset LOCAL.currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
			
			<cfset LOCAL.shippingMethodStruct = {} />
			<cfset LOCAL.shippingMethodStruct.shippingMethodId = LOCAL.shippingMethod.getShippingMethodId() />
			<cfset LOCAL.shippingMethodStruct.name = LOCAL.shippingMethod.getDisplayName() />
			<cfset LOCAL.shippingMethodStruct.price = NumberFormat(LOCAL.productShippingCarrierRela.getPrice() * LOCAL.currency.getMultiplier(),"0.00") />
			<cfset LOCAL.shippingMethodStruct.description = LOCAL.shippingMethod.getDescription() />
			
			<cfset ArrayAppend(LOCAL.shippingMethods, LOCAL.shippingMethodStruct) />
		<cfelse>
			<cfset var LOCAL = {} />
			<cfset LOCAL.siteInfo = EntityLoad("site_info",{},true) /> 
			<cfset LOCAL.product = EntityLoadByPK("product",getProductId()) /> 
					
			<cfsavecontent variable="LOCAL.xmlRequest">
				<cfoutput>
				<?xml version="1.0" encoding="utf-8"?>
				<mailing-scenario xmlns="http://www.canadapost.ca/ws/ship/rate-v3">
					<quote-type>counter</quote-type>
					<parcel-characteristics>
						<weight>#LOCAL.product.getWeight()#</weight>
					</parcel-characteristics>
					<origin-postal-code>#UCase(Replace(LOCAL.siteInfo.getPostalCode()," ","","all"))#</origin-postal-code>
					<destination>
						<cfif getAddress().countryCode EQ "CA">
							<domestic>
								<postal-code>#UCase(Replace(getAddress().postalCode," ","","all"))#</postal-code>
							</domestic>
						<cfelseif getAddress().countryCode EQ "US">
							<united-states>
								<zip-code>#Replace(getAddress().postalCode," ","","all")#</zip-code>
							</united-states>
						<cfelse>
							<international>
								<country-code>#getAddress().countryCode#</country-code>
							</international>
						</cfif>
					</destination>
				</mailing-scenario>
				</cfoutput>
			</cfsavecontent>

			<cfhttp
			url="#APPLICATION.canadapost.rate_url#"
			method="post"
			result="LOCAL.httpResponse"
			username="#APPLICATION.canadapost.username#" password="#APPLICATION.canadapost.password#">
				<cfhttpparam
				type="header"
				name="Accept"
				value="application/vnd.cpc.ship.rate-v3+xml"
				/>
				<cfhttpparam
				type="xml"
				value="#trim(LOCAL.xmlRequest)#"
				/>
				<cfhttpparam type="header" name="Content-type" value="application/vnd.cpc.ship.rate-v3+xml">
				<cfhttpparam type="header" name="Accept-language" value="en-CA">
			</cfhttp>

			<cfset LOCAL.shippingMethodsArray = _parseResponse(LOCAL.httpResponse) />
		</cfif>
		
		<cfreturn LOCAL.shippingMethodsArray />
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_parseResponse" access="private" returntype="array">
		<cfargument name="response" type="any" required="true">
	
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.response = XMLParse(ARGUMENTS.response.fileContent) />
		<cfset LOCAL.shippingMethodsArray = LOCAL.response["price-quotes"]["price-quote"]["price-details"].due.XmlText />
	
		<cfreturn LOCAL.retStruct>
	</cffunction>
	<!------------------------------------------------------------------------------->	
</cfcomponent>