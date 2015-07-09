<cfcomponent output="false" accessors="true">
    <cfproperty name="cfid" type="string"> 
    <cfproperty name="cftoken" type="string"> 
    <cfproperty name="customerGroupName" type="string"> 
    <cfproperty name="isExistingCustomer" type="boolean"> 
    <cfproperty name="sameAddress" type="boolean"> 
    <cfproperty name="productShippingMethodRelaIdList" type="string"> 
	
    <cfproperty name="subTotalPrice" type="numeric"> 
    <cfproperty name="totalPrice" type="numeric"> 
    <cfproperty name="totalTax" type="numeric"> 
    <cfproperty name="totalShippingFee" type="numeric"> 
    <cfproperty name="discount" type="numeric"> 
	<cfproperty name="subTotalPriceWCLocal" type="string"> 
    <cfproperty name="totalPriceWCLocal" type="string"> 
    <cfproperty name="totalTaxWCLocal" type="string"> 
    <cfproperty name="totalShippingFeeWCLocal" type="string"> 
    <cfproperty name="discountWCLocal" type="string"> 
	<cfproperty name="subTotalPriceWCInter" type="string"> 
    <cfproperty name="totalPriceWCInter" type="string"> 
    <cfproperty name="totalTaxWCInter" type="string"> 
    <cfproperty name="totalShippingFeeWCInter" type="string"> 
    <cfproperty name="discountWCInter" type="string"> 
	
    <cfproperty name="currency" type="any"> 
    <cfproperty name="customer" type="any"> 
	<cfproperty name="order" type="any"> 
	<cfproperty name="paymentMethod" type="any"> 
    <cfproperty name="coupon" type="any"> 
    <cfproperty name="shippingAddress" type="any"> 
    <cfproperty name="billingAddress" type="any"> 
    <cfproperty name="productArray" type="array"> 
	<!------------------------------------------------------------------------------->	
	<cffunction name="calculate" access="public" output="false" returnType="void">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.trackingRecords = new "#APPLICATION.componentPathRoot#core.services.trackingService"().getTrackingRecords(trackingRecordType = "shopping cart") />
		<cfset LOCAL.currency = EntityLoadByPK("currency",getCurrencyId()) />
		
		<cfset LOCAL.productArray = [] />
		<cfset LOCAL.subTotalPrice = 0 />
		<cfset LOCAL.totalTax = 0 />
		<cfset LOCAL.totalPrice = 0 />
		<cfset LOCAL.totalShippingFee = 0 />
		<cfset LOCAL.discount = 0 />
		<cfset LOCAL.couponId = "" />
		
		<cfloop array="#LOCAL.trackingRecords#" index="LOCAL.record">
			<cfset LOCAL.productStruct = {} />
			<cfset LOCAL.product = LOCAL.record.getProduct() />
			<cfset LOCAL.productStruct.productId = LOCAL.product.getProductId() />
			<cfset LOCAL.productStruct.count = LOCAL.record.getCount() />
			<cfset LOCAL.productStruct.singlePrice = LOCAL.product.getPrice(customerGroupName = getCustomerGroupName(), currencyId = getCurrencyId()) />
			<cfset LOCAL.productStruct.singlePriceWCLocal = LSCurrencyFormat(LOCAL.productStruct.singlePrice,"local",LOCAL.currency.getLocale()) />
			<cfset LOCAL.productStruct.singlePriceWCInter = LSCurrencyFormat(LOCAL.productStruct.singlePrice,"international",LOCAL.currency.getLocale()) />
			<cfset LOCAL.productStruct.totalPrice = LOCAL.productStruct.singlePrice * LOCAL.productStruct.count />
			<cfset LOCAL.productStruct.totalPriceWCLocal = LSCurrencyFormat(LOCAL.productStruct.totalPrice,"local",LOCAL.currency.getLocale()) />
			<cfset LOCAL.productStruct.totalPriceWCInter = LSCurrencyFormat(LOCAL.productStruct.totalPrice,"international",LOCAL.currency.getLocale()) />
		
			<cfif NOT IsNull(getShippingAddress())>
				<cfset LOCAL.productShippingMethodRelas = LOCAL.product.getProductShippingMethodRelasMV() />
				<cfset LOCAL.productStruct.shippingMethodArray = [] />
			
				<cfloop array="#LOCAL.productShippingMethodRelas#" index="LOCAL.productShippingMethodRela">
					<cfset LOCAL.shippingMethod = LOCAL.productShippingMethodRela.getShippingMethod() />
					<cfset LOCAL.shippingMethodStruct = {} />
					<cfset LOCAL.shippingMethodStruct.productShippingMethodRelaId = LOCAL.productShippingMethodRela.getProductShippingMethodRelaId() />
					<cfset LOCAL.shippingMethodStruct.name = LOCAL.shippingMethod.getDisplayName() />
					<cfset LOCAL.shippingMethodStruct.logo = LOCAL.shippingMethod.getShippingCarrier().getImageName() />
					<cfset LOCAL.shippingMethodStruct.price = LOCAL.product.getShippingFeeMV(	address = getShippingAddress()
																							, 	shippingMethodId = LOCAL.shippingMethod.getShippingMethodId()
																							,	customerGroupName = getCustomerGroupName()) * LOCAL.productStruct.count
																							, 	currencyId = getCurrencyId()	/>
					
					<cfset LOCAL.shippingMethodStruct.priceWCLocal = LSCurrencyFormat(LOCAL.shippingMethodStruct.price,"local",LOCAL.currency.getLocale()) />
					<cfset LOCAL.shippingMethodStruct.priceWCInter = LSCurrencyFormat(LOCAL.shippingMethodStruct.price,"international",LOCAL.currency.getLocale()) />
					
					<cfset LOCAL.shippingMethodStruct.label = "#LOCAL.shippingMethod.getShippingCarrier().getDisplayName()# - #LOCAL.shippingMethod.getDisplayName()#" />
				
					<cfset ArrayAppend(LOCAL.productStruct.shippingMethodArray, LOCAL.shippingMethodStruct) />
				</cfloop>
				
				<cfset LOCAL.productStruct.singleTax = NumberFormat(LOCAL.productStruct.singlePrice * LOCAL.product.getTaxRateMV(provinceId = getShippingAddress().provinceId, currencyId = getCurrencyId()),"0.00") />
				<cfset LOCAL.productStruct.singleTaxWCLocal = LSCurrencyFormat(LOCAL.productStruct.singleTax,"local",LOCAL.currency.getLocale()) />
				<cfset LOCAL.productStruct.singleTaxWCInter = LSCurrencyFormat(LOCAL.productStruct.singleTax,"international",LOCAL.currency.getLocale()) />
				
				<cfset LOCAL.productStruct.totalTax = LOCAL.productStruct.singleTax * LOCAL.productStruct.count />
				<cfset LOCAL.productStruct.totalTaxWCLocal = LSCurrencyFormat(LOCAL.productStruct.totalTax,"local",LOCAL.currency.getLocale()) />
				<cfset LOCAL.productStruct.totalTaxWCInter = LSCurrencyFormat(LOCAL.productStruct.totalTax,"international",LOCAL.currency.getLocale()) />
				
				<cfset LOCAL.totalTax += LOCAL.productStruct.totalTax />
			</cfif>
			
			<cfset LOCAL.subTotalPrice += LOCAL.productStruct.totalPrice />
			<cfset LOCAL.totalPrice = LOCAL.subTotalPrice + LOCAL.totalTax />
			
			<cfset ArrayAppend(LOCAL.productArray, LOCAL.productStruct) />
		</cfloop>
		
		<cfif getCouponCode() NEQ "">
			<cfset LOCAL.cartService = new "#APPLICATION.componentPathRoot#core.services.cartService"() />
			<cfset LOCAL.applyCoupon = LOCAL.cartService.applyCouponCode(couponCode = getCouponCode(), customerId = getCustomerId(), total = LOCAL.subTotalPrice, currencyId = getCurrencyId()) />
			
			<cfif LOCAL.applyCoupon.success EQ true>
				<cfset LOCAL.couponId = LOCAL.applyCoupon.couponId />
				<cfset LOCAL.discount = LOCAL.applyCoupon.discount />
				<cfset LOCAL.subTotalPrice = LOCAL.applyCoupon.newTotal />
			</cfif>
		</cfif>
		
		<cfif NOT IsNull(getProductShippingMethodRelaIdList())>
			<!--- product_shipping_method_rela_id_list is from ddslick.min.js --->
			<cfloop list="#getProductShippingMethodRelaIdList()#" index="LOCAL.productShippingMethodRelaId">
				<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela", LOCAL.productShippingMethodRelaId) />
				<cfset LOCAL.productId = LOCAL.productShippingMethodRela.getProduct().getProductId() />
				<cfloop array="#LOCAL.productArray#" index="LOCAL.productStruct">
					<cfset LOCAL.productEntity = EntityLoadByPK("product",LOCAL.productStruct.productId) />
					<cfif 	NOT IsNull(LOCAL.productEntity.getParentProduct()) AND LOCAL.productEntity.getParentProduct().getProductId() EQ LOCAL.productId
							OR
							IsNull(LOCAL.productEntity.getParentProduct()) AND LOCAL.productStruct.productId EQ LOCAL.productId>
						<cfset LOCAL.productStruct.productShippingMethodRelaId = LOCAL.productShippingMethodRelaId />
						<cfset LOCAL.productStruct.totalShippingFee = LOCAL.productShippingMethodRela.getProduct().getShippingFeeMV(address = getShippingAddress(), shippingMethodId = LOCAL.productShippingMethodRela.getShippingMethod().getShippingMethodId(),customerGroupName = getCustomerGroupName(), currencyId = getCurrencyId()) * LOCAL.productStruct.count />
						<cfset LOCAL.productStruct.totalShippingFeeWCLocal = LSCurrencyFormat(LOCAL.productStruct.totalShippingFee,"local",LOCAL.currency.getLocale()) />
						<cfset LOCAL.productStruct.totalShippingFeeWCInter = LSCurrencyFormat(LOCAL.productStruct.totalShippingFee,"international",LOCAL.currency.getLocale()) />
						
						<cfset LOCAL.totalShippingFee += LOCAL.productStruct.totalShippingFee />
						<cfbreak />
					</cfif>
				</cfloop>
			</cfloop>
		
			<cfset LOCAL.totalPrice = LOCAL.subTotalPrice + LOCAL.totalTax + LOCAL.totalShippingFee />
		</cfif>
		
		<cfset setProductArray(LOCAL.productArray) />
		<cfset setSubTotalPrice(LOCAL.subTotalPrice) />
		<cfset setTotalShippingFee(LOCAL.totalShippingFee) />
		<cfset setTotalTax(LOCAL.totalTax) />
		<cfset setTotalPrice(LOCAL.totalPrice) />
		<cfset setDiscount(LOCAL.discount) />
		<cfset setCouponId(LOCAL.couponId) />
		
		<cfset setSubTotalPriceWCLocal(LSCurrencyFormat(LOCAL.subTotalPrice,"local",LOCAL.currency.getLocale())) />
		<cfset setTotalShippingFeeWCLocal(LSCurrencyFormat(LOCAL.totalShippingFee,"local",LOCAL.currency.getLocale())) />
		<cfset setTotalTaxWCLocal(LSCurrencyFormat(LOCAL.totalTax,"local",LOCAL.currency.getLocale())) />
		<cfset setTotalPriceWCLocal(LSCurrencyFormat(LOCAL.totalPrice,"local",LOCAL.currency.getLocale())) />
		<cfset setDiscountWCLocal(LSCurrencyFormat(LOCAL.discount,"local",LOCAL.currency.getLocale())) />
		
		<cfset setSubTotalPriceWCInter(LSCurrencyFormat(LOCAL.subTotalPrice,"international",LOCAL.currency.getLocale())) />
		<cfset setTotalShippingFeeWCInter(LSCurrencyFormat(LOCAL.totalShippingFee,"international",LOCAL.currency.getLocale())) />
		<cfset setTotalTaxWCInter(LSCurrencyFormat(LOCAL.totalTax,"international",LOCAL.currency.getLocale())) />
		<cfset setTotalPriceWCInter(LSCurrencyFormat(LOCAL.totalPrice,"international",LOCAL.currency.getLocale())) />
		<cfset setDiscountWCInter(LSCurrencyFormat(LOCAL.discount,"international",LOCAL.currency.getLocale())) />
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="save" access="public" output="false" returnType="void">
		<cfset saveCustomer() />
		<cfset saveShippingAddress() />
		<cfset saveBillingAddress() />
		<cfset savePayment() />
		<cfset saveCoupon() />
		<cfset saveOrder() />
		<cfset saveOrderProduct() />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="submit" access="public" output="false" returnType="void">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.paymentMethod = EntityLoadByPK("payment_method",getPaymentMethodId()) />
		<cfset LOCAL.paymentService = new "#APPLICATION.componentPathRoot#core.services.#LOCAL.paymentMethod.getName()#Service"() />
		<cfset LOCAL.paymentService.setCart(this) />
		<cfset LOCAL.paymentService.process() />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="setPaid" access="public" output="false" returnType="void">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.order = EntityLoadByPK("order",getOrderId()) />
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
		
		<cfset LOCAL.order.setIsComplete(true) />
		<cfset EntitySave(LOCAL.order) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="saveCustomer" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		
		<cfif getIsExistingCustomer() EQ false>
			<cfset LOCAL.customer = EntityNew("customer") />
			<cfset LOCAL.customer.setFirstName(getCustomer().firstName) />
			<cfset LOCAL.customer.setMiddleName(getCustomer().firstName) />
			<cfset LOCAL.customer.setLastName(getCustomer().lastName) />
			<cfset LOCAL.customer.setCompany(getCustomer().company) />
			<cfset LOCAL.customer.setEmail(getCustomer().email) />
			<cfset LOCAL.customer.setPhone(getCustomer().phone) />
			<cfset LOCAL.customer.setIsEnabled(false) />
			<cfset LOCAL.customer.setIsDeleted(false) />
			<cfset LOCAL.customer.setCreatedDatetime(Now()) />
			<cfset LOCAL.customer.setCreatedUser(SESSION.user.userName) />
			<cfset LOCAL.customer.setCustomerGroup(EntityLoad("customer_group",{isDefault=true},true)) />
		<cfelse>
			<cfset LOCAL.customer = EntityLoadByPK("customer",getCustomer().customerId) />
		</cfif>
		
		<cfset EntitySave(LOCAL.customer) />
		
		<cfreturn LOCAL.customer />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="setCurrentShippingAddress" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		
		<cfif getShippingAddress().useExistingAddress EQ false>
			<cfset LOCAL.shippingAddress = EntityNew("address") />
			<cfset LOCAL.shippingAddress.setCompany(getShippingAddress().company) />
			<cfset LOCAL.shippingAddress.setFirstName(getShippingAddress().firstName) />
			<cfset LOCAL.shippingAddress.setMiddleName(getShippingAddress().firstName) />
			<cfset LOCAL.shippingAddress.setLastName(getShippingAddress().lastName) />
			<cfset LOCAL.shippingAddress.setPhone(getShippingAddress().phone) />
			<cfset LOCAL.shippingAddress.setUnit(getShippingAddress().unit) />
			<cfset LOCAL.shippingAddress.setStreet(getShippingAddress().street) />
			<cfset LOCAL.shippingAddress.setCity(getShippingAddress().city) />
			<cfset LOCAL.shippingAddress.setProvince(EntityLoadByPK("province",getShippingAddress().provinceId)) />
			<cfset LOCAL.shippingAddress.setCountry(EntityLoadByPK("country",getShippingAddress().countryId)) />
			<cfset LOCAL.shippingAddress.setPostalCode(getShippingAddress().postalCode) />
			<cfset LOCAL.shippingAddress.setCreatedDatetime(Now()) />
			<cfset LOCAL.shippingAddress.setCreatedUser(SESSION.user.userName) />
			
			<cfset EntitySave(LOCAL.shippingAddress) />
			<cfset LOCAL.customer.addAddress(LOCAL.shippingAddress) />
		<cfelse>
			<cfset LOCAL.shippingAddress = EntityLoadByPK("address",getShippingAddress().addressId) />
		</cfif>	
		<cfreturn LOCAL.shippingAddress />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="setCurrentBillingAddress" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		
		<cfif getSameAddress() EQ true>
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
			<cfif getBillingAddress().useExistingAddress EQ false>
				<cfset LOCAL.billingAddress = EntityNew("address") />
				<cfset LOCAL.billingAddress.setCompany(getBillingAddress().company) />
				<cfset LOCAL.billingAddress.setFirstName(getBillingAddress().firstName) />
				<cfset LOCAL.billingAddress.setMiddleName(getBillingAddress().firstName) />
				<cfset LOCAL.billingAddress.setLastName(getBillingAddress().lastName) />
				<cfset LOCAL.billingAddress.setPhone(getBillingAddress().phone) />
				<cfset LOCAL.billingAddress.setUnit(getBillingAddress().unit) />
				<cfset LOCAL.billingAddress.setStreet(getBillingAddress().street) />
				<cfset LOCAL.billingAddress.setCity(getBillingAddress().city) />
				<cfset LOCAL.billingAddress.setProvince(EntityLoadByPK("province",getBillingAddress().provinceId)) />
				<cfset LOCAL.billingAddress.setCountry(EntityLoadByPK("country",getBillingAddress().countryId)) />
				<cfset LOCAL.billingAddress.setPostalCode(getBillingAddress().postalCode) />
				<cfset LOCAL.billingAddress.setCreatedDatetime(Now()) />
				<cfset LOCAL.billingAddress.setCreatedUser(SESSION.user.userName) />
				
				<cfset EntitySave(LOCAL.billingAddress) />
				<cfset LOCAL.customer.addAddress(LOCAL.billingAddress) />
			<cfelse>
				<cfset LOCAL.billingAddress = EntityLoadByPK("address",getBillingAddress().addressId) />
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
		<cfreturn LOCAL.billingAddress />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="setOrderStatus" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.orderStatusType = EntityLoad("order_status_type",{name = "placed"},true) />
		<cfset LOCAL.orderStatus = EntityNew("order_status") />
		<cfset LOCAL.orderStatus.setStartDatetime(Now()) />
		<cfset LOCAL.orderStatus.setCurrent(true) />
		<cfset LOCAL.orderStatus.setOrderStatusType(LOCAL.orderStatusType) />
		<cfset EntitySave(LOCAL.orderStatus) /> 
		
		<cfset LOCAL.order.addOrderStatus(LOCAL.orderStatus) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="addOrderProducts" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		
		<cfloop array="#getProductArray()#" index="item">
			<cfset LOCAL.product = EntityLoadByPK("product",item.productId) />
			
			<cfset LOCAL.taxCategoryName = LOCAL.product.getTaxCategoryMV().getDisplayName() />
			<cfset LOCAL.displayName = LOCAL.product.getDisplayNameMV() />
			<cfset LOCAL.imageName = LOCAL.product.getDefaultImageLinkMV(type='small') />
			
			<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela",item.productShippingMethodRelaId) />
						
			<cfset LOCAL.orderProduct = EntityNew("order_product") />
			<cfset LOCAL.orderProduct.setPrice(item.singlePrice) />
			<cfset LOCAL.orderProduct.setTaxCategoryName(LOCAL.taxCategoryName) />
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
			<cfset LOCAL.orderProduct.setProductName(LOCAL.displayName) />
			<cfset LOCAL.orderProduct.setSku(LOCAL.product.getSku()) />
			<cfset LOCAL.orderProduct.setImageName(LOCAL.imageName) />
			
			<cfset LOCAL.orderProductStatusType = EntityLoad("order_product_status_type",{name = "placed"},true) />
			<cfset LOCAL.orderProductStatus = EntityNew("order_product_status") />
			<cfset LOCAL.orderProductStatus.setStartDatetime(Now()) />
			<cfset LOCAL.orderProductStatus.setCurrent(true) />
			<cfset LOCAL.orderProductStatus.setOrderProductStatusType(LOCAL.orderProductStatusType) />
			<cfset EntitySave(LOCAL.orderProductStatus) /> 
			
			<cfset LOCAL.orderProduct.addOrderProductStatus(LOCAL.orderProductStatus) />
			<cfset EntitySave(LOCAL.orderProduct) /> 
			<cfset LOCAL.order.addProduct(LOCAL.orderProduct) />
			
			<!--- for product sorting --->
			<cfif IsNull(LOCAL.product.getSoldCountMV())>
				<cfset LOCAL.product.setSoldCountMV(1) />
			<cfelse>
				<cfset LOCAL.product.setSoldCountMV(LOCAL.product.getSoldCountMV() + 1) />
			</cfif>
			<cfset EntitySave(LOCAL.product) /> 
		</cfloop>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="saveOrder" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.order.setShippingFirstName(getShippingAddress().getFirstName()) />
		<cfset LOCAL.order.setShippingMiddleName(getShippingAddress().getMiddleName()) />
		<cfset LOCAL.order.setShippingLastName(getShippingAddress().getLastName()) />
		<cfset LOCAL.order.setShippingCompany(getShippingAddress().getCompany()) />
		<cfset LOCAL.order.setShippingUnit(getShippingAddress().getUnit()) />
		<cfset LOCAL.order.setShippingStreet(getShippingAddress().getStreet()) />
		<cfset LOCAL.order.setShippingCity(getShippingAddress().getCity()) />
		<cfset LOCAL.order.setShippingProvince(getShippingAddress().getProvince()) />
		<cfset LOCAL.order.setShippingCountry(getShippingAddress().getCountry()) />
		<cfset LOCAL.order.setShippingPostalCode(getShippingAddress().getPostalCode()) />
		
		<cfset LOCAL.order.setBillingFirstName(getBillingAddress().getFirstName()) />
		<cfset LOCAL.order.setBillingMiddleName(getBillingAddress().getMiddleName()) />
		<cfset LOCAL.order.setBillingLastName(getBillingAddress().getLastName()) />
		<cfset LOCAL.order.setBillingCompany(getBillingAddress().getCompany()) />
		<cfset LOCAL.order.setBillingUnit(getBillingAddress().getUnit()) />
		<cfset LOCAL.order.setBillingStreet(getBillingAddress().getStreet()) />
		<cfset LOCAL.order.setBillingCity(getBillingAddress().getCity()) />
		<cfset LOCAL.order.setBillingProvince(getBillingAddress().getProvince()) />
		<cfset LOCAL.order.setBillingCountry(getBillingAddress().getCountry()) />
		<cfset LOCAL.order.setBillingPostalCode(getBillingAddress().getPostalCode()) />
		
		<cfset LOCAL.order.setPaymentMethod(EntityLoadByPK("payment_method",getPaymentMethodId())) />
		<cfset LOCAL.order.setCouponCode(getCoupon().getCouponCode) />
		<cfset LOCAL.order.setDiscount(getCoupon().) />
		
		<cfset LOCAL.order.setCreatedDatetime(Now()) />
		<cfset LOCAL.order.setCreatedUser(SESSION.user.userName) />
					
		<cfset EntitySave(LOCAL.order) />
		<cfset LOCAL.customer.addOrder(LOCAL.order) />
		<cfset EntitySave(LOCAL.customer) />
		
		<cfset addOrderProducts() />
		
	</cffunction>
</cfcomponent>
