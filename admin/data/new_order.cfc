<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
	
		<cfif StructKeyExists(FORM,"submit_order") AND Trim(FORM.first_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid first name.") />	
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = _setRedirectURL() />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.order = EntityLoadByPK("order", FORM.id) /> 
		<cfelse>
			<cfset LOCAL.order = EntityNew("order") /> 
			<cfset LOCAL.newOrderTrackingNumber = "OR#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"hhmmss")#" />
		</cfif>
		
		<cfif StructKeyExists(FORM,"submit_order")>
			<cfset LOCAL.order.setFirstName(Trim(FORM.first_name)) />
			<cfset LOCAL.order.setMiddleName(Trim(FORM.middle_name)) />
			<cfset LOCAL.order.setLastName(Trim(FORM.last_name)) />
			<cfset LOCAL.order.setPhone(Trim(FORM.phone)) />
			<cfset LOCAL.order.setDescription(Trim(FORM.description)) />
			<cfif IsNumeric(FORM.subtotal_amount)>
				<cfset LOCAL.order.setSubtotalAmount(FORM.subtotal_amount) />
			</cfif>
			<cfif IsNumeric(FORM.shipping_amount)>
				<cfset LOCAL.order.setShippingAmount(FORM.shipping_amount) />
			</cfif>
			<cfif IsNumeric(FORM.tax_amount)>
				<cfset LOCAL.order.setTaxAmount(FORM.tax_amount) />
			</cfif>
			<cfif IsNumeric(FORM.total_amount)>
				<cfset LOCAL.order.setTotalAmount(FORM.total_amount) />
			</cfif>
			
			<cfset LOCAL.order.setShippingStreet(Trim(FORM.shipping_street)) />
			<cfset LOCAL.order.setShippingCity(Trim(FORM.shipping_city)) />
			<cfset LOCAL.order.setShippingPostalCode(Trim(FORM.shipping_postal_code)) />
			
			<cfif FORM.shipping_province_id NEQ "">
				<cfset LOCAL.order.setShippingProvince(EntityLoadByPK("province",FORM.shipping_province_id)) />
			</cfif>
			<cfif FORM.shipping_country_id NEQ "">
				<cfset LOCAL.order.setShippingCountry(EntityLoadByPK("country",FORM.shipping_country_id)) />
			</cfif>
		
			<cfset LOCAL.order.setBillingStreet(Trim(FORM.billing_street)) />
			<cfset LOCAL.order.setBillingCity(Trim(FORM.billing_city)) />
			<cfset LOCAL.order.setBillingPostalCode(Trim(FORM.billing_postal_code)) />
			
			<cfif FORM.billing_province_id NEQ "">
				<cfset LOCAL.order.setBillingProvince(EntityLoadByPK("province",FORM.billing_province_id)) />
			</cfif>
			<cfif FORM.billing_country_id NEQ "">
				<cfset LOCAL.order.setBillingCountry(EntityLoadByPK("country",FORM.billing_country_id)) />
			</cfif>
			
			<cfif FORM.payment_method_id NEQ "">
				<cfset LOCAL.order.setPaymentMethod(EntityLoadByPK("payment_method",FORM.payment_method_id)) />
			</cfif>
			
			<cfif FORM.coupon_code NEQ "">
				<cfset LOCAL.order.setCoupon(EntityLoad("coupon",{couponCode = FORM.coupon_code}, true)) />
			</cfif>
						
			<cfset LOCAL.newStatusType = EntityLoad("order_status_type",{displayName = "placed"},true) />
			<cfset LOCAL.newStatus = EntityNew("order_status") />
			<cfset LOCAL.newStatus.setStartDatetime(Now()) />
			<cfset LOCAL.newStatus.setCurrent(true) />
			<cfset LOCAL.newStatus.setComments(Trim(FORM.comments)) />
			<cfset LOCAL.newStatus.setStatusType(LOCAL.newStatusType) />
			<cfset EntitySave(LOCAL.newStatus) /> 
			
			<cfset LOCAL.order.addStatus(LOCAL.newStatus) />
		
			<cfset LOCAL.order.setSubtotalAmount(0) />
			<cfset LOCAL.order.setShippingAmount(0) />
			<cfset LOCAL.order.setTaxAmount(0) />
			<cfset LOCAL.order.setTotalAmount(0) />
			
			<cfset EntitySave(LOCAL.order) />
			
			<cfif StructKeyExists(LOCAL,"newOrderTrackingNumber")>
				<cfset LOCAL.order.setOrderTrackingNumber("#LOCAL.newOrderTrackingNumber##LOCAL.order.getOrderId()#") />
				<cfset EntitySave(LOCAL.order) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Order has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?id=#LOCAL.order.getOrderId()#" />
			
		<cfelseif StructKeyExists(FORM,"add_new_product")>
		
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.new_order_product_id) />
				
			<cfset LOCAL.orderProduct = EntityNew("order_product") />
			<cfset LOCAL.orderProduct.setDisplayName(LOCAL.product.getDisplayName()) />
			<cfset LOCAL.orderProduct.setPrice(LOCAL.product.getPrice()) />
			<cfset LOCAL.orderProduct.setQuantity(FORM.new_order_product_quantity) />
			<cfset LOCAL.orderProduct.setShippingMethod(EntityLoadByPK("shipping_method",FORM.new_order_product_shipping_method_id)) />
			
			<cfset LOCAL.newProductStatusType = EntityLoad("order_product_status_type",{displayName = "added"},true) />
			<cfset LOCAL.newProductStatus = EntityNew("order_product_status") />
			<cfset LOCAL.newProductStatus.setStartDatetime(Now()) />
			<cfset LOCAL.newProductStatus.setCurrent(true) />
			<cfset LOCAL.newProductStatus.setComments(Trim(FORM.new_order_product_comments)) />
			<cfset LOCAL.newProductStatus.setStatusType(LOCAL.newStatusType) />
			<cfset EntitySave(LOCAL.newProductStatus) /> 
			
			<cfset LOCAL.orderProduct.addStatus(LOCAL.newProductStatus) />
			
			<cfset EntitySave(LOCAL.orderProduct) /> 
			
			<cfset LOCAL.order.addProduct(LOCAL.orderProduct) />
			
			<cfset LOCAL.order.setSubtotalAmount(LOCAL.orderProduct.getPrice() * FORM.new_order_product_quantity) />
			<cfset LOCAL.order.setShippingAmount(0) />
			<cfset LOCAL.order.setTaxAmount(0) />
			<cfset LOCAL.order.setTotalAmount(0) />
			
			<cfset EntitySave(LOCAL.order) /> 
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.order.getOrderId()#" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.paymentMethods = EntityLoad("payment_method") />
		<cfset LOCAL.pageData.shippingMethods = EntityLoad("shipping_method") />
		<cfset LOCAL.pageData.title = "New Order | #APPLICATION.applicationName#" />
		
		<cfif StructKeyExists(URL,"id")>
			<cfset LOCAL.pageData.order = EntityLoadByPK("order",URL.id) />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
				<cfif NOT StructKeyExists(FORM,"same_as_shipping_address")>
					<cfset LOCAL.pageData.formData.same_as_shipping_address = "" />
				</cfif>
			<cfelse>
				<cfset LOCAL.pageData.formData.order_id = LOCAL.pageData.order.getOrderId() />
				<cfset LOCAL.pageData.formData.first_name = isNull(LOCAL.pageData.order.getFirstName())?"":LOCAL.pageData.order.getFirstName() />
				<cfset LOCAL.pageData.formData.middle_name = isNull(LOCAL.pageData.order.getMiddleName())?"":LOCAL.pageData.order.getMiddleName() />
				<cfset LOCAL.pageData.formData.last_name = isNull(LOCAL.pageData.order.getLastName())?"":LOCAL.pageData.order.getLastName() />
				<cfset LOCAL.pageData.formData.phone = isNull(LOCAL.pageData.order.getPhone())?"":LOCAL.pageData.order.getPhone() />
				<cfset LOCAL.pageData.formData.coupon_code = isNull(LOCAL.pageData.order.getCoupon())?"":LOCAL.pageData.order.getCoupon().getCouponCode() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.order.getDescription())?"":LOCAL.pageData.order.getDescription() />
				<cfset LOCAL.pageData.formData.same_as_shipping_address = "" />
				
				<cfset LOCAL.pageData.formData.shipping_company = isNull(LOCAL.pageData.order.getShippingCompany())?"":LOCAL.pageData.order.getShippingCompany() />
				<cfset LOCAL.pageData.formData.shipping_street = isNull(LOCAL.pageData.order.getShippingStreet())?"":LOCAL.pageData.order.getShippingStreet() />
				<cfset LOCAL.pageData.formData.shipping_city = isNull(LOCAL.pageData.order.getShippingCity())?"":LOCAL.pageData.order.getShippingCity() />
				<cfset LOCAL.pageData.formData.shipping_province_id = isNull(LOCAL.pageData.order.getShippingProvince())?"":LOCAL.pageData.order.getShippingProvince().getProvinceId() />
				<cfset LOCAL.pageData.formData.shipping_postal_code = isNull(LOCAL.pageData.order.getShippingPostalCode())?"":LOCAL.pageData.order.getShippingPostalCode() />
				<cfset LOCAL.pageData.formData.shipping_country_id = isNull(LOCAL.pageData.order.getShippingCountry())?"":LOCAL.pageData.order.getShippingCountry().getCountryId() />
				
				<cfset LOCAL.pageData.formData.billing_company = isNull(LOCAL.pageData.order.getBillingCompany())?"":LOCAL.pageData.order.getBillingCompany() />
				<cfset LOCAL.pageData.formData.billing_street = isNull(LOCAL.pageData.order.getBillingStreet())?"":LOCAL.pageData.order.getBillingStreet() />
				<cfset LOCAL.pageData.formData.billing_city = isNull(LOCAL.pageData.order.getBillingCity())?"":LOCAL.pageData.order.getBillingCity() />
				<cfset LOCAL.pageData.formData.billing_province_id = isNull(LOCAL.pageData.order.getBillingProvince())?"":LOCAL.pageData.order.getBillingProvince().getProvinceId() />
				<cfset LOCAL.pageData.formData.billing_postal_code = isNull(LOCAL.pageData.order.getBillingPostalCode())?"":LOCAL.pageData.order.getBillingPostalCode() />
				<cfset LOCAL.pageData.formData.billing_country_id = isNull(LOCAL.pageData.order.getBillingCountry())?"":LOCAL.pageData.order.getBillingCountry().getCountryId() />
			
				<cfset LOCAL.pageData.formData.subtotal_amount = DollarFormat(LOCAL.pageData.order.getSubtotalAmount()) />
				<cfset LOCAL.pageData.formData.shipping_amount = DollarFormat(LOCAL.pageData.order.getShippingAmount()) />
				<cfset LOCAL.pageData.formData.tax_amount = DollarFormat(LOCAL.pageData.order.getTaxAmount()) />
				<cfset LOCAL.pageData.formData.total_amount = DollarFormat(LOCAL.pageData.order.getTotalAmount()) />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.formData.order_id = "" />
			<cfset LOCAL.pageData.formData.first_name = "" />
			<cfset LOCAL.pageData.formData.middle_name = "" />
			<cfset LOCAL.pageData.formData.last_name = "" />
			<cfset LOCAL.pageData.formData.phone = "" />
			<cfset LOCAL.pageData.formData.coupon_code = "" />
			<cfset LOCAL.pageData.formData.description = "" />
			<cfset LOCAL.pageData.formData.same_as_shipping_address = "" />
			
			<cfset LOCAL.pageData.formData.shipping_company = "" />
			<cfset LOCAL.pageData.formData.shipping_street = "" />
			<cfset LOCAL.pageData.formData.shipping_city = "" />
			<cfset LOCAL.pageData.formData.shipping_province_id = "" />
			<cfset LOCAL.pageData.formData.shipping_postal_code = "" />
			<cfset LOCAL.pageData.formData.shipping_country_id = "" />
			
			<cfset LOCAL.pageData.formData.billing_company = "" />
			<cfset LOCAL.pageData.formData.billing_street = "" />
			<cfset LOCAL.pageData.formData.billing_city = "" />
			<cfset LOCAL.pageData.formData.billing_province_id = "" />
			<cfset LOCAL.pageData.formData.billing_postal_code = "" />
			<cfset LOCAL.pageData.formData.billing_country_id = "" />
			<cfset LOCAL.pageData.formData.subtotal_amount = "-" />
			<cfset LOCAL.pageData.formData.shipping_amount = "-" />
			<cfset LOCAL.pageData.formData.tax_amount = "-" />
			<cfset LOCAL.pageData.formData.total_amount = "-" />
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>