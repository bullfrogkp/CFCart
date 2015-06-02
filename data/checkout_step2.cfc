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
		
		<cfloop list="#FORM.product_shipping_method_rela_id_list#" index="LOCAL.productShippingMethodRelaId">
			<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela", LOCAL.productShippingMethodRelaId) />
			<cfset LOCAL.productId = LOCAL.productShippingMethodRela.getProduct().getProductId() />
			<cfloop array="#SESSION.order.productArray#" index="LOCAL.product">
				<cfif LOCAL.product.productId EQ LOCAL.productId>
					<cfset LOCAL.product.productShippingMethodRelaId = LOCAL.productShippingMethodRela.getProductShippingMethodRelaId() />
					<cfset LOCAL.product.totalShippingFee = LOCAL.product.getShippingFee(address = SESSION.order.shippingAddress, shippingMethodId = LOCAL.productShippingMethodRela.getShippingMethod().getShippingMethodId()) * LOCAL.product.count />
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