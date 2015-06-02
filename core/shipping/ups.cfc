<cfcomponent extends="service" output="false" accessors="true">
	<cfproperty name="shippingMethodId" type="numeric"> 
	<cfproperty name="productId" type="numeric"> 
    <cfproperty name="address" type="struct"> 
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingFee" access="public" returntype="numeric">
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",getShippingMethodId()) />
						
		<cfset LOCAL.xmlData = _createShippingRateXml(	fromAddress = APPLICATION.siteInfo.getAddress()
													,	toAddress = getAddress()
													,	serviceCode = LOCAL.shippingMethod.getServiceCode())>										
										
		<cfset LOCAL.shippingRate = _submitXml(xmlData = LOCAL.xmlData, xmlDataType = "rate")>
		<cfreturn LOCAL.shippingRate["RatingServiceSelectionResponse"]["RatedShipment"]["TotalCharges"]["MonetaryValue"].xmlText>
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_submitXml" displayname="Submit XML" description="Submits XML documents to UPS to get the response data" access="private" output="false" returntype="any">
		<cfargument name="xmlDataType" type="string" required="true">
		<cfargument name="xmlData" type="string" required="true">
		
		<cfif xmlDataType EQ "rate">
			<cfset LOCAL.submit_url = APPLICATION.ups.rate_url />
		<cfelseif xmlDataType EQ "av">
			<cfset LOCAL.submit_url = APPLICATION.ups.av_url />
		<cfelseif xmlDataType EQ "tracking">
			<cfset LOCAL.submit_url = APPLICATION.ups.tracking_url />
		</cfif>
		
		<cfhttp url="#LOCAL.submit_url#" method="post" result="LOCAL.shippingData">
			<cfhttpparam type="xml" value="#ARGUMENTS.xmlData#">
		</cfhttp>
		
		<cfset LOCAL.xmlDataParsed = xmlparse(LOCAL.shippingData.filecontent)>
		
		<cfreturn LOCAL.xmlDataParsed>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_createShippingRateXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="fromAddress" type="struct" required="true">
		<cfargument name="toAddress" type="struct" required="true">
		<cfargument name="serviceCode" type="string" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.total_weight = 0 />
		
		<cfxml variable="LOCAL.xmlShippingRequest" casesensitive="true">
			<cfoutput>
			<RatingServiceSelectionRequest>
				<Request>
					<RequestAction>Rate</RequestAction>
				</Request>
				<PickupType>
					<Code>06</Code>
				</PickupType>
				<Shipment>
					<Shipper>
						<Address>
							<AddressLine1>#ARGUMENTS.fromAddress.street#</AddressLine1>
							<City>#ARGUMENTS.fromAddress.city#</City>
							<StateProvinceCode>#ARGUMENTS.fromAddress.province_code#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.fromAddress.postal_code#</PostalCode>
							<CountryCode>#ARGUMENTS.fromAddress.country_code#</CountryCode>
						</Address>
					</Shipper>
					<ShipTo>
						<Address>
							<AddressLine1>#ARGUMENTS.toAddress.street#</AddressLine1>
							<City>#ARGUMENTS.toAddress.city#</City>
							<StateProvinceCode>#ARGUMENTS.toAddress.province_code#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.toAddress.postal_code#</PostalCode>
							<CountryCode>#ARGUMENTS.toAddress.country_code#</CountryCode>
						</Address>
					</ShipTo>
					<Service>
						<Code>#ARGUMENTS.serviceCode#</Code>
					</Service>													
					<Package>
						<PackagingType>
							<Code>02</Code>
							<Description>Package</Description>
						</PackagingType>
						<Description>Rate Shopping</Description>
						<PackageWeight>
							<UnitOfMeasurement>
								<Code>LBS</Code>
							</UnitOfMeasurement>
							<Weight>#xmlFormat(getProduct().getWeight())#</Weight>
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
	
	<!------------------------------------------------------------------------------->
	<cffunction name="createTrackingXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="track_number" type="string" required="true">
		
		<cfxml variable="LOCAL.xmlTrackingRequest" casesensitive="true">
			<cfoutput>
			<TrackRequest>
				<Request>
					<RequestAction>Track</RequestAction>
				</Request>
				<TrackingNumber>#ARGUMENTS.track_number#</TrackingNumber>
			</TrackRequest>
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
			<cfoutput>#LOCAL.xmlTrackingRequest#</cfoutput>
		</cfsavecontent>	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>

	<!------------------------------------------------------------------------------->
	
	<!------------------------------------------------------------------------------->
	<cffunction name="createAddressValidationXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="ship_to_address" type="struct" required="true">
		
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
					<City>#ARGUMENTS.ship_to_address.shipto_city#</City>
					<StateProvinceCode>#ARGUMENTS.ship_to_address.shipto_province_code#</StateProvinceCode>
					<CountryCode>#ARGUMENTS.ship_to_address.shipto_country_code#</CountryCode>
					<PostalCode>#ARGUMENTS.ship_to_address.shipto_postal_code#</PostalCode>
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
	
	<!------------------------------------------------------------------------------->
	<cffunction name="validateAddressUPS" access="public" returntype="boolean">
	    <cfargument name="address_struct" type="struct" required="false">
		
		<cfset var LOCAL = StructNew() />
		
		<cfset LOCAL.items_array = ArrayNew(1) />
		<cfset LOCAL.item = StructNew() />
		
		<cfquery name="LOCAL.getItemId" datasource="#APPLICATION.data_source#">
			SELECT 	TOP(1) item_id
			FROM	items;
		</cfquery>
		
		<cfset LOCAL.item.item_id = LOCAL.getItemId.item_id />
		<cfset LOCAL.item.quantity = 1 />
		<cfset LOCAL.item.weight = 1 />
		<cfset ArrayAppend(LOCAL.items_array,LOCAL.item) />
		
		<cfinvoke component="#APPLICATION.db_cfc_path#db.provinces" method="getProvinces" returnvariable="province_detail">
			<cfinvokeargument name="province_id" value="#ARGUMENTS.address_struct.province_id#">
		</cfinvoke>
		
		<cfset ARGUMENTS.address_struct.province_code = province_detail.province_code />
					
		<cfinvoke component="#APPLICATION.db_cfc_path#db.countries" method="getCountries" returnvariable="country_detail">
			<cfinvokeargument name="country_id" value="#ARGUMENTS.address_struct.country_id#">
		</cfinvoke>			
		
		<cfset ARGUMENTS.address_struct.country_code = country_detail.country_code />	
		
		<cfset LOCAL.xmlData = createShippingRateXml(	items_array = LOCAL.items_array
													,	ship_from_address = APPLICATION.ship_from_address
													,	ship_to_address = ARGUMENTS.address_struct
													,	service_code = 11)>	
													
		<cfset LOCAL.shippingRate = submitXml(xml_data = LOCAL.xmlData, xml_data_type = "rate")>									
		<cfif XmlSearch(LOCAL.shippingRate, "/RatingServiceSelectionResponse/Response/ResponseStatusDescription")[1].xmlText EQ "success">
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>							
		
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	
	<!------------------------------------------------------------------------------->
	<cffunction name="trackUPSPackage" access="public" returntype="struct">
	    <cfargument name="track_number" type="string" required="false">
		
		<cfset var LOCAL = StructNew() />
		<cfset var ret_struct = StructNew() />
		
		<cfset LOCAL.xmlData = createTrackingXml(track_number = ARGUMENTS.track_number)>
		<cfset LOCAL.tracking_response = submitXml(xml_data = LOCAL.xmlData, xml_data_type = "tracking")>	
		
		<cfif XmlSearch(LOCAL.tracking_response, "/TrackResponse/Response/ResponseStatusDescription")[1].xmlText EQ "success">
			<cfset ret_struct.activity = StructNew() />
			<cfset ret_struct.activity.city = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/ActivityLocation/Address/City")[1].xmlText />
			<cfset ret_struct.activity.state_province_code = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/ActivityLocation/Address/StateProvinceCode")[1].xmlText />
			<cfset ret_struct.activity.country_code = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/ActivityLocation/Address/CountryCode")[1].xmlText />
			<cfset ret_struct.activity.date = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/Date")[1].xmlText />
			<cfset ret_struct.activity.time = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/Time")[1].xmlText />
			<cfset ret_struct.activity.status_description = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/Status/StatusType/Description")[1].xmlText />
		</cfif>
		
		<cfreturn ret_struct />
	</cffunction>	
	<!------------------------------------------------------------------------------->	
</cfcomponent>