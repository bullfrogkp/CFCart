<cfcomponent output="false" accessors="true">
    <cfproperty name="cfid" type="string"> 
    <cfproperty name="cftoken" type="string"> 
    <cfproperty name="currencyId" type="integer"> 
    <cfproperty name="customerId" type="integer"> 
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
		
			<cfset setSubTotalPrice(getSubTotalPrice() + LOCAL.productStruct.totalPrice) />
		</cfloop>
		
		<cfif getCouponCode() NEQ "">
			<cfset LOCAL.cartService = new "#APPLICATION.componentPathRoot#core.services.cartService"() />
			<cfset LOCAL.applyCoupon = LOCAL.cartService.applyCouponCode(couponCode = getCouponCode(), customerId = getCustomerId, total = getSubTotalPrice) />
			
			<cfif LOCAL.applyCoupon.success EQ true>
				<cfset SESSION.order.couponCode = Trim(FORM.coupon_code_applied) />
				<cfset SESSION.order.couponId = LOCAL.applyCoupon.couponId />
				<cfset SESSION.order.discount = LOCAL.applyCoupon.discount />
				<cfset SESSION.order.subTotalPrice = LOCAL.applyCoupon.newTotal />
			</cfif>
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>
