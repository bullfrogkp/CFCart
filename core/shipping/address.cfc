<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cffunction name="isValidAddress" access="public" returntype="boolean">
		<cfargument name="address" type="struct" required="true">
		<!--- 
		<cfset var LOCAL = {} />
	
		<cfset LOCAL.xmlData = _createAddressValidationXml(address = ARGUMENTS.address)>										
										
		<cfset LOCAL.response = _submitXml(xmlData = LOCAL.xmlData, submitUrl = APPLICATION.ups.av_url)>		
		<cfset LOCAL.addressIsValid = _parseResponse(response = LOCAL.response.Filecontent) />
		
		<cfreturn LOCAL.addressIsValid />
		 --->
		 <cfreturn true />
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_submitXml" displayname="Submit XML" description="Submits XML documents to UPS to get the response data" access="private" output="false" returntype="any">
		<cfargument name="submitUrl" type="string" required="true">
		<cfargument name="xmlData" type="string" required="true">
				
		<cfhttp url="#ARGUMENTS.submitUrl#" method="post" result="LOCAL.response">
			<cfhttpparam type="xml" value="#ARGUMENTS.xmlData#">
		</cfhttp>
		
		<cfreturn LOCAL.response>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_parseResponse" access="private" returntype="boolean">
		<cfargument name="response" type="any" required="true">
	
		<cfset var LOCAL = {} />		
		<cfset LOCAL.response = XmlParse(ARGUMENTS.response)>
		<cfset LOCAL.addressIsValid = LOCAL.response["AddressValidationResponse"]["Response"]["ResponseStatusCode"].XmlText />
	<cfdump var="#LOCAL.response#" abort>		
		<cfif LOCAL.addressIsValid EQ 0>
			<cfset LOCAL.retValue= false />
		<cfelse>
			<cfset LOCAL.retValue= true />
		</cfif>
		
		<cfreturn LOCAL.retValue>
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_createAddressValidationXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="address" type="struct" required="true">
		
		<cfset var LOCAL = {} />
		<cfxml variable="LOCAL.xmlShippingRequest" casesensitive="true">
			<cfoutput>
			<AddressValidationRequest xml:lang="en-US">
				<Request>
					<TransactionReference>
						<CustomerContext>Address Varification</CustomerContext>
						<XpciVersion>1.0</XpciVersion>
					</TransactionReference>
					<RequestAction>AV</RequestAction>
				</Request>
				<Address>
					<City>#ARGUMENTS.address.city#</City>
					<StateProvinceCode>#ARGUMENTS.address.provinceCode#</StateProvinceCode>
					<CountryCode>#ARGUMENTS.address.countryCode#</CountryCode>
					<PostalCode>#ARGUMENTS.address.postalCode#</PostalCode>
				</Address>
			</AddressValidationRequest>
			</cfoutput>
		</cfxml>

		<cfsavecontent variable="LOCAL.xmlShippingData">
			<?xml version="1.0"?>
			<AccessRequest xml:lang="en-US">
				<cfoutput>
					<AccessLicenseNumber>#xmlFormat(APPLICATION.ups.accesskey)#</AccessLicenseNumber>
					<UserId>#xmlFormat(APPLICATION.ups.upsuserid)#</UserId>
					<Password>#xmlFormat(APPLICATION.ups.upspassword)#</Password>
				</cfoutput>
			</AccessRequest>
			<cfoutput>#LOCAL.xmlShippingRequest#</cfoutput>
		</cfsavecontent>	
	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>