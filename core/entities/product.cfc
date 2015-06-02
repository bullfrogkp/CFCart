<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="stock" column="stock" ormtype="integer"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	
	<cfproperty name="length" column="length" ormtype="float"> 
	<cfproperty name="width" column="width" ormtype="float"> 
	<cfproperty name="height" column="height" ormtype="float"> 
	<cfproperty name="weight" column="weight" ormtype="float"> 
	
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set" fkcolumn="attribute_set_id">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category" fkcolumn="tax_category_id">
	
	<cfproperty name="productAttributeRelas" type="array" fieldtype="one-to-many" cfc="product_attribute_rela" fkcolumn="product_id" singularname="productAttributeRela" cascade="delete-orphan">
	<cfproperty name="productVideos" type="array" fieldtype="one-to-many" cfc="product_video" fkcolumn="product_id" singularname="productVideo" cascade="delete-orphan">
	
	<cfproperty name="parentProduct" fieldtype="many-to-one" cfc="product" fkcolumn="parent_product_id">
	<cfproperty name="subProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="parent_product_id" singularname="subProduct" cascade="delete-orphan">
	
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="product_id" singularname="review" cascade="delete-orphan">
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="product_id" singularname="image" cascade="delete-orphan" orderby="rank">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="product_id" singularname="productCustomerGroupRela" cascade="delete-orphan">
	<cfproperty name="productShippingMethodRelas" type="array" fieldtype="one-to-many" cfc="product_shipping_method_rela" fkcolumn="product_id" singularname="productShippingMethodRela" cascade="delete-orphan">
	
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" singularname="category">
	<cfproperty name="relatedProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="product_id" inversejoincolumn="related_parent_product_id" singularname="relatedProduct">
	<cfproperty name="relatedParentProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="related_parent_product_id" inversejoincolumn="product_id" singularname="relatedParentProduct">
	
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeAllCategories" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategories())>
			<cfset ArrayClear(getCategories()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeSubProducts" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getSubProducts())>
			<cfset ArrayClear(getSubProducts()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductAttributeRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductAttributeRelas())>
			<cfset ArrayClear(getProductAttributeRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductShippingMethodRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductShippingMethodRelas())>
			<cfset ArrayClear(getProductShippingMethodRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPrice" access="public" output="false" returnType="string">
		<cfargument name="customerGroupName" type="string" required="true">
		
		<cfset var customerGroup = EntityLoad("customer_group",{name = ARGUMENTS.customerGroupName},true) />
		<cfset var product = EntityLoadByPK("product",getProductId()) />
		<cfset var productCustomeGroupRela = EntityLoad("product_customer_group_rela",{customerGroup=customerGroup,product=product},true) />
		<cfset var price = 0 />
		
		<cfif NOT IsNull(productCustomeGroupRela)>
			<cfif IsNumeric(productCustomeGroupRela.getSpecialPrice())>
				<cfif IsDate(productCustomeGroupRela.getSpecialPriceFromDate()) AND IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0
							AND
							DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceFromDate())>
					<cfif DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelse>
					<cfset price = productCustomeGroupRela.getPrice() />
				</cfif>
			<cfelse>
				<cfset price = productCustomeGroupRela.getPrice() />
			</cfif>
		</cfif>
		
		<cfreturn price />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfset var imageType = "" />
		<cfif Trim(ARGUMENTS.type) NEQ "">
			<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
		</cfif>
		
		<cfset var imageLink = "" />
		<cfset var productImg = EntityLoad("product_image",{product = this, isDefault = true},true) />
		
		<cfif IsNull(productImg)>
			<cfif NOT IsNull(getImages()) AND ArrayLen(getImages()) GT 0>
				<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProductId()#/#imageType##getImages()[1].getName()#" />
			<cfelse>
				<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/site/no_image_available.png" />
			</cfif>
		<cfelse>
			<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProductId()#/#imageType##productImg.getName()#" />
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="isFreeShipping" access="public" output="false" returnType="boolean">
		<cfset var LOCAL = {} />
		<cfset var retValue = false />
		
		<cfquery name="LOCAL.checkFreeShipping">
			SELECT	1
			FROM	product_shipping_method_rela psmr
			JOIN	shipping_method sm ON psmr.shipping_method_id = sm.shipping_method_id
			WHERE	sm.name = 'free shipping'
			AND		psmr.product_id = #getProductId()#
		</cfquery>
		
		<cfif LOCAL.checkFreeShipping.recordCount GT 0>
			<cfset retValue = true />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="string">
		<cfreturn "#APPLICATION.absoluteUrlWeb#product_detail.cfm/#URLEncodedFormat(getDisplayName())#/#getProductId()#" />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="isProductAttributeComplete" output="false" access="public" returntype="boolean">
		<cfset var LOCAL = {} />
	   
		<cfset LOCAL.retValue = true />
		
		<cfif IsNull(getAttributeSet())>
			<cfset LOCAL.retValue = false />
		<cfelse>
			<cfloop array="#getAttributeSet().getAttributeSetAttributeRelas()#" index="LOCAL.attributeSetAttributeRela">
				<cfif LOCAL.attributeSetAttributeRela.getRequired() EQ true>
					<cfset LOCAL.attribute = LOCAL.attributeSetAttributeRela.getAttribute() />
					<cfset LOCAL.productAttributeRela = EntityLoad("product_attribute_rela", {product=this,attribute=LOCAL.attribute, required=true},true) />
					<cfif IsNull(LOCAL.productAttributeRela) OR ArrayIsEmpty(LOCAL.productAttributeRela.getAttributeValues())>
						<cfset LOCAL.retValue = false />
						<cfbreak />
					</cfif>
				</cfif>
			</cfloop>
		</cfif>
		
		<cfreturn LOCAL.retValue />
    </cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxRate" access="public" output="false" returnType="string">
		<cfargument name="provinceId" type="numeric" required="true" />
		
		<cfset var tax = EntityLoad("tax",{province=EntityLoadByPK("province",ARGUMENTS.provinceId), taxCategory=getTaxCategory()},true) />
		
		<cfreturn tax.getRate() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getShippingFee" access="public" output="false" returnType="string">
		<cfargument name="address" type="struct" required="true" />
		<cfargument name="shippingMethodId" type="numeric" required="true" />
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",ARGUMENTS.shippingMethodId) />
		<cfset LOCAL.componentName = LOCAL.shippingMethod.getShippingCarrier().getComponent() />
		
		<cfset LOCAL.xmlData = createShippingRateXml(	items_array = ARGUMENTS.items_array
													,	ship_from_address = APPLICATION.ship_from_address
													,	ship_to_address = ARGUMENTS.address
													,	service_code = LOCAL.shippingMethod.getServiceCode())>										
										
		
		<cfset LOCAL.shippingRate = submitXml(xml_data = LOCAL.xmlData, xml_data_type = "rate")>			
	
		<cfreturn LOCAL.shippingRate["RatingServiceSelectionResponse"]["RatedShipment"]["TotalCharges"]["MonetaryValue"].xmlText>
		
		<cfreturn LOCAL.shippingComponent.getShippingFee() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="createShippingRateXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="items_array" type="Array" required="true">
		<cfargument name="ship_from_address" type="struct" required="true">
		<cfargument name="ship_to_address" type="struct" required="true">
		<cfargument name="service_code" type="string" required="true">
		
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
							<AddressLine1>#ARGUMENTS.ship_from_address.street#</AddressLine1>
							<City>#ARGUMENTS.ship_from_address.city#</City>
							<StateProvinceCode>#ARGUMENTS.ship_from_address.province_code#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.ship_from_address.postal_code#</PostalCode>
							<CountryCode>#ARGUMENTS.ship_from_address.country_code#</CountryCode>
						</Address>
					</Shipper>
					<ShipTo>
						<Address>
							<AddressLine1>#ARGUMENTS.ship_to_address.street#</AddressLine1>
							<City>#ARGUMENTS.ship_to_address.city#</City>
							<StateProvinceCode>#ARGUMENTS.ship_to_address.province_code#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.ship_to_address.postal_code#</PostalCode>
							<CountryCode>#ARGUMENTS.ship_to_address.country_code#</CountryCode>
						</Address>
					</ShipTo>
					<Service>
						<Code>#ARGUMENTS.service_code#</Code>
					</Service>
					
					<cfloop from="1" to="#ArrayLen(ARGUMENTS.items_array)#" index="i">						
						<cfset LOCAL.total_weight += items_array[i].quantity * items_array[i].weight />
					</cfloop>	
													
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
							<Weight>#xmlFormat(LOCAL.total_weight)#</Weight>
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
	<cffunction name="submitXml" displayname="Submit XML" description="Submits XML documents to UPS to get the response data" access="private" output="false" returntype="any">
		<cfargument name="xml_data_type" type="string" required="true">
		<cfargument name="xml_data" type="string" required="true">
		
		<cfif xml_data_type EQ "rate">
			<cfset LOCAL.submit_url = APPLICATION.ups.rate_url />
		<cfelseif xml_data_type EQ "av">
			<cfset LOCAL.submit_url = APPLICATION.ups.av_url />
		<cfelseif xml_data_type EQ "tracking">
			<cfset LOCAL.submit_url = APPLICATION.ups.tracking_url />
		</cfif>
		
		<cfhttp url="#LOCAL.submit_url#" method="post" result="LOCAL.shippingData">
			<cfhttpparam type="xml" value="#ARGUMENTS.xml_data#">
		</cfhttp>
		
		<cfset LOCAL.xmlDataParsed = xmlparse(LOCAL.shippingData.filecontent)>
		
		<cfreturn LOCAL.xmlDataParsed>
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>
