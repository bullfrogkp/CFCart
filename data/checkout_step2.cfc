<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Shipping Information | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset SESSION.order.totalShippingFee = 0 />
		
		<!--- product_shipping_method_rela_id_list is from ddslick.min.js --->
		<cfloop list="#FORM.product_shipping_method_rela_id_list#" index="LOCAL.productShippingMethodRelaId">
			<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela", LOCAL.productShippingMethodRelaId) />
			<cfset LOCAL.productId = LOCAL.productShippingMethodRela.getProduct().getProductId() />
			<cfloop array="#SESSION.order.productArray#" index="LOCAL.product">
				<cfset LOCAL.productEntity = EntityLoadByPK("product",LOCAL.product.productId) />
				<cfif 	NOT IsNull(LOCAL.productEntity.getParentProduct()) AND LOCAL.productEntity.getParentProduct().getProductId() EQ LOCAL.productId
						OR
						IsNull(LOCAL.productEntity.getParentProduct()) AND LOCAL.product.productId EQ LOCAL.productId>
					<cfset LOCAL.product.productShippingMethodRelaId = LOCAL.productShippingMethodRelaId />
					<cfset LOCAL.product.totalShippingFee = LOCAL.productShippingMethodRela.getProduct().getShippingFee(address = SESSION.order.shippingAddress, shippingMethodId = LOCAL.productShippingMethodRela.getShippingMethod().getShippingMethodId(),customerGroupName = SESSION.user.customerGroupName) * LOCAL.product.count />
					<cfset SESSION.order.totalShippingFee += LOCAL.product.totalShippingFee />
					<cfbreak />
				</cfif>
			</cfloop>
		</cfloop>
		
		<cfset SESSION.order.totalPrice = SESSION.order.subTotalPrice + SESSION.order.totalTax + SESSION.order.totalShippingFee />
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>