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
    <cfproperty name="productArray" type="array"> 
	
	<!------------------------------------------------------------------------------->
	<cffunction name="init" access="public" returntype="any" output="false">
        
		<cfset setSubTotalPrice(0) />
		<cfset setTotalPrice(0) />
		<cfset setTotalTax(0) />
		<cfset setTotalShippingFee(0) />
		<cfset setDiscount(0) />
		<cfset setCouponCode("") />
		<cfset setCouponId("") />
		<cfset setProductArray([]) />
		
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
	<cffunction name="calculate" access="public" output="false" returnType="void">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.trackingRecords = _getTrackingRecords(trackingRecordType = "shopping cart") />
		
		<cfloop array="#LOCAL.trackingRecords#" index="LOCAL.record">
			<cfset LOCAL.productStruct = {} />
			<cfset LOCAL.productStruct.productId = LOCAL.record.getProduct().getProductId() />
			<cfset LOCAL.productStruct.count = LOCAL.record.getCount() />
			<cfset LOCAL.productStruct.singlePrice = LOCAL.record.getProduct().getPrice(customerGroupName = getCustomerGroupName(), currencyId = getCurrencyId()) />
			<cfset LOCAL.productStruct.totalPrice = LOCAL.productStruct.singlePrice * LOCAL.productStruct.count />
		
			<cfset ArrayAppend(getProductArray(), LOCAL.productStruct) />
		
			<cfset setSubTotalPrice(getSubTotalPrice() + LOCAL.productStruct.totalPrice) />
		</cfloop>
		
		<cfif getCouponCode() NEQ "">
			<cfset LOCAL.applyCoupon = applyCouponCode(couponCode = getCouponCode(), customerId = getCustomerId, total = getSubTotalPrice) />
			
			<cfif LOCAL.applyCoupon.success EQ true>
				<cfset setCouponId(LOCAL.applyCoupon.couponId) />
				<cfset setDiscount(LOCAL.applyCoupon.discount) />
				<cfset setSubTotalPrice(LOCAL.applyCoupon.newTotal) />
			</cfif>
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="applyCouponCode" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="couponCode" type="string" required="true">
		<cfargument name="customerId" type="string" required="true">
		<cfargument name="total" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		<cfset var retStruct = {} />
		<cfset retStruct.success = true />
		<cfset retStruct.messageType = "" />
		<cfset retStruct.newTotal = "" />
		<cfset retStruct.thresholdAmount = "" />
		<cfset retStruct.discount = "" />
		<cfset retStruct.couponId = "" />
		
		<cfset LOCAL.couponStatusType = EntityLoad("coupon_status_type",{name="active"},true) />
		<cfset LOCAL.coupon = EntityLoad("coupon",{couponStatusType = LOCAL.couponStatusType, couponCode = Trim(ARGUMENTS.couponCode)},true) />
		
		<cfif NOT IsNull(LOCAL.coupon)>
			<cfif ARGUMENTS.total LT LOCAL.coupon.getThresholdAmount()>
				<cfset retStruct.success = false />
				<cfset retStruct.messageType = 1 />
				<cfset retStruct.thresholdAmount = LOCAL.coupon.getThresholdAmount() />
			<cfelseif 	IsDate(LOCAL.coupon.getStartDate()) AND DateCompare(Now(), LOCAL.coupon.getStartDate()) EQ -1
						OR
						IsDate(LOCAL.coupon.getEndDate()) AND DateCompare(LOCAL.coupon.getEndDate(), Now()) EQ -1>
				<cfset retStruct.success = false />
				<cfset retStruct.messageType = 2 />
			<cfelseif NOT IsNull(LOCAL.coupon.getCustomer()) AND IsNumeric(ARGUMENTS.customerId)>
				<cfif LOCAL.coupon.getCustomer().getCustomerId() NEQ ARGUMENTS.customerId>
					<cfset retStruct.success = false />
					<cfset retStruct.messageType = 3 />
				</cfif>
			</cfif>
			
			<cfif retStruct.success EQ true>
				<cfif LOCAL.coupon.getDiscountType().getCalculationType().getName() EQ "fixed">
					<cfset retStruct.discount = LOCAL.coupon.getDiscountType().getAmount() />
				<cfelseif LOCAL.coupon.getDiscountType().getCalculationType().getName() EQ "percentage">
					<cfset retStruct.discount = ARGUMENTS.total * LOCAL.coupon.getDiscountType().getAmount() />
				</cfif>
				<cfset retStruct.newTotal = ARGUMENTS.total - retStruct.discount />
				<cfset retStruct.couponId = LOCAL.coupon.getCouponId() />
			<cfelse>
				<cfset retStruct.newTotal = ARGUMENTS.total />
			</cfif>
		<cfelse>
			<cfset retStruct.success = false />
			<cfset retStruct.messageType = 4 />
			<cfset retStruct.newTotal = ARGUMENTS.total />
		</cfif>
		
		<cfset retStruct.newTotal = NumberFormat(retStruct.newTotal,"0.00") />
		<cfset retStruct.discount = NumberFormat(retStruct.discount,"0.00") />
		
		<cfreturn retStruct />
	</cffunction>
	
</cfcomponent>