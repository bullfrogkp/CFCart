<cfcomponent output="false" accessors="true">
	<cfproperty name="shippingMethodId" type="numeric"> 
	<cfproperty name="productId" type="numeric"> 
    <cfproperty name="address" type="struct"> 
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingFee" access="public" returntype="numeric">
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",getShippingMethodId()) />
		<cfset LOCAL.siteInfo = EntityLoad("site_info",{},true) /> 
		
		<cfset LOCAL.xmlData = _createShippingRateXml(	fromAddress = LOCAL.siteInfo.getAddress()
													,	toAddress = getAddress()
													,	serviceCode = LOCAL.shippingMethod.getServiceCode())>										
										
		<cfset LOCAL.shippingRateResponse = _submitXml(xmlData = LOCAL.xmlData, submitUrl = APPLICATION.ups.rate_url)>
		<cfset LOCAL.rate = _parseResponse(LOCAL.shippingRateResponse).rate />
		
		<cfreturn LOCAL.rate />
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_submitXml" displayname="Submit XML" description="Submits XML documents to UPS to get the response data" access="private" output="false" returntype="any">
		<cfargument name="submitUrl" type="string" required="true">
		<cfargument name="xmlData" type="string" required="true">
				
		<cfhttp url="#ARGUMENTS.submitUrl#" method="post" result="LOCAL.shippingData">
			<cfhttpparam type="xml" value="#ARGUMENTS.xmlData#">
		</cfhttp>
		
		<cfset LOCAL.xmlDataParsed = xmlparse(LOCAL.shippingData.filecontent)>
		
		<cfreturn LOCAL.xmlDataParsed>
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>