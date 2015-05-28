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
		<cfset LOCAL.order.setOrderTrackingNumber("OR#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"hhmmss")##LOCAL.order.getOrderId()#") />
		<cfset LOCAL.order.setIsDeleted(false) />
		
		<cfif SESSION.order.customer.isExistingCustomer EQ false>
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
			<cfset LOCAL.customer = SESSION.order.customer.customer />
		</cfif>
						
		<cfif SESSION.order.sameAddress EQ true>	
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
				<cfset LOCAL.shippingAddress.setProvince(SESSION.order.shippingAddress.province) />
				<cfset LOCAL.shippingAddress.setCountry(SESSION.order.shippingAddress.country) />
				<cfset LOCAL.shippingAddress.setPostalCode(SESSION.order.shippingAddress.postalCode) />
				<cfset LOCAL.shippingAddress.setCreatedDatetime(Now()) />
				<cfset LOCAL.shippingAddress.setCreatedUser(SESSION.user.userName) />
				
				<cfset EntitySave(LOCAL.shippingAddress) />
				<cfset LOCAL.customer.addAddress(LOCAL.shippingAddress) />
				<cfset EntitySave(LOCAL.customer) />
			<cfelse>
				<cfset LOCAL.shippingAddress = SESSION.order.shippingAddress.address />
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
			<!---  shipping --->
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
				<cfset LOCAL.shippingAddress.setProvince(SESSION.order.shippingAddress.province) />
				<cfset LOCAL.shippingAddress.setCountry(SESSION.order.shippingAddress.country) />
				<cfset LOCAL.shippingAddress.setPostalCode(SESSION.order.shippingAddress.postalCode) />
				<cfset LOCAL.shippingAddress.setCreatedDatetime(Now()) />
				<cfset LOCAL.shippingAddress.setCreatedUser(SESSION.user.userName) />
				
				<cfset EntitySave(LOCAL.shippingAddress) />
				<cfset LOCAL.customer.addAddress(LOCAL.shippingAddress) />
				<cfset EntitySave(LOCAL.customer) />
			<cfelse>
				<cfset LOCAL.shippingAddress = SESSION.order.shippingAddress.address />
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
			
			<!--- billing --->
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
				<cfset LOCAL.billingAddress.setProvince(SESSION.order.billingAddress.province) />
				<cfset LOCAL.billingAddress.setCountry(SESSION.order.billingAddress.country) />
				<cfset LOCAL.billingAddress.setPostalCode(SESSION.order.billingAddress.postalCode) />
				<cfset LOCAL.billingAddress.setCreatedDatetime(Now()) />
				<cfset LOCAL.billingAddress.setCreatedUser(SESSION.user.userName) />
				
				<cfset EntitySave(LOCAL.billingAddress) />
				<cfset LOCAL.customer.addAddress(LOCAL.billingAddress) />
				<cfset EntitySave(LOCAL.customer) />
			<cfelse>
				<cfset LOCAL.billingAddress = SESSION.order.billingAddress.address />
			</cfif>	
				
			<cfset LOCAL.order.setBillingFirstName(LOCAL.billingAddress.getFirstName()) />
			<cfset LOCAL.order.setBillingMiddleName(LOCAL.billingAddress.getMiddleName()) />
			<cfset LOCAL.order.setBillingLastName(LOCAL.billingAddress.getLastName()) />
			<cfset LOCAL.order.setBillingCompany(LOCAL.billingAddress.getCompany()) />
			<cfset LOCAL.order.setBillingUnit(LOCAL.billingAddress.getUnit()) />
			<cfset LOCAL.order.setBillingStreet(LOCAL.billingAddress.getStreet()) />
			<cfset LOCAL.order.setBillingCity(LOCAL.billingAddress.getCity()) />
			<cfset LOCAL.order.setBillingProvince(LOCAL.billingAddress.getProvince()) />
			<cfset LOCAL.order.setBillingCountry(LOCAL.billingAddress.getCountry()) />
			<cfset LOCAL.order.setBillingPostalCode(LOCAL.billingAddress.getPostalCode()) />
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
			<cfset LOCAL.orderProduct.setShippingCarrierName(LOCAL.productShippingMethodRela.getShippingMethod().getShippingCarrier().getDisplayName()) />
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
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_thankyou.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>