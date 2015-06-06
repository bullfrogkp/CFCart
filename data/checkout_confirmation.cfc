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
		
		<cfif StructKeyExists(URL,"token") AND StructKeyExists(URL,"payerId")>
		
			<cfset LOCAL.orderLog = entityLoadByPK("order_log",SESSION.order.orderLogId) />
			<cfset LOCAL.orderLog.setToken(URL.token) />
			<cfset EntitySave(LOCAL.orderLog) />
			
			<cfset LOCAL.requestData = StructNew()>
			<cfset LOCAL.requestData.METHOD = "DoExpressCheckoutPayment">		
			<cfset LOCAL.requestData.USER = APPLICATION.paypal_info.APIUserName>
			<cfset LOCAL.requestData.PWD = APPLICATION.paypal_info.APIPassword>
			<cfset LOCAL.requestData.SIGNATURE = APPLICATION.paypal_info.APISignature>
			<cfset LOCAL.requestData.VERSION = APPLICATION.paypal_info.version>
			<cfset LOCAL.requestData.TOKEN = URL.token>
			<cfset LOCAL.requestData.PAYERID = URL.payerId>
			<cfset LOCAL.requestData.PAYMENTACTION = "sale">
			<cfset LOCAL.requestData.AMT = SESSION.order.totalPrice>
			<cfset LOCAL.requestData.CURRENCYCODE = SESSION.currency.code>
					
			<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="doHttppost" returnvariable="LOCAL.response">
				<cfinvokeargument name="requestData" value="#LOCAL.requestData#">
				<cfinvokeargument name="serverURL" value="#APPLICATION.paypal_info.serverURL#">
				<cfinvokeargument name="proxyName" value="#APPLICATION.paypal_info.proxyName#">
				<cfinvokeargument name="proxyPort" value="#APPLICATION.paypal_info.proxyPort#">
				<cfinvokeargument name="useProxy" value="#APPLICATION.paypal_info.useProxy#">
			</cfinvoke>
			
			<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="getNVPResponse" returnvariable="LOCAL.responseStruct">
				<cfinvokeargument name="nvpString" value="#URLDecode(LOCAL.response)#">
			</cfinvoke>
			
			<cfif LOCAL.responseStruct.Ack is "Success">
				<cfset _processOrder() />
				
				<cfset LOCAL.orderTransactionType = EntityLoad("order_transaction_type",{name="purchase"},true) />
				<cfset LOCAL.orderTransaction = EntityNew("order_transaction") />
				<cfset LOCAL.orderTransaction.setTransactionType(LOCAL.orderTransactionType) />
				<cfset LOCAL.orderTransaction.setTransactionId(LOCAL.responseStruct.transactionid) />
				
				<cfinvoke component="#APPLICATION.db_cfc_path#db.order_transactions" method="addOrderTransaction" returnvariable="order_transaction_id">
					<cfinvokeargument name="transaction_id" value="#LOCAL.responseStruct.transactionid#">
					<cfinvokeargument name="order_id" value="#SESSION.new_order.order_id#">
					<cfinvokeargument name="order_transaction_type_name" value="purchase">
					<cfinvokeargument name="user" value="#SESSION.user#">
				</cfinvoke>

			<cfelse>
				<cfset APPLICATION.utilsSupport.createAnonymousConv(subject = "place order error",
																	content = "error: token=#URL.token#, payerId=#URL.payerId#") />
															
				<cfset logFile = "place_order_failed" & DateFormat(now(), 'yyyymmdd') & ".log" />
				<cfinvoke component="#APPLICATION.db_cfc_path#cfc.logger" method="init" returnvariable="logger">
					<cfinvokeargument name="logFile" value="#APPLICATION.log_path & logFile#">
				</cfinvoke>
				<cfset function = "order express payment failed" />
				<cfset logger.addlog(function, "token=#URL.token#") />
			</cfif>
			
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
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset SESSION.order.orderLogId = _addOrderLog() />
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
		<cfset LOCAL.requestData.ReturnURL = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm">

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
			<cfset LOCAL.redirectUrl = #APPLICATION.paypal.PayPalURL# & LOCAL.responseStruct.TOKEN>
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
	
	<cffunction name="_addOrderLog" access="private" output="false" returnType="numeric">
	</cffunction>
	
	<cffunction name="_processOrder" access="private" output="false" returnType="void">
		<cfset LOCAL.order = EntityNew("order") /> 
		<cfset LOCAL.order.setOrderTrackingNumber("OR#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"hhmmss")##LOCAL.order.getOrderId()#") />
		<cfset LOCAL.order.setIsDeleted(false) />
		
		<cfif SESSION.order.isExistingCustomer EQ false>
			<cfset LOCAL.customer = EntityNew("customer") />
			<cfset LOCAL.customer.setFirstName(SESSION.order.customer.firstName) />
			<cfset LOCAL.customer.setMiddleName(SESSION.order.customer.firstName) />
			<cfset LOCAL.customer.setLastName(SESSION.order.customer.lastName) />
			<cfset LOCAL.customer.setEmail(SESSION.order.customer.email) />
			<cfset LOCAL.customer.setPhone(SESSION.order.customer.phone) />
			<cfset LOCAL.customer.setIsEnabled(false) />
			<cfset LOCAL.customer.setIsDeleted(false) />
			<cfset LOCAL.customer.setCreatedDatetime(Now()) />
			<cfset LOCAL.customer.setCreatedUser(SESSION.user.userName) />
			<cfset LOCAL.customer.setCustomerGroup(EntityLoad("customer_group",{isDefault=true},true)) />
			<cfset EntitySave(LOCAL.customer) />
		<cfelse>
			<cfset LOCAL.customer = EntityLoadByPK("customer",SESSION.order.customer.customerId) />
		</cfif>
			
		<cfif SESSION.order.shippingAddress.useExistingAddress EQ false>
			<cfset LOCAL.shippingAddress = EntityNew("address") />
			<cfset LOCAL.shippingAddress.setCompany(SESSION.order.shippingAddress.company) />
			<cfset LOCAL.shippingAddress.setFirstName(SESSION.order.shippingAddress.firstName) />
			<cfset LOCAL.shippingAddress.setMiddleName(SESSION.order.shippingAddress.firstName) />
			<cfset LOCAL.shippingAddress.setLastName(SESSION.order.shippingAddress.lastName) />
			<cfset LOCAL.shippingAddress.setPhone(SESSION.order.shippingAddress.phone) />
			<cfset LOCAL.shippingAddress.setUnit(SESSION.order.shippingAddress.unit) />
			<cfset LOCAL.shippingAddress.setStreet(SESSION.order.shippingAddress.street) />
			<cfset LOCAL.shippingAddress.setCity(SESSION.order.shippingAddress.city) />
			<cfset LOCAL.shippingAddress.setProvince(EntityLoadByPK("province",SESSION.order.shippingAddress.provinceId)) />
			<cfset LOCAL.shippingAddress.setCountry(EntityLoadByPK("country",SESSION.order.shippingAddress.countryId)) />
			<cfset LOCAL.shippingAddress.setPostalCode(SESSION.order.shippingAddress.postalCode) />
			<cfset LOCAL.shippingAddress.setCreatedDatetime(Now()) />
			<cfset LOCAL.shippingAddress.setCreatedUser(SESSION.user.userName) />
			
			<cfset EntitySave(LOCAL.shippingAddress) />
			<cfset LOCAL.customer.addAddress(LOCAL.shippingAddress) />
			<cfset EntitySave(LOCAL.customer) />
		<cfelse>
			<cfset LOCAL.shippingAddress = EntityLoadByPK("address",SESSION.order.shippingAddress.addressId) />
		</cfif>	
			
		<cfset LOCAL.order.setShippingFirstName(LOCAL.shippingAddress.getFirstName()) />
		<cfset LOCAL.order.setShippingMiddleName(LOCAL.shippingAddress.getMiddleName()) />
		<cfset LOCAL.order.setShippingLastName(LOCAL.shippingAddress.getLastName()) />
		<cfset LOCAL.order.setShippingCompany(LOCAL.shippingAddress.getCompany()) />
		<cfset LOCAL.order.setShippingUnit(LOCAL.shippingAddress.getUnit()) />
		<cfset LOCAL.order.setShippingStreet(LOCAL.shippingAddress.getStreet()) />
		<cfset LOCAL.order.setShippingCity(LOCAL.shippingAddress.getCity()) />
		<cfset LOCAL.order.setShippingProvince(LOCAL.shippingAddress.getProvince()) />
		<cfset LOCAL.order.setShippingCountry(LOCAL.shippingAddress.getCountry()) />
		<cfset LOCAL.order.setShippingPostalCode(LOCAL.shippingAddress.getPostalCode()) />
		
		<cfif SESSION.order.sameAddress EQ true>
		
			<cfset LOCAL.order.setBillingFirstName(LOCAL.shippingAddress.getFirstName()) />
			<cfset LOCAL.order.setBillingMiddleName(LOCAL.shippingAddress.getMiddleName()) />
			<cfset LOCAL.order.setBillingLastName(LOCAL.shippingAddress.getLastName()) />
			<cfset LOCAL.order.setBillingCompany(LOCAL.shippingAddress.getCompany()) />
			<cfset LOCAL.order.setBillingUnit(LOCAL.shippingAddress.getUnit()) />
			<cfset LOCAL.order.setBillingStreet(LOCAL.shippingAddress.getStreet()) />
			<cfset LOCAL.order.setBillingCity(LOCAL.shippingAddress.getCity()) />
			<cfset LOCAL.order.setBillingProvince(LOCAL.shippingAddress.getProvince()) />
			<cfset LOCAL.order.setBillingCountry(LOCAL.shippingAddress.getCountry()) />
			<cfset LOCAL.order.setBillingPostalCode(LOCAL.shippingAddress.getPostalCode()) />
			
		<cfelse>
		
			<cfif SESSION.order.billingAddress.useExistingAddress EQ false>
				<cfset LOCAL.billingAddress = EntityNew("address") />
				<cfset LOCAL.billingAddress.setCompany(SESSION.order.billingAddress.company) />
				<cfset LOCAL.billingAddress.setFirstName(SESSION.order.billingAddress.firstName) />
				<cfset LOCAL.billingAddress.setMiddleName(SESSION.order.billingAddress.firstName) />
				<cfset LOCAL.billingAddress.setLastName(SESSION.order.billingAddress.lastName) />
				<cfset LOCAL.billingAddress.setPhone(SESSION.order.billingAddress.phone) />
				<cfset LOCAL.billingAddress.setUnit(SESSION.order.billingAddress.unit) />
				<cfset LOCAL.billingAddress.setStreet(SESSION.order.billingAddress.street) />
				<cfset LOCAL.billingAddress.setCity(SESSION.order.billingAddress.city) />
				<cfset LOCAL.billingAddress.setProvince(EntityLoadByPK("province",SESSION.order.billingAddress.provinceId)) />
				<cfset LOCAL.billingAddress.setCountry(EntityLoadByPK("country",SESSION.order.billingAddress.countryId)) />
				<cfset LOCAL.billingAddress.setPostalCode(SESSION.order.billingAddress.postalCode) />
				<cfset LOCAL.billingAddress.setCreatedDatetime(Now()) />
				<cfset LOCAL.billingAddress.setCreatedUser(SESSION.user.userName) />
				
				<cfset EntitySave(LOCAL.billingAddress) />
				<cfset LOCAL.customer.addAddress(LOCAL.billingAddress) />
				<cfset EntitySave(LOCAL.customer) />
			<cfelse>
				<cfset LOCAL.billingAddress = EntityLoadByPK("address",SESSION.order.billingAddress.addressId) />
			</cfif>	
		
			<cfset LOCAL.order.setBillingFirstName(LOCAL.shippingAddress.getFirstName()) />
			<cfset LOCAL.order.setBillingMiddleName(LOCAL.shippingAddress.getMiddleName()) />
			<cfset LOCAL.order.setBillingLastName(LOCAL.shippingAddress.getLastName()) />
			<cfset LOCAL.order.setBillingCompany(LOCAL.shippingAddress.getCompany()) />
			<cfset LOCAL.order.setBillingUnit(LOCAL.shippingAddress.getUnit()) />
			<cfset LOCAL.order.setBillingStreet(LOCAL.shippingAddress.getStreet()) />
			<cfset LOCAL.order.setBillingCity(LOCAL.shippingAddress.getCity()) />
			<cfset LOCAL.order.setBillingProvince(LOCAL.shippingAddress.getProvince()) />
			<cfset LOCAL.order.setBillingCountry(LOCAL.shippingAddress.getCountry()) />
			<cfset LOCAL.order.setBillingPostalCode(LOCAL.shippingAddress.getPostalCode()) />
		</cfif>
		
		<cfset LOCAL.order.setCreatedDatetime(Now()) />
		<cfset LOCAL.order.setCreatedUser(SESSION.user.userName) />
		
		<cfset LOCAL.order.setPaymentMethod(EntityLoadByPK("payment_method",1)) />
		
		<cfif IsNumeric(SESSION.order.couponId)>
			<cfset LOCAL.order.addCoupon(EntityLoadByPK("coupon",SESSION.order.couponId)) />
		</cfif>
					
		<cfset LOCAL.orderStatusType = EntityLoad("order_status_type",{displayName = "placed"},true) />
		<cfset LOCAL.orderStatus = EntityNew("order_status") />
		<cfset LOCAL.orderStatus.setStartDatetime(Now()) />
		<cfset LOCAL.orderStatus.setCurrent(true) />
		<cfset LOCAL.orderStatus.setOrderStatusType(LOCAL.orderStatusType) />
		<cfset EntitySave(LOCAL.orderStatus) /> 
		
		<cfset LOCAL.order.addOrderStatus(LOCAL.orderStatus) />
		<cfset EntitySave(LOCAL.order) />
		
		<cfset LOCAL.customer.addOrder(LOCAL.order) />
		<cfset EntitySave(LOCAL.customer) />
		
		<cfloop array="#SESSION.order.productArray#" index="item">
			<cfset LOCAL.product = EntityLoadByPK("product",item.productId) />
			<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela",item.productShippingMethodRelaId) />
						
			<cfset LOCAL.orderProduct = EntityNew("order_product") />
			<cfset LOCAL.orderProduct.setPrice(item.singlePrice) />
			<cfset LOCAL.orderProduct.setTaxCategoryName(LOCAL.product.getTaxCategory().getDisplayName()) />
			<cfset LOCAL.orderProduct.setSubtotalAmount(item.totalPrice) />
			<cfset LOCAL.orderProduct.setTaxAmount(item.totalTax) />
			<cfset LOCAL.orderProduct.setShippingAmount(item.totalShippingFee) />
			<cfset LOCAL.orderProduct.setTotalAmount(item.totalPrice + item.totalTax + item.totalShippingFee) />
			<cfset LOCAL.orderProduct.setQuantity(item.count) />
			<cfif NOT IsNull(LOCAL.productShippingMethodRela.getShippingMethod().getShippingCarrier())>
				<cfset LOCAL.orderProduct.setShippingCarrierName(LOCAL.productShippingMethodRela.getShippingMethod().getShippingCarrier().getDisplayName()) />
			</cfif>
			<cfset LOCAL.orderProduct.setShippingMethodName(LOCAL.productShippingMethodRela.getShippingMethod().getDisplayName()) />
			<cfset LOCAL.orderProduct.setProduct(LOCAL.product) />
			<cfset LOCAL.orderProduct.setProductName(LOCAL.product.getDisplayName()) />
			<cfset LOCAL.orderProduct.setSku(LOCAL.product.getSku()) />
			<cfset LOCAL.orderProduct.setImageName(product.getDefaultImageLink(type='small')) />
			
			<cfset LOCAL.orderProductStatusType = EntityLoad("order_product_status_type",{displayName = "added"},true) />
			<cfset LOCAL.orderProductStatus = EntityNew("order_product_status") />
			<cfset LOCAL.orderProductStatus.setStartDatetime(Now()) />
			<cfset LOCAL.orderProductStatus.setCurrent(true) />
			<cfset LOCAL.orderProductStatus.setOrderProductStatusType(LOCAL.orderProductStatusType) />
			<cfset EntitySave(LOCAL.orderProductStatus) /> 
			
			<cfset LOCAL.orderProduct.addOrderProductStatus(LOCAL.orderProductStatus) />
			<cfset EntitySave(LOCAL.orderProduct) /> 
			<cfset LOCAL.order.addProduct(LOCAL.orderProduct) />
			<cfset EntitySave(LOCAL.order) /> 
		</cfloop>
		
		<!---
		<cfset StructDelete(SESSION,"order") />
		--->
	</cffunction>
</cfcomponent>