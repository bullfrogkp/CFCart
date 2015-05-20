<cfcomponent extends="service" output="false" accessors="true">
	<cffunction name="addProduct" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="productId" type="numeric" required="true">
		<cfargument name="count" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		<cfset var retStruct = {} />
		
		<cfquery name="LOCAL.getProduct">
			SELECT	p.product_id
			FROM	product_customer_group_rela pcgr
			JOIN	product p ON p.product_id = pcgr.product_id
			JOIN	customer_group cg ON cg.customer_group_id = pcgr.customer_group_id
			WHERE	p.parent_product_id = <cfqueryparam value="#ARGUMENTS.parentProductId#" cfsqltype="cf_sql_integer" />
			<cfif StructKeyExists(ARGUMENTS,"groupName")>
			AND		cg.name = <cfqueryparam value="#ARGUMENTS.groupName#" cfsqltype="cf_sql_varchar" />
			</cfif>
			<cfloop list="#ARGUMENTS.attributeValueIdList#" index="LOCAL.attributeValueId">
			AND		EXISTS	(	SELECT	1
								FROM	product_attribute_rela par
								JOIN	attribute_value av ON av.product_attribute_rela_id = par.product_attribute_rela_id
								WHERE	par.product_id = p.product_id
								AND		par.attribute_id = 
								(
									SELECT	par_sub.attribute_id
									FROM	product_attribute_rela par_sub
									JOIN	attribute_value av_sub ON av_sub.product_attribute_rela_id = par_sub.product_attribute_rela_id
									WHERE	av_sub.attribute_value_id = <cfqueryparam value="#LOCAL.attributeValueId#" cfsqltype="cf_sql_integer" />
								)
								AND		av.value = 
								(
									SELECT	av_sub.value
									FROM	attribute_value av_sub 
									WHERE	av_sub.attribute_value_id = <cfqueryparam value="#LOCAL.attributeValueId#" cfsqltype="cf_sql_integer" />
								)
							)
			</cfloop>
		</cfquery>
		
		<cfif IsNumeric(LOCAL.getProduct.product_id)>
			<cfset LOCAL.product = EntityLoadByPK("product", LOCAL.getProduct.product_id) />
			<cfset retStruct.productid = LOCAL.product.getProductId() />
			<cfif NOT IsNull(LOCAL.product.getStock())>
				<cfset retStruct.stock = LOCAL.product.getStock() />
			<cfelse>
				<cfset retStruct.stock = 0 />
			</cfif>
			<cfif StructKeyExists(ARGUMENTS, "customerGroupName")>
				<cfset retStruct.price = LOCAL.product.getPrice(customerGroupName = ARGUMENTS.customerGroupName) />
			<cfelse>
				<cfset LOCAL.defaultCutomerGroup = EntityLoad("customer_group", {isDefault = true}, true) />
				<cfset retStruct.price = LOCAL.product.getPrice(customerGroupName = LOCAL.defaultCutomerGroup.getName()) />
			</cfif>
		<cfelse>
			<cfset retStruct.productid = "" />
			<cfset retStruct.stock = 0 />
			<cfset retStruct.price = 0 />
		</cfif>
		
		<cfreturn retStruct>
	</cffunction>
</cfcomponent>