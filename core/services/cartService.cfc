﻿<cfcomponent output="false" accessors="true">
	<cffunction name="applyCouponCode" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="couponCode" type="string" required="true">
		<cfargument name="customerId" type="string" required="true">
		<cfargument name="total" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
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
		<cfset LOCAL.currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		
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
					<cfset retStruct.discount = LOCAL.coupon.getDiscountType().getAmount() * LOCAL.currency.getMultiplier() />
				<cfelseif LOCAL.coupon.getDiscountType().getCalculationType().getName() EQ "percentage">
					<cfset retStruct.discount = ARGUMENTS.total * LOCAL.coupon.getDiscountType().getAmount().getMultiplier() />
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
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="cartLogin" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfset LOCAL = {} />
		<cfset LOCAL.retValue = false />
		
		<cfset LOCAL.customer = EntityLoad("customer",{email = ARGUMNENTS.username, password = Hash(ARGUMNENTS.password),isDeleted=false,isEnabled=true},true) />
		<cfif NOT IsNull(LOCAL.customer)>
			<cfset LOCAL.retValue = true />
		</cfif>
	
		<cfreturn LOCAL.retValue />
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="addProductToCart" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="productid" type="string" required="true">
		<cfargument name="quantity" type="string" required="true">
		
		<cfset LOCAL = {} />
		<cfset LOCAL.retValue = false />
		
		<cfset LOCAL.customer = EntityLoad("customer",{email = ARGUMNENTS.username, password = Hash(ARGUMNENTS.password),isDeleted=false,isEnabled=true},true) />
		<cfif NOT IsNull(LOCAL.customer)>
			<cfset LOCAL.retValue = true />
		</cfif>
	
		<cfreturn LOCAL.retValue />
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
</cfcomponent>