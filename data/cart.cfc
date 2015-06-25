<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_count")>
			<cfloop collection="#FORM#" item="LOCAL.field">
				<cfif FindNoCase("product_count_", LOCAL.field) AND (NOT IsNumeric(FORM["#LOCAL.field#"]) OR FORM["#LOCAL.field#"] LT 1)>
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid value for the number of products in the order.") />
					<cfbreak />
				</cfif>
			</cfloop>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Shopping Cart | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.trackingRecords = _getTrackingRecords(trackingRecordType = "shopping cart") />
		
		<cfset LOCAL.pageData.subTotal = 0 />
		
		<cfloop array="#LOCAL.pageData.trackingRecords#" index="LOCAL.record">
			<cfset LOCAL.product = LOCAL.record.getProduct() />
			<cfset LOCAL.pageData.subTotal += LOCAL.product.getPrice(customerGroupName = SESSION.user.customerGroupName, currencyId = SESSION.currency.id) * LOCAL.record.getCount() />
		</cfloop>
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"submit_cart") OR StructKeyExists(FORM,"submit_cart.x")>
		
			<cfset SESSION.order = {} />
			<cfset SESSION.order.productArray = [] />
			<cfset SESSION.order.couponCode = "" />
			<cfset SESSION.order.couponId = "" />
			
			<cfset SESSION.order.price = {} />
			
			<cfloop array="#LOCAL.currencies#" index="LOCAL.currency">
				<cfset SESSION.order.price["#LOCAL.currency.getCode()#"] = {} />
				<cfset SESSION.order.price["#LOCAL.currency.getCode()#"].subTotalPrice = 0 />
				<cfset SESSION.order.price["#LOCAL.currency.getCode()#"].totalPrice = 0 />
				<cfset SESSION.order.price["#LOCAL.currency.getCode()#"].totalTax = 0 />
				<cfset SESSION.order.price["#LOCAL.currency.getCode()#"].totalShippingFee = 0 />
				<cfset SESSION.order.price["#LOCAL.currency.getCode()#"].discount = 0 />
			</cfloop>
			
			<cfset LOCAL.trackingRecords = _getTrackingRecords(trackingRecordType = "shopping cart") />
			<cfset LOCAL.currencies = EntityLoad("currency",{isDeleted = false, isEnabled = true}) />
		
			<cfloop array="#LOCAL.trackingRecords#" index="LOCAL.record">
				<cfset LOCAL.productStruct = {} />
				<cfset LOCAL.productStruct.productId = LOCAL.record.getProduct().getProductId() />
				<cfset LOCAL.productStruct.count = LOCAL.record.getCount() />
				<cfset LOCAL.productStruct.price = {} />
				<cfloop array="#LOCAL.currencies#" index="LOCAL.currency">
					<cfset LOCAL.productStruct.price["#LOCAL.currency.getCode()#"] = {} />
					<cfset LOCAL.productStruct.price["#LOCAL.currency.getCode()#"].singlePrice = LOCAL.record.getProduct().getPrice(customerGroupName = SESSION.user.customerGroupName, currencyId = LOCAL.currency.getCurrencyId()) />
					<cfset LOCAL.productStruct.price["#LOCAL.currency.getCode()#"].totalPrice = LOCAL.productStruct.price["#LOCAL.currency.getCode()#"].singlePrice * LOCAL.productStruct.count />
				</cfloop>
			
				<cfset ArrayAppend(SESSION.order.productArray, LOCAL.productStruct) />
			
				<cfset SESSION.order.subTotalPrice += LOCAL.productStruct.totalPrice />
			</cfloop>
			
			<cfif Trim(FORM.coupon_code_applied) NEQ "">
				<cfset LOCAL.cartService = new "#APPLICATION.componentPathRoot#core.services.cartService"() />
				<cfset LOCAL.applyCoupon = LOCAL.cartService.applyCouponCode(couponCode = Trim(FORM.coupon_code_applied), customerId = SESSION.user.customerId, total = SESSION.order.subTotalPrice) />
				
				<cfif LOCAL.applyCoupon.success EQ true>
					<cfset SESSION.order.couponCode = Trim(FORM.coupon_code_applied) />
					<cfset SESSION.order.couponId = LOCAL.applyCoupon.couponId />
					<cfset SESSION.order.discount = LOCAL.applyCoupon.discount />
					<cfset SESSION.order.subTotalPrice = LOCAL.applyCoupon.newTotal />
				</cfif>
			</cfif>
		
			<cfif IsNumeric(SESSION.user.customerId)>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_step1_customer.cfm" />
			<cfelse>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_signin.cfm" />
			</cfif>
		<cfelseif StructKeyExists(FORM,"update_count")>
			<cfset LOCAL.trackingRecord = EntityLoadByPK("tracking_record",FORM.tracking_record_id) />
			<cfset LOCAL.trackingRecord.setCount(FORM["product_count_#FORM.tracking_record_id#"]) />
			<cfset EntitySave(LOCAL.trackingRecord) />
		<cfelseif StructKeyExists(FORM,"remove_product") OR StructKeyExists(FORM,"remove_product.x")>
			<cfset LOCAL.trackingRecord = EntityLoadByPK("tracking_record",FORM.remove_product) />
			<cfset EntityDelete(LOCAL.trackingRecord) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>