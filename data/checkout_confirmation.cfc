<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"place_order")>
		<!---
		<cfif SESSION.cart.getCouponCode() NEQ "">
			<cfset LOCAL.cartService = new "#APPLICATION.componentPathRoot#core.services.cartService"() />
			<cfset LOCAL.applyCoupon = LOCAL.cartService.applyCouponCode(couponCode = SESSION.cart.getCouponCode(), customerId = SESSION.user.customerId, total = SESSION.cart.getSubTotalPrice()) />
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
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Confirmation | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfif StructKeyExists(URL,"token") AND StructKeyExists(URL,"payerId")>
		
			<cfset LOCAL.order = EntityLoadByPK("order",SESSION.cart.orderId) />
			<cfset LOCAL.order.setToken(URL.token) />
			<cfset LOCAL.order.setPayerId(URL.payerId) />
			<cfset EntitySave(LOCAL.order) />
			
			<cfset LOCAL.requestData = StructNew()>
			<cfset LOCAL.requestData.METHOD = "DoExpressCheckoutPayment">		
			<cfset LOCAL.requestData.USER = APPLICATION.paypal.APIUserName>
			<cfset LOCAL.requestData.PWD = APPLICATION.paypal.APIPassword>
			<cfset LOCAL.requestData.SIGNATURE = APPLICATION.paypal.APISignature>
			<cfset LOCAL.requestData.VERSION = APPLICATION.paypal.version>
			<cfset LOCAL.requestData.TOKEN = URL.token>
			<cfset LOCAL.requestData.PAYERID = URL.payerId>
			<cfset LOCAL.requestData.PAYMENTACTION = "sale">
			<cfset LOCAL.requestData.AMT = SESSION.cart.getTotalPrice()>
			<cfset LOCAL.requestData.CURRENCYCODE = SESSION.currency.code>
					
			<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="doHttppost" returnvariable="LOCAL.response">
				<cfinvokeargument name="requestData" value="#LOCAL.requestData#">
				<cfinvokeargument name="serverURL" value="#APPLICATION.paypal.serverURL#">
				<cfinvokeargument name="proxyName" value="#APPLICATION.paypal.proxyName#">
				<cfinvokeargument name="proxyPort" value="#APPLICATION.paypal.proxyPort#">
				<cfinvokeargument name="useProxy" value="#APPLICATION.paypal.useProxy#">
			</cfinvoke>
			
			<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="getNVPResponse" returnvariable="LOCAL.responseStruct">
				<cfinvokeargument name="nvpString" value="#URLDecode(LOCAL.response)#">
			</cfinvoke>
			
			<cfif LOCAL.responseStruct.Ack is "Success">
				<cfset LOCAL.currentOrderStatus = EntityLoad("order_status",{order = LOCAL.order, current = true},true) />
				<cfset LOCAL.currentOrderStatus.setCurrent(false) />
				<cfset LOCAL.currentOrderStatus.setEndDatetime(Now()) />
				<cfset EntitySave(LOCAL.currentOrderStatus) /> 
				
				<cfset LOCAL.orderStatusType = EntityLoad("order_status_type",{name = "paid"},true) />
				<cfset LOCAL.orderStatus = EntityNew("order_status") />
				<cfset LOCAL.orderStatus.setStartDatetime(Now()) />
				<cfset LOCAL.orderStatus.setCurrent(true) />
				<cfset LOCAL.orderStatus.setOrderStatusType(LOCAL.orderStatusType) />
				<cfset EntitySave(LOCAL.orderStatus) /> 
				<cfset LOCAL.order.addOrderStatus(LOCAL.orderStatus) />
				
				<cfset LOCAL.orderTransactionType = EntityLoad("order_transaction_type",{name="purchase"},true) />
				<cfset LOCAL.orderTransaction = EntityNew("order_transaction") />
				<cfset LOCAL.orderTransaction.setOrderTransactionType(LOCAL.orderTransactionType) />
				<cfset LOCAL.orderTransaction.setTransactionId(LOCAL.responseStruct.transactionId) />
				<cfset EntitySave(LOCAL.orderTransaction) />
				<cfset LOCAL.order.addOrderTransaction(LOCAL.orderTransaction) />
				<cfset LOCAL.order.setIsComplete(true) />
				<cfset EntitySave(LOCAL.order) />
				
				<cfset StructDelete(SESSION,"order") />
				
				<cfset LOCAL.trackingRecords = _getTrackingRecords(trackingRecordType = "shopping cart") />
				<cfloop array="#LOCAL.trackingRecords#" index="LOCAL.record">
					<cfset EntityDelete(LOCAL.record) />
				</cfloop>
				
				<cflocation url="#APPLICATION.absoluteUrlWeb#checkout/checkout_thankyou.cfm" addToken="false" />
			<cfelse>
				<cfdump var="#LOCAL.responseStruct#" abort>
				<!---
				<cfset APPLICATION.utilsSupport.createAnonymousConv(subject = "place order error",
																	content = "error: token=#URL.token#, payerId=#URL.payerId#") />
															
				<cfset logFile = "place_order_failed" & DateFormat(now(), 'yyyymmdd') & ".log" />
				<cfinvoke component="#APPLICATION.db_cfc_path#cfc.logger" method="init" returnvariable="logger">
					<cfinvokeargument name="logFile" value="#APPLICATION.log_path & logFile#">
				</cfinvoke>
				<cfset function = "order express payment failed" />
				<cfset logger.addlog(function, "token=#URL.token#") />
				--->
			</cfif>
			
			<!---
			<cfset replace_struct = StructNew() />
			<cfset replace_struct.first_name = SESSION.new_order.shipping_address.first_name />
			<cfset replace_struct.last_name = SESSION.new_order.shipping_address.last_name />
			
			<cfset replace_struct.shipping_method_name = SESSION.new_order.shipping_method_name />
			<cfset replace_struct.currency_code = SESSION.currency.code />
			
			<cfset replace_struct.track_number = SESSION.new_order.order_track_number />
			<cfset replace_struct.items = "" />
			<cfloop from="1" to="#ArrayLen(SESSION.new_order.items.item_array)#" index="current_i">
					<cfset replace_struct.items = replace_struct.items & "
		#current_i#. #SESSION.new_order.items.item_array[current_i].name_display#      $#cal_price(SESSION.new_order.items.item_array[current_i].price)# x #SESSION.new_order.items.item_array[current_i].quantity#      $#cal_price(SESSION.new_order.items.item_array[current_i].item_total)##chr(13)##chr(10)#" />
			</cfloop>
			
			<cfset replace_struct.subtotal = cal_price(SESSION.new_order.items.sub_total_amount) />
			<cfset replace_struct.shipping_amount = cal_price(SESSION.new_order.items.shipping_amount) />
			<cfset replace_struct.tax_amount = cal_price(SESSION.new_order.items.tax_amount) />
			<cfset replace_struct.total = cal_price(SESSION.new_order.items.sub_total_amount) + cal_price(SESSION.new_order.items.shipping_amount) + cal_price(SESSION.new_order.items.tax_amount) />
			
			<cfset replace_struct.shipping_first_name = SESSION.new_order.shipping_address.first_name />
			<cfset replace_struct.shipping_last_name = SESSION.new_order.shipping_address.last_name />
			<cfset replace_struct.shipping_street = SESSION.new_order.shipping_address.street />
			<cfset replace_struct.shipping_city = SESSION.new_order.shipping_address.city />
			<cfset replace_struct.shipping_province = SESSION.new_order.shipping_address.province_name />
			<cfset replace_struct.shipping_country = SESSION.new_order.shipping_address.country_name />
			<cfset replace_struct.shipping_postal_code = SESSION.new_order.shipping_address.postal_code />
			
			<cfset replace_struct.billing_first_name = SESSION.new_order.billing_address.first_name />
			<cfset replace_struct.billing_last_name = SESSION.new_order.billing_address.last_name />
			<cfset replace_struct.billing_street = SESSION.new_order.billing_address.street />
			<cfset replace_struct.billing_city = SESSION.new_order.billing_address.city />
			<cfset replace_struct.billing_province = SESSION.new_order.billing_address.province_name />
			<cfset replace_struct.billing_country = SESSION.new_order.billing_address.country_name />
			<cfset replace_struct.billing_postal_code = SESSION.new_order.billing_address.postal_code />
				
			<cfinvoke component="#APPLICATION.db_cfc_path#cfc.email" method="sendEmail">
				<cfinvokeargument name="from_email" value="#APPLICATION.customer_service_email#">
				<cfinvokeargument name="to_email" value="#SESSION.new_order.contact.email#">
				<cfinvokeargument name="email_content_name" value="order confirmation">
				<cfinvokeargument name="replace_struct" value="#replace_struct#">
			</cfinvoke>	

			<cfinvoke component="#APPLICATION.db_cfc_path#cfc.email" method="sendDirectEmail">
				<cfinvokeargument name="from_email" value="#APPLICATION.customer_service_email#">
				<cfinvokeargument name="to_email" value="#APPLICATION.customer_service_email#">
				<cfinvokeargument name="email_subject" value="New Order">
				<cfinvokeargument name="email_content" value="#APPLICATION.https_root_url#bg/index.cfm?content=order_maint&submited_order_id=#SESSION.new_order.order_id#">
				<cfinvokeargument name="email_type" value="html">
			</cfinvoke>	
			--->
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"place_order")>
			<cfset SESSION.cart.save() />
			<cfset LOCAL.redirectUrl = _sendPayPalRequest().redirectUrl />
		</cfif>
		
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
		<cfset LOCAL.requestData.Email = SESSION.cart.getCustomer().email>
		<cfset LOCAL.requestData.SHIPTONAME = SESSION.cart.getCustomer().fullName>
		<cfset LOCAL.requestData.SHIPTOSTREET = SESSION.cart.getShippingAddress().street>
		<cfset LOCAL.requestData.SHIPTOCITY = SESSION.cart.getShippingAddress().city>
		<cfset LOCAL.requestData.SHIPTOSTATE = SESSION.cart.getBillingAddress().provinceCode>
		<cfset LOCAL.requestData.SHIPTOCOUNTRYCODE = SESSION.cart.getBillingAddress().countryCode>
		<cfset LOCAL.requestData.CURRENCYCODE = SESSION.currency.code>
		<cfset LOCAL.requestData.SHIPTOZIP = SESSION.cart.getShippingAddress().postalCode>
		<cfset LOCAL.requestData.SHIPTOPHONENUM = SESSION.cart.getShippingAddress().phone>
		
		<cfloop from="1" to="#ArrayLen(SESSION.cart.getProductArray())#" index="LOCAL.i">
			<cfset LOCAL.product = EntityLoadByPK("product",SESSION.cart.getProductArray()[LOCAL.i].productId) />
			
			<cfset l_name = LOCAL.product.getDisplayNameMV()>
			
			<cfset l_amt = SESSION.cart.getProductArray()[LOCAL.i].singlePrice>
			<cfset l_qty = SESSION.cart.getProductArray()[LOCAL.i].count>
			<cfset l_number = SESSION.cart.getProductArray()[LOCAL.i].productId>
			<cfset StructInsert(LOCAL.requestData,"L_NAME#LOCAL.i-1#",l_name)>
			<cfset StructInsert(LOCAL.requestData,"L_AMT#LOCAL.i-1#",l_amt)>
			<cfset StructInsert(LOCAL.requestData,"L_QTY#LOCAL.i-1#",l_qty)>
			<cfset StructInsert(LOCAL.requestData,"L_NUMBER#LOCAL.i-1#",l_number)>
		</cfloop>
		<cfset LOCAL.requestData.ITEMAMT = SESSION.cart.getSubTotalPrice()>
		<cfset LOCAL.requestData.SHIPPINGAMT = SESSION.cart.getTotalShippingFee()>
		<cfset LOCAL.requestData.TAXAMT = SESSION.cart.getTotalTax()>
		<cfset LOCAL.requestData.AMT = SESSION.cart.getTotalPrice()>
		<cfset LOCAL.requestData.CancelURL = "#APPLICATION.urlHttpsWeb#checkout/checkout_confirmation.cfm" >
		<cfset LOCAL.requestData.ReturnURL = "#APPLICATION.urlHttpsWeb#checkout/checkout_confirmation.cfm">

		<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="doHttppost" returnvariable="LOCAL.response">
			<cfinvokeargument name="requestData" value="#LOCAL.requestData#">
			<cfinvokeargument name="serverURL" value="#APPLICATION.paypal.serverURL#">
			<cfinvokeargument name="proxyName" value="#APPLICATION.paypal.proxyName#">
			<cfinvokeargument name="proxyPort" value="#APPLICATION.paypal.proxyPort#">
			<cfinvokeargument name="useProxy" value="#APPLICATION.paypal.useProxy#">
		</cfinvoke>							
			
		<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="getNVPResponse" returnvariable="LOCAL.responseStruct">
			<cfinvokeargument name="nvpString" value="#URLDecode(LOCAL.response)#">
		</cfinvoke>	

		<cfif LOCAL.responseStruct.Ack EQ "Success">
			<cfset LOCAL.redirectUrl = #APPLICATION.paypal.PayPalURL# & LOCAL.responseStruct.token>
		<cfelse>
			<cfdump var="#LOCAL.responseStruct#" abort>
			<!---
			<cfset APPLICATION.utilsSupport.createAnonymousConv(subject = "http post error",
																content = "error: #LOCAL.responseStruct.L_LONGMESSAGE0#") />

			<cfset SESSION.cart.transactionFailedReason = LOCAL.responseStruct.L_LONGMESSAGE0 />	
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm" />
			--->
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>