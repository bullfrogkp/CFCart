<cfcomponent extends="master">	
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
		
		<cfset LOCAL.order = EntityNew("order") /> 
		<cfset LOCAL.newOrderTrackingNumber = "OR#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"hhmmss")##LOCAL.order.getOrderId()#" />
		<cfset LOCAL.order.setOrderTrackingNumber(LOCAL.newOrderTrackingNumber) />
		<cfset LOCAL.order.setIsDeleted(false) />
		
		<cfif NOT IsNumeric(SESSION.user.customerId)>
			<cfset LOCAL.newCustomer = EntityNew("customer") />
			<cfset LOCAL.newCustomer.setFirstName(SESSION.order.billingAdress.firstName)) />
			<cfset LOCAL.newCustomer.setMiddleName(SESSION.order.billingAdress.firstName) />
			<cfset LOCAL.newCustomer.setLastName(SESSION.order.billingAdress.lastName) />
			<cfset LOCAL.newCustomer.setEmail(SESSION.order.email) />
			<cfset LOCAL.newCustomer.setPhone(SESSION.order.billingAdress.phone) />
			<cfset LOCAL.newCustomer.setIsEnabled(false) />
			<cfset LOCAL.newCustomer.setIsDeleted(false) />
			<cfset LOCAL.newCustomer.setCreatedDatetime(Now()) />
			<cfset LOCAL.newCustomer.setCreatedUser(SESSION.user.userName) />
			
			<cfset LOCAL.newCustomer.setCustomerGroup(EntityLoad("customer_group",{isDefault=true},true)) />
			
			<cfset LOCAL.newAddress = EntityNew("address") />
			<cfset LOCAL.newAddress.setUnit(SESSION.order.shippingAddress.unit)) />
			<cfset LOCAL.newAddress.setStreet(SESSION.order.shippingAddress.street) />
			<cfset LOCAL.newAddress.setCity(SESSION.order.shippingAddress.city)) />
			<cfset LOCAL.newAddress.setProvince(SESSION.order.shippingAddress.province) />
			<cfset LOCAL.newAddress.setCountry(SESSION.order.shippingAddress.country) />
			<cfset LOCAL.newAddress.setPostalCode(SESSION.order.shippingAddress.postalCode) />
			<cfset LOCAL.newAddress.setCreatedDatetime(Now()) />
			<cfset LOCAL.newAddress.setCreatedUser(SESSION.user.userName) />
			
			<cfset EntitySave(LOCAL.newAddress) />
			<cfset LOCAL.newCustomer.addAddress(LOCAL.newAddress) />
			
			<cfif SESSION.order.billingInfoIsDifferent EQ true>
				<cfset LOCAL.newAddress = EntityNew("address") />
				<cfset LOCAL.newAddress.setUnit(SESSION.order.billingAddress.unit)) />
				<cfset LOCAL.newAddress.setStreet(SESSION.order.billingAddress.street) />
				<cfset LOCAL.newAddress.setCity(SESSION.order.billingAddress.city)) />
				<cfset LOCAL.newAddress.setProvince(SESSION.order.billingAddress.province) />
				<cfset LOCAL.newAddress.setCountry(SESSION.order.billingAddress.country) />
				<cfset LOCAL.newAddress.setPostalCode(SESSION.order.billingAddress.postalCode) />
				<cfset LOCAL.newAddress.setCreatedDatetime(Now()) />
				<cfset LOCAL.newAddress.setCreatedUser(SESSION.user.userName) />
				
				<cfset EntitySave(LOCAL.newAddress) />
				<cfset LOCAL.newCustomer.addAddress(LOCAL.newAddress) />
			</cfif>
		</cfif>	
			
				
		<cfset LOCAL.order.setShippingCompany(SESSION.order.shippingAddress.province)) />
		<cfset LOCAL.order.setShippingUnit(SESSION.order.shippingAddress.unit) />
		<cfset LOCAL.order.setShippingStreet(SESSION.order.shippingAddress.street) />
		<cfset LOCAL.order.setShippingCity(SESSION.order.shippingAddress.city) />
		<cfset LOCAL.order.setShippingProvince(SESSION.order.shippingAddress.province) />
		<cfset LOCAL.order.setShippingCountry(SESSION.order.shippingAddress.country) />
		<cfset LOCAL.order.setShippingPostalCode(SESSION.order.shippingAddress.postalCode) />
				
		<cfset LOCAL.order.setBillingCompany(SESSION.order.billingAddress.province)) />
		<cfset LOCAL.order.setBillingUnit(SESSION.order.billingAddress.unit) />
		<cfset LOCAL.order.setBillingStreet(SESSION.order.billingAddress.street) />
		<cfset LOCAL.order.setBillingCity(SESSION.order.billingAddress.city) />
		<cfset LOCAL.order.setBillingProvince(SESSION.order.billingAddress.province) />
		<cfset LOCAL.order.setBillingCountry(SESSION.order.billingAddress.country) />
		<cfset LOCAL.order.setBillingPostalCode(SESSION.order.billingAddress.postalCode) />
		
		<cfset LOCAL.order.setCreatedDatetime(Now()) />
		<cfset LOCAL.order.setCreatedUser(SESSION.user.userName) />
		
		<!---
		<cfset LOCAL.order.setPaymentMethod(EntityLoadByPK("payment_method",FORM.payment_method_id)) />
		--->
		
		<cfif IsNumeric(SESSION.order.couponId)>
			<cfset LOCAL.order.addCoupon(EntityLoadByPK("coupon",SESSION.order.couponId)) />
		</cfif>
					
		<cfset LOCAL.newStatusType = EntityLoad("order_status_type",{displayName = "placed"},true) />
		<cfset LOCAL.newStatus = EntityNew("order_status") />
		<cfset LOCAL.newStatus.setStartDatetime(Now()) />
		<cfset LOCAL.newStatus.setCurrent(true) />
		<cfset LOCAL.newStatus.setOrderStatusType(LOCAL.newStatusType) />
		<cfset EntitySave(LOCAL.newStatus) /> 
		
		<cfset LOCAL.order.addOrderStatus(LOCAL.newStatus) />
		
		<cfset EntitySave(LOCAL.order) />
		
		<cfset LOCAL.newCustomer.addOrder(LOCAL.order) />
		<cfset EntitySave(LOCAL.newCustomer) />
		
		<cfloop array="#SESSION.order.productArray#" index="item">
			<cfset LOCAL.product = EntityLoadByPK("product",item.productId) />
			<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela",item.productShippingMethodRelaId) />
						
			<cfset LOCAL.orderProduct = EntityNew("order_product") />
			<cfset LOCAL.orderProduct.setPrice(item.price) />
			<cfset LOCAL.orderProduct.setTaxCategoryName(LOCAL.product.getTaxCategory().getDisplayName()) />
			<cfset LOCAL.orderProduct.setSubtotalAmount(item.price * item.count) />
			<cfset LOCAL.orderProduct.setTaxAmount(item.tax) />
			<cfset LOCAL.orderProduct.setShippingAmount(item.shippingFee) />
			<cfset LOCAL.orderProduct.setQuantity(item.count) />
			<cfset LOCAL.orderProduct.setShippingCarrierName(LOCAL.productShippingMethodRela.getShippingMethod().getShippingCarrier().getDisplayName()) />
			<cfset LOCAL.orderProduct.setShippingMethodName(LOCAL.productShippingMethodRela.getShippingMethod().getDisplayName()) />
			<cfset LOCAL.orderProduct.setProductId(LOCAL.product.getProductId()) />
			<cfset LOCAL.orderProduct.setProductName(LOCAL.product.getDisplayName()) />
			<cfset LOCAL.orderProduct.setSku(LOCAL.product.getSku()) />
			<cfset LOCAL.orderProduct.setImageName(product.getDefaultImageLink(type='small')) />
			
			<cfset LOCAL.newProductStatusType = EntityLoad("order_product_status_type",{displayName = "added"},true) />
			<cfset LOCAL.newProductStatus = EntityNew("order_product_status") />
			<cfset LOCAL.newProductStatus.setStartDatetime(Now()) />
			<cfset LOCAL.newProductStatus.setCurrent(true) />
			<cfset LOCAL.newProductStatus.setOrderProductStatusType(LOCAL.newProductStatusType) />
			<cfset EntitySave(LOCAL.newProductStatus) /> 
			
			<cfset LOCAL.orderProduct.addOrderProductStatus(LOCAL.newProductStatus) />
			
			<cfset EntitySave(LOCAL.orderProduct) /> 
			
			<cfset LOCAL.order.addProduct(LOCAL.orderProduct) />
			
			<cfset EntitySave(LOCAL.order) /> 
		</cfloop>
		
		<!---
		<cfset StructDelete(SESSION,"order") />
		--->
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_thankyou.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>