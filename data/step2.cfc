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
					<cfset LOCAL.product.shippingFee = LOCAL.productShippingMethodRela.getPrice() />
					<cfbreak />
				</cfif>
			</cfloop>
			<cfset SESSION.order.totalShippingFee += LOCAL.product.shippingFee />
			<cfset SESSION.order.totalPrice += LOCAL.product.shippingFee />
		</cfloop>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/confirmation.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>