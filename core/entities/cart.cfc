<cfcomponent output="false" accessors="true">
    <cfproperty name="cfid" type="string"> 
    <cfproperty name="cftoken" type="string"> 
    <cfproperty name="currencyId" type="integer"> 
    <cfproperty name="customerId" type="integer"> 
    <cfproperty name="customerGroupName" type="string"> 
	
    <cfproperty name="couponCode" type="string"> 
    <cfproperty name="couponId" type="integer"> 
    <cfproperty name="isExistingCustomer" type="boolean"> 
    <cfproperty name="sameAddress" type="boolean"> 
    <cfproperty name="productShippingMethodRelaIdList" type="string"> 
    <cfproperty name="customer" type="struct"> 
    <cfproperty name="shippingAddress" type="struct"> 
    <cfproperty name="billingAddress" type="struct"> 
    <cfproperty name="productArray" type="array"> 
	
    <cfproperty name="subTotalPrice" type="float"> 
    <cfproperty name="totalPrice" type="float"> 
    <cfproperty name="totalTax" type="float"> 
    <cfproperty name="totalShippingFee" type="float"> 
    <cfproperty name="discount" type="float"> 
	
	<cfproperty name="subTotalPriceWCLocal" type="string"> 
    <cfproperty name="totalPriceWCLocal" type="string"> 
    <cfproperty name="totalTaxWCLocal" type="string"> 
    <cfproperty name="totalShippingFeeWCLocal" type="string"> 
    <cfproperty name="discountWCLocal" type="string"> 
	
	<cfproperty name="subTotalPriceWCInter" type="string"> 
    <cfproperty name="totalPriceWCInter" type="string"> 
    <cfproperty name="totalTaxWCInter" type="string"> 
    <cfproperty name="totalShippingFeeWCInter" type="string"> 
    <cfproperty name="discountWCInter" type="string"> 
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="_getTrackingRecords" access="private" output="false" returnType="array">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = "shopping cart"},true) />
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = getCfId(), cftoken = getCfToken()},true) />
		<cfset LOCAL.trackingRecords = EntityLoad("tracking_record", {trackingRecordType = LOCAL.trackingRecordType, trackingEntity = LOCAL.trackingEntity}) />
		
		<cfreturn LOCAL.trackingRecords />	
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="calculate" access="public" output="false" returnType="void">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.trackingRecords = _getTrackingRecords(trackingRecordType = "shopping cart") />
		<cfset LOCAL.currency = EntityLoadByPK("currency",getCurrencyId()) />
		
		<cfset LOCAL.productArray = [] />
		<cfset LOCAL.subTotalPrice = 0 />
		<cfset LOCAL.totalTax = 0 />
		<cfset LOCAL.totalPrice = 0 />
		<cfset LOCAL.totalShippingFee = 0 />
		<cfset LOCAL.discount = 0 />
		<cfset LOCAL.couponId = "" />
		
		<cfloop array="#LOCAL.trackingRecords#" index="LOCAL.record">
			<cfset LOCAL.productStruct = {} />
			<cfset LOCAL.product = LOCAL.record.getProduct() />
			<cfset LOCAL.productStruct.productId = LOCAL.product.getProductId() />
			<cfset LOCAL.productStruct.count = LOCAL.record.getCount() />
			<cfset LOCAL.productStruct.singlePrice = LOCAL.product.getPrice(customerGroupName = getCustomerGroupName(), currencyId = getCurrencyId()) />
			<cfset LOCAL.productStruct.singlePriceWCLocal = LSCurrencyFormat(LOCAL.productStruct.singlePrice,"local",LOCAL.currency.getLocale()) />
			<cfset LOCAL.productStruct.singlePriceWCInter = LSCurrencyFormat(LOCAL.productStruct.singlePrice,"international",LOCAL.currency.getLocale()) />
			<cfset LOCAL.productStruct.totalPrice = LOCAL.productStruct.singlePrice * LOCAL.productStruct.count />
			<cfset LOCAL.productStruct.totalPriceWCLocal = LSCurrencyFormat(LOCAL.productStruct.totalPrice,"local",LOCAL.currency.getLocale()) />
			<cfset LOCAL.productStruct.totalPriceWCInter = LSCurrencyFormat(LOCAL.productStruct.totalPrice,"international",LOCAL.currency.getLocale()) />
		
			<cfif NOT IsNull(getShippingAddress())>
				<cfset LOCAL.productShippingMethodRelas = LOCAL.product.getProductShippingMethodRelasMV() />
				<cfset LOCAL.productStruct.shippingMethodArray = [] />
			
				<cfloop array="#LOCAL.productShippingMethodRelas#" index="LOCAL.productShippingMethodRela">
					<cfset LOCAL.shippingMethod = LOCAL.productShippingMethodRela.getShippingMethod() />
					<cfset LOCAL.shippingMethodStruct = {} />
					<cfset LOCAL.shippingMethodStruct.productShippingMethodRelaId = LOCAL.productShippingMethodRela.getProductShippingMethodRelaId() />
					<cfset LOCAL.shippingMethodStruct.name = LOCAL.shippingMethod.getDisplayName() />
					<cfset LOCAL.shippingMethodStruct.logo = LOCAL.shippingMethod.getShippingCarrier().getImageName() />
					<cfset LOCAL.shippingMethodStruct.price = LOCAL.product.getShippingFeeMV(	address = getShippingAddress()
																							, 	shippingMethodId = LOCAL.shippingMethod.getShippingMethodId()
																							,	customerGroupName = getCustomerGroupName()) * LOCAL.record.count />
					
					<cfset LOCAL.shippingMethodStruct.priceWCLocal = LSCurrencyFormat(LOCAL.shippingMethodStruct.price,"local",LOCAL.currency.getLocale()) />
					<cfset LOCAL.shippingMethodStruct.priceWCInter = LSCurrencyFormat(LOCAL.shippingMethodStruct.price,"international",LOCAL.currency.getLocale()) />
					
					<cfset LOCAL.shippingMethodStruct.label = "#LOCAL.shippingMethod.getShippingCarrier().getDisplayName()# - #LOCAL.shippingMethod.getDisplayName()#" />
				
					<cfset ArrayAppend(LOCAL.productStruct.shippingMethodArray, LOCAL.shippingMethodStruct) />
				</cfloop>
				
				<cfset LOCAL.productStruct.singleTax = NumberFormat(LOCAL.productStruct.singlePrice * LOCAL.product.getTaxRateMV(provinceId = getShippingAddress().provinceId),"0.00") />
				<cfset LOCAL.productStruct.singleTaxWCLocal = LSCurrencyFormat(LOCAL.productStruct.singleTax,"local",LOCAL.currency.getLocale()) />
				<cfset LOCAL.productStruct.singleTaxWCInter = LSCurrencyFormat(LOCAL.productStruct.singleTax,"international",LOCAL.currency.getLocale()) />
				
				<cfset LOCAL.productStruct.totalTax = LOCAL.productStruct.singleTax * LOCAL.productStruct.count />
				<cfset LOCAL.productStruct.totalTaxWCLocal = LSCurrencyFormat(LOCAL.productStruct.totalTax,"local",LOCAL.currency.getLocale()) />
				<cfset LOCAL.productStruct.totalTaxWCInter = LSCurrencyFormat(LOCAL.productStruct.totalTax,"international",LOCAL.currency.getLocale()) />
				
				<cfset LOCAL.totalTax += LOCAL.productStruct.totalTax />
			</cfif>
			
			<cfset LOCAL.subTotalPrice += LOCAL.productStruct.totalPrice />
			<cfset LOCAL.totalPrice = LOCAL.subTotalPrice + LOCAL.totalTax />
			
			<cfset ArrayAppend(LOCAL.productArray, LOCAL.productStruct) />
		</cfloop>
		
		<cfif getCouponCode() NEQ "">
			<cfset LOCAL.cartService = new "#APPLICATION.componentPathRoot#core.services.cartService"() />
			<cfset LOCAL.applyCoupon = LOCAL.cartService.applyCouponCode(couponCode = getCouponCode(), customerId = getCustomerId, total = LOCAL.subTotalPrice) />
			
			<cfif LOCAL.applyCoupon.success EQ true>
				<cfset LOCAL.couponId = LOCAL.applyCoupon.couponId />
				<cfset LOCAL.discount = LOCAL.applyCoupon.discount />
				<cfset LOCAL.subTotalPrice = LOCAL.applyCoupon.newTotal />
			</cfif>
		</cfif>
		
		<cfif NOT IsNull(getProductShippingMethodRelaIdList())>
			<!--- product_shipping_method_rela_id_list is from ddslick.min.js --->
			<cfloop list="#getProductShippingMethodRelaIdList()#" index="LOCAL.productShippingMethodRelaId">
				<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela", LOCAL.productShippingMethodRelaId) />
				<cfset LOCAL.productId = LOCAL.productShippingMethodRela.getProduct().getProductId() />
				<cfloop array="#LOCAL.productArray#" index="LOCAL.productStruct">
					<cfset LOCAL.productEntity = EntityLoadByPK("productStruct",LOCAL.productStruct.productId) />
					<cfif 	NOT IsNull(LOCAL.productEntity.getParentProduct()) AND LOCAL.productEntity.getParentProduct().getProductId() EQ LOCAL.productId
							OR
							IsNull(LOCAL.productEntity.getParentProduct()) AND LOCAL.productStruct.productId EQ LOCAL.productId>
						<cfset LOCAL.productStruct.productShippingMethodRelaId = LOCAL.productShippingMethodRelaId />
						<cfset LOCAL.productStruct.totalShippingFee = LOCAL.productShippingMethodRela.getProduct().getShippingFee(address = getShippingAddress(), shippingMethodId = LOCAL.productShippingMethodRela.getShippingMethod().getShippingMethodId(),customerGroupName = getCustomerGroupName()) * LOCAL.product.count />
						<cfset LOCAL.productStruct.totalShippingFeeWCLocal = LSCurrencyFormat(LOCAL.productStruct.totalShippingFee,"local",LOCAL.currency.getLocale()) />
						<cfset LOCAL.productStruct.totalShippingFeeWCInter = LSCurrencyFormat(LOCAL.productStruct.totalShippingFee,"international",LOCAL.currency.getLocale()) />
						
						<cfset LOCAL.totalShippingFee += LOCAL.productStruct.totalShippingFee />
						<cfbreak />
					</cfif>
				</cfloop>
			</cfloop>
		
			<cfset LOCAL.totalPrice = LOCAL.subTotalPrice + LOCAL.totalTax + LOCAL.totalShippingFee />
		</cfif>
		
		<cfset setProductArray(LOCAL.productArray) />
		<cfset setSubTotalPrice(LOCAL.subTotalPrice) />
		<cfset setTotalShippingFee(LOCAL.totalShippingFee) />
		<cfset setTotalTax(LOCAL.totalTax) />
		<cfset setTotalPrice(LOCAL.totalPrice) />
		<cfset setDiscount(LOCAL.discount) />
		<cfset setCouponId(LOCAL.couponId) />
		
		<cfset setSubTotalPriceWCLocal(LSCurrencyFormat(LOCAL.subTotalPrice,"local",LOCAL.currency.getLocale())) />
		<cfset setTotalShippingFeeWCLocal(LSCurrencyFormat(LOCAL.totalShippingFee,"local",LOCAL.currency.getLocale())) />
		<cfset setTotalTaxWCLocal(LSCurrencyFormat(LOCAL.totalTax,"local",LOCAL.currency.getLocale())) />
		<cfset setTotalPriceWCLocal(LSCurrencyFormat(LOCAL.totalPrice,"local",LOCAL.currency.getLocale())) />
		<cfset setDiscountWCLocal(LSCurrencyFormat(LOCAL.discount,"local",LOCAL.currency.getLocale())) />
		
		<cfset setSubTotalPriceWCInter(LSCurrencyFormat(LOCAL.subTotalPrice,"international",LOCAL.currency.getLocale())) />
		<cfset setTotalShippingFeeWCInter(LSCurrencyFormat(LOCAL.totalShippingFee,"international",LOCAL.currency.getLocale())) />
		<cfset setTotalTaxWCInter(LSCurrencyFormat(LOCAL.totalTax,"international",LOCAL.currency.getLocale())) />
		<cfset setTotalPriceWCInter(LSCurrencyFormat(LOCAL.totalPrice,"international",LOCAL.currency.getLocale())) />
		<cfset setDiscountWCInter(LSCurrencyFormat(LOCAL.discount,"international",LOCAL.currency.getLocale())) />
		
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>
