<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		<!---
		<cfif SESSION.order.couponCode NEQ "">
			<cfset LOCAL.cartService = new "#APPLICATION.componentPathRoot#core.services.cartService"() />
			<cfset LOCAL.applyCoupon = LOCAL.cartService.applyCouponCode(couponCode = SESSION.order.couponCode, customerId = SESSION.user.customerId, total = SESSION.order.subTotalPrice) />
			<cfif LOCAL.applyCoupon.success EQ false>
				<cfset ArrayAppend(LOCAL.messageArray,"The coupon is not valid.") />
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		--->
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Confirmation | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset _addOrderLog() />
		<cfset LOCAL.redirectUrl = _sendPayPalRequest().redirectUrl />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_sendPayPalRequest" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.requestData = {}>
		<cfset LOCAL.requestData.METHOD = "SetExpressCheckout">
		<cfset LOCAL.requestData.PAYMENTACTION = "sale">
		<cfset LOCAL.requestData.USER = APPLICATION.paypal.APIUserName>
		<cfset LOCAL.requestData.PWD = APPLICATION.paypal.APIPassword>
		<cfset LOCAL.requestData.SIGNATURE = APPLICATION.paypal.APISignature>
		<cfset LOCAL.requestData.VERSION = APPLICATION.paypal.version>
		<cfset LOCAL.requestData.ADDRESSOVERRIDE = "1">
		<cfset LOCAL.requestData.Email = SESSION.order.customer.email>
		<cfset LOCAL.requestData.SHIPTONAME = SESSION.order.customer.fullName>
		<cfset LOCAL.requestData.SHIPTOSTREET = SESSION.order.shippingAddress.street>
		<cfset LOCAL.requestData.SHIPTOCITY = SESSION.order.shippingAddress.city>
		<cfset LOCAL.requestData.SHIPTOSTATE = SESSION.order.billingAddress.provinceCode>
		<cfset LOCAL.requestData.SHIPTOCOUNTRYCODE = SESSION.order.billingAddress.countryCode>
		<cfset LOCAL.requestData.CURRENCYCODE = SESSION.currency.code>
		<cfset LOCAL.requestData.SHIPTOZIP = SESSION.order.shippingAddress.postalCode>
		<cfset LOCAL.requestData.SHIPTOPHONENUM = SESSION.order.shippingAddress.phone>
		
		<cfloop from="1" to="#ArrayLen(SESSION.order.productArray)#" index="LOCAL.i">
			<cfset LOCAL.product = EntityLoadByPK("product",SESSION.order.productArray[LOCAL.i].productId) />
			<cfset l_name = LOCAL.product.getDisplayName()>
			<cfset l_amt = SESSION.order.productArray[LOCAL.i].singlePrice)>
			<cfset l_qty = SESSION.order.productArray[LOCAL.i].count>
			<cfset l_number = SESSION.order.productArray[LOCAL.i].productId>
			<cfset StructInsert(LOCAL.requestData,"L_NAME#LOCAL.i-1#",l_name)>
			<cfset StructInsert(LOCAL.requestData,"L_AMT#LOCAL.i-1#",l_amt)>
			<cfset StructInsert(LOCAL.requestData,"L_QTY#LOCAL.i-1#",l_qty)>
			<cfset StructInsert(LOCAL.requestData,"L_NUMBER#LOCAL.i-1#",l_number)>
		</cfloop>
		<cfset LOCAL.requestData.ITEMAMT = SESSION.order.subTotalPrice>
		<cfset LOCAL.requestData.SHIPPINGAMT = SESSION.order.totalShippingFee>
		<cfset LOCAL.requestData.TAXAMT = SESSION.order.totalTax>
		<cfset LOCAL.requestData.AMT = SESSION.order.totalPrice>
		<cfset LOCAL.requestData.CancelURL = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm" >
		<cfset LOCAL.requestData.ReturnURL = "#APPLICATION.https_root_url#checkout/checkout_thankyou.cfm">

		<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="doHttppost" returnvariable="LOCAL.response">
			<cfinvokeargument name="LOCAL.requestData" value="#LOCAL.requestData#">
			<cfinvokeargument name="serverURL" value="#APPLICATION.paypal.serverURL#">
			<cfinvokeargument name="proxyName" value="#APPLICATION.paypal.proxyName#">
			<cfinvokeargument name="proxyPort" value="#APPLICATION.paypal.proxyPort#">
			<cfinvokeargument name="useProxy" value="#APPLICATION.paypal.useProxy#">
		</cfinvoke>							
			
		<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="getNVPResponse" returnvariable="LOCAL.responseStruct">
			<cfinvokeargument name="nvpString" value="#URLDecode(LOCAL.response)#">
		</cfinvoke>	

		<cfif LOCAL.responseStruct.Ack EQ "Success">
			<cfset TOKEN = LOCAL.responseStruct.TOKEN>
			<cfset redirecturl = #APPLICATION.paypal.PayPalURL# & #TOKEN#>
			<cfset LOCAL.redirectUrl = redirecturl />
		<cfelse>
			<cfdump var="#LOCAL.responseStruct.L_LONGMESSAGE0#" abort>
			<!---
			<cfset APPLICATION.utilsSupport.createAnonymousConv(subject = "http post error",
																content = "error: #LOCAL.responseStruct.L_LONGMESSAGE0#") />

			<cfset SESSION.order.transaction_failed_reason = LOCAL.responseStruct.L_LONGMESSAGE0 />	
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm" />
			--->
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>
	
	<cffunction name="_addOrderLog" access="private" output="false" returnType="void">
	</cffunction>
</cfcomponent>