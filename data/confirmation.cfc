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
		
		<cfif SESSION.order.customer.isExistingCustomer EQ false>
			<cfset LOCAL.customer = EntityNew("customer") />
			<cfset LOCAL.customer.setFirstName(SESSION.order.customer.firstName)) />
			<cfset LOCAL.customer.setMiddleName(SESSION.order.customer.firstName) />
			<cfset LOCAL.customer.setLastName(SESSION.order.customer.lastName) />
			<cfset LOCAL.customer.setEmail(SESSION.order.customer.email) />
			<cfset LOCAL.customer.setPhone(SESSION.order.customer.phone) />
			<cfset LOCAL.customer.setIsEnabled(false) />
			<cfset LOCAL.customer.setIsDeleted(false) />
			<cfset LOCAL.customer.setCreatedDatetime(Now()) />
			<cfset LOCAL.customer.setCreatedUser(SESSION.user.userName) />
			<cfset LOCAL.customer.setCustomerGroup(EntityLoad("customer_group",{isDefault=true},true)) />
		<cfelse>
			<cfset LOCAL.customer = SESSION.order.customer.customer />
		</cfif>
		
		<cfif SESSION.order.shippingAddress.useExistingAddress EQ false>
			<cfset LOCAL.address = EntityNew("address") />
			<cfset LOCAL.address.setCompany(SESSION.order.shippingAddress.company)) />
			<cfset LOCAL.address.setFirstName(SESSION.order.shippingAddress.firstName)) />
			<cfset LOCAL.address.setMiddleName(SESSION.order.shippingAddress.firstName) />
			<cfset LOCAL.address.setLastName(SESSION.order.shippingAddress.lastName) />
			<cfset LOCAL.address.setPhone(SESSION.order.shippingAddress.phone) />
			<cfset LOCAL.address.setUnit(SESSION.order.shippingAddress.unit)) />
			<cfset LOCAL.address.setStreet(SESSION.order.shippingAddress.street) />
			<cfset LOCAL.address.setCity(SESSION.order.shippingAddress.city)) />
			<cfset LOCAL.address.setProvince(SESSION.order.shippingAddress.province) />
			<cfset LOCAL.address.setCountry(SESSION.order.shippingAddress.country) />
			<cfset LOCAL.address.setPostalCode(SESSION.order.shippingAddress.postalCode) />
			<cfset LOCAL.address.setCreatedDatetime(Now()) />
			<cfset LOCAL.address.setCreatedUser(SESSION.user.userName) />
			
			<cfset EntitySave(LOCAL.address) />
			<cfset LOCAL.customer.addAddress(LOCAL.address) />
		<cfelse>
			<cfset LOCAL.address = SESSION.order.shippingAddress.address />
		</cfif>	
			
		<cfset LOCAL.order.setShippingCompany(LOCAL.address.getCompany())) />
		<cfset LOCAL.order.setShippingUnit(LOCAL.address.getUnit()) />
		<cfset LOCAL.order.setShippingStreet(LOCAL.address.getStreet()) />
		<cfset LOCAL.order.setShippingCity(LOCAL.address.getCity()) />
		<cfset LOCAL.order.setShippingProvince(LOCAL.address.getProvince()) />
		<cfset LOCAL.order.setShippingCountry(LOCAL.address.getCountry()) />
		<cfset LOCAL.order.setShippingPostalCode(LOCAL.address.getPostalCode()) />
				
		<cfset LOCAL.order.setBillingCompany(LOCAL.address.getCompany())) />
		<cfset LOCAL.order.setBillingUnit(LOCAL.address.getUnit()) />
		<cfset LOCAL.order.setBillingStreet(LOCAL.address.getStreet()) />
		<cfset LOCAL.order.setBillingCity(LOCAL.address.getCity()) />
		<cfset LOCAL.order.setBillingProvince(LOCAL.address.getProvince()) />
		<cfset LOCAL.order.setBillingCountry(LOCAL.address.getCountry()) />
		<cfset LOCAL.order.setBillingPostalCode(LOCAL.address.getPostalCode()) />
		
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
		
		<cfset LOCAL.customer.addOrder(LOCAL.order) />
		<cfset EntitySave(LOCAL.customer) />
		
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