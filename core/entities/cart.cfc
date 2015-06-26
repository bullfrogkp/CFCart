<cfcomponent output="false" accessors="true">
    <cfproperty name="cfid" type="string"> 
    <cfproperty name="cftoken" type="string"> 
    <cfproperty name="currencyId" type="integer"> 
    <cfproperty name="customerGroupName" type="string"> 
    <cfproperty name="subTotalPrice" type="float"> 
    <cfproperty name="totalPrice" type="float"> 
    <cfproperty name="totalTax" type="float"> 
    <cfproperty name="totalShippingFee" type="float"> 
    <cfproperty name="discount" type="float"> 
    <cfproperty name="couponCode" type="string"> 
    <cfproperty name="couponId" type="integer"> 
	
	<!------------------------------------------------------------------------------->
	<cffunction name="init" access="public" returntype="any" output="false">
        
		<cfset setSubTotalPrice(0) />
		<cfset setTotalPrice(0) />
		<cfset setTotalTax(0) />
		<cfset setTotalShippingFee(0) />
		<cfset setDiscount(0) />
		<cfset setCouponCode("") />
		<cfset setCouponId("") />
		
        <cfreturn this />
    </cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_getTrackingRecords" access="private" output="false" returnType="array">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = "shopping cart"},true) />
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = getCfId(), cftoken = getCfToken()},true) />
		<cfset LOCAL.trackingRecords = EntityLoad("tracking_record", {trackingRecordType = LOCAL.trackingRecordType, trackingEntity = LOCAL.trackingEntity}) />
		
		<cfreturn LOCAL.trackingRecords />	
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getProductArray" access="public" output="false" returnType="array">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.productArray = [] />
		<cfset LOCAL.trackingRecords = _getTrackingRecords(trackingRecordType = "shopping cart") />
		
		<cfloop array="#LOCAL.trackingRecords#" index="LOCAL.record">
			<cfset LOCAL.productStruct = {} />
			<cfset LOCAL.productStruct.productId = LOCAL.record.getProduct().getProductId() />
			<cfset LOCAL.productStruct.count = LOCAL.record.getCount() />
			<cfset LOCAL.productStruct.singlePrice = LOCAL.record.getProduct().getPrice(customerGroupName = getCustomerGroupName(), currencyId = getCurrencyId()) />
			<cfset LOCAL.productStruct.totalPrice = LOCAL.productStruct.singlePrice * LOCAL.productStruct.count />
		
			<cfset ArrayAppend(LOCAL.productArray, LOCAL.productStruct) />
		
			<cfset SESSION.order.subTotalPrice += LOCAL.productStruct.totalPrice />
			<cfset setSubTotalPrice(getSubTotalPrice() + LOCAL.productStruct.totalPrice) />
		</cfloop>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDisplayNameMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getDisplayName() />
		<cfelse>
			<cfreturn getDisplayName() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getIsEnabledMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getIsEnabled() />
		<cfelse>
			<cfreturn getIsEnabled() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTitleMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getTitle() />
		<cfelse>
			<cfreturn getTitle() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getKeywordsMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getKeywords() />
		<cfelse>
			<cfreturn getKeywords() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getDetail() />
		<cfelse>
			<cfreturn getDetail() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getLengthMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getLength() />
		<cfelse>
			<cfreturn getLength() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getWidthMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getWidth() />
		<cfelse>
			<cfreturn getWidth() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getHeightMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getHeight() />
		<cfelse>
			<cfreturn getHeight() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getWeightMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getWeight() />
		<cfelse>
			<cfreturn getWeight() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getAttributeSetMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getAttributeSet() />
		<cfelse>
			<cfreturn getAttributeSet() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxCategoryMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getTaxCategory() />
		<cfelse>
			<cfreturn getTaxCategory() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getProductVideosMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getProductVideos() />
		<cfelse>
			<cfreturn getProductVideos() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getReviewsMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getReviews() />
		<cfelse>
			<cfreturn getReviews() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getImagesMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getImages() />
		<cfelse>
			<cfreturn getImages() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getProductShippingMethodRelasMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getProductShippingMethodRelas() />
		<cfelse>
			<cfreturn getProductShippingMethodRelas() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getCategoriesMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getCategories() />
		<cfelse>
			<cfreturn getCategories() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getRelatedProductsMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfreturn getParentProduct().getRelatedProducts() />
		<cfelse>
			<cfreturn getRelatedProducts() />
		</cfif>
		
	</cffunction>
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
	<cffunction name="getPrice" access="public" output="false" returnType="numeric">
		<cfargument name="customerGroupName" type="string" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset var customerGroup = EntityLoad("customer_group",{name = ARGUMENTS.customerGroupName},true) />
		<cfset var product = EntityLoadByPK("product",getProductId()) />
		<cfset var productCustomeGroupRela = EntityLoad("product_customer_group_rela",{customerGroup=customerGroup,product=product},true) />
		<cfset var currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
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
		
		<cfset price = price * currency.getMultiplier() />
	
		<cfreturn NumberFormat(price,"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageLinkMV" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfset var imageLink = getParentProduct().getDefaultImageLink(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfset var imageLink = getDefaultImageLink(argumentCollection = ARGUMENTS) />
		</cfif>
		
		<cfreturn imageLink />
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
	<cffunction name="isFreeShippingMV" access="public" output="false" returnType="boolean">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfset var retValue = getParentProduct().isFreeShipping() />
		<cfelse>
			<cfset var retValue = isFreeShipping() />
		</cfif>
		
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
	<cffunction name="getDetailPageURLMV" access="public" output="false" returnType="string">
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfset var pageUrl = getParentProduct().getDetailPageURL() />
		<cfelse>
			<cfset var pageUrl = getDetailPageURL() />
		</cfif>
		
		<cfreturn pageUrl />
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
	<cffunction name="getTaxRateMV" access="public" output="false" returnType="numeric">
		<cfargument name="provinceId" type="numeric" required="true" />
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfset var taxRate = getParentProduct().getTaxRate(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfset var taxRate = getTaxRate(argumentCollection = ARGUMENTS) />
		</cfif>
		
		<cfreturn taxRate />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxRate" access="public" output="false" returnType="numeric">
		<cfargument name="provinceId" type="numeric" required="true" />
		
		<cfset var tax = EntityLoad("tax",{province=EntityLoadByPK("province",ARGUMENTS.provinceId), taxCategory=getTaxCategory()},true) />
		
		<cfreturn tax.getRate() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getShippingFeeMV" access="public" output="false" returnType="numeric">
		<cfargument name="address" type="struct" required="true" />
		<cfargument name="shippingMethodId" type="numeric" required="true" />
		<cfargument name="customerGroupName" type="string" required="true" />
		
		<cfif getProductType().getName() EQ "configured_product">
			<cfset var shippingFee = getParentProduct().getShippingFee(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfset var shippingFee = getShippingFee(argumentCollection = ARGUMENTS) />
		</cfif>
		
		<cfreturn shippingFee />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getShippingFee" access="public" output="false" returnType="numeric">
		<cfargument name="address" type="struct" required="true" />
		<cfargument name="shippingMethodId" type="numeric" required="true" />
		<cfargument name="customerGroupName" type="string" required="true" />
		
		<cfset var LOCAL = {} />
		
		<cfif NOT IsNull(getWeight())>
			<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",ARGUMENTS.shippingMethodId) />
			<cfset LOCAL.componentName = LOCAL.shippingMethod.getShippingCarrier().getComponent() />
		
			<cfset LOCAL.shippingComponent = new "#APPLICATION.componentPathRoot#core.shipping.#LOCAL.componentName#"() />
						
			<cfset LOCAL.shippingComponent.setShippingMethodId(ARGUMENTS.shippingMethodId) />
			<cfset LOCAL.shippingComponent.setAddress(ARGUMENTS.address) />
			<cfset LOCAL.shippingComponent.setProductId(getProductId()) />
			
			<cfset LOCAL.shippingFee = LOCAL.shippingComponent.getShippingFee() />
		<cfelse>
			<cfset LOCAL.shippingFee = getPrice(customerGroupName = ARGUMENTS.customerGroupName, currencyId = SESSION.currency.id) />
		</cfif>
		
		<cfreturn NumberFormat(LOCAL.shippingFee,"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>
