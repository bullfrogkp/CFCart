<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cffunction name="isValidAddress" access="public" returntype="boolean">
		<cfargument name="address" type="struct" required="true">
		
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
			<cfset LOCAL.siteInfo = EntityLoad("site_info",{},true) /> 
			
			<cfset LOCAL.xmlData = _createShippingRateXml(	fromAddress = LOCAL.siteInfo.getAddress()
														,	toAddress = ARGUMENTS.toAddress
														,	productId = ARGUMENTS.productId)>										
											
			<cfset LOCAL.shippingRateResponse = _submitXml(xmlData = LOCAL.xmlData, submitUrl = APPLICATION.ups.rate_url)>		
			<cfset LOCAL.shippingMethods = _parseResponse(response = LOCAL.shippingRateResponse, currencyId = ARGUMENTS.currencyId) />
		</cfif>
		
		<cfreturn LOCAL.shippingMethods />
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
	<cffunction name="_parseResponse" access="private" returntype="array">
		<cfargument name="response" type="any" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
	
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethodsArray = [] />
		
		<cfset LOCAL.currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		
		<cfloop array="#ARGUMENTS.response["RatingServiceSelectionResponse"].XmlChildren#" index="LOCAL.ratedShipment">
			<cfif LOCAL.ratedShipment.XmlName EQ "Response" AND LOCAL.ratedShipment["ResponseStatusDescription"].XmlText NEQ "Success">
				<cfthrow message="UPS rate request failed: #LOCAL.ratedShipment["ResponseStatusDescription"].XmlText#" />
			</cfif>
			
			<cfif LOCAL.ratedShipment.XmlName EQ "RatedShipment">
				<cfset LOCAL.serviceCode = LOCAL.ratedShipment["Service"]["Code"].XmlText />
				<cfset LOCAL.shippingMethod = EntityLoad("shipping_method",{shippingCarrier = EntityLoad("shipping_carrier",{name="ups"},true), serviceCode = LOCAL.serviceCode},true) />
				<cfset LOCAL.ratedShipmentStruct = {} />
				<cfset LOCAL.ratedShipmentStruct.shippingMethodId = LOCAL.shippingMethod.getShippingMethodId() />
				<cfset LOCAL.ratedShipmentStruct.name = LOCAL.shippingMethod.getDisplayName() />
				<cfset LOCAL.ratedShipmentStruct.price = NumberFormat(Val(LOCAL.ratedShipment["TotalCharges"]["MonetaryValue"].XmlText) * LOCAL.currency.getMultiplier(),"0.00") />
				<cfset LOCAL.ratedShipmentStruct.description = LOCAL.shippingMethod.getDescription() />
				
				<cfset ArrayAppend(LOCAL.shippingMethodsArray, LOCAL.ratedShipmentStruct) />
			</cfif>
		</cfloop>
		
		<cfreturn LOCAL.shippingMethodsArray>
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	<cffunction name="_createShippingRateXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="fromAddress" type="struct" required="true">
		<cfargument name="toAddress" type="struct" required="true">
		<cfargument name="productId" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		
		<cfxml variable="LOCAL.xmlShippingRequest" casesensitive="true">
			<cfoutput>
			<RatingServiceSelectionRequest>
				<Request>
					<RequestAction>Rate</RequestAction>
					<RequestOption>Shop</RequestOption>
				</Request>
				<Shipment>
					<Shipper>
						<Address>
							<AddressLine1>#ARGUMENTS.fromAddress.street#</AddressLine1>
							<City>#ARGUMENTS.fromAddress.city#</City>
							<StateProvinceCode>#ARGUMENTS.fromAddress.provinceCode#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.fromAddress.postalCode#</PostalCode>
							<CountryCode>#ARGUMENTS.fromAddress.countryCode#</CountryCode>
						</Address>
					</Shipper>
					<ShipTo>
						<Address>
							<AddressLine1>#ARGUMENTS.toAddress.street#</AddressLine1>
							<City>#ARGUMENTS.toAddress.city#</City>
							<StateProvinceCode>#ARGUMENTS.toAddress.provinceCode#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.toAddress.postalCode#</PostalCode>
							<CountryCode>#ARGUMENTS.toAddress.countryCode#</CountryCode>
						</Address>
					</ShipTo>												
					<Package>
						<PackagingType>
							<Code>02</Code>
							<Description>Package</Description>
						</PackagingType>
						<PackageWeight>
							<UnitOfMeasurement>
								<Code>LBS</Code>
							</UnitOfMeasurement>
							<Weight>#xmlFormat(EntityLoadByPK("product", ARGUMENTS.productId).getWeight())#</Weight>
						</PackageWeight>
					</Package>
					<ShipmentServiceOptions/>
				</Shipment>
			</RatingServiceSelectionRequest>
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