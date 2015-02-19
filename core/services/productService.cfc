<cfcomponent output="false" accessors="true">
    <cfproperty name="productId" type="numeric"> 
    <cfproperty name="productTypeId" type="numeric"> 
    <cfproperty name="categoryId" type="numeric"> 
    <cfproperty name="name" type="string"> 
    <cfproperty name="searchKeywords" type="string"> 
    <cfproperty name="displayName" type="string"> 
    <cfproperty name="isEnabled" type="boolean"> 
    <cfproperty name="isDeleted" type="boolean"> 
    <cfproperty name="offset" type="numeric"> 
    <cfproperty name="limit" type="numeric"> 

    <cffunction name="getProducts" output="false" access="public" returntype="array">
		<cfset LOCAL = {} />
	   
	    <cfif getSearchKeywords() NEQ "">
			<cfset LOCAL.qry = "from products p where (p.display_name like '%#getSearchKeywords()#%' or p.keywords like '%#getSearchKeywords()#%' or p.description like '%#getSearchKeywords()#%' )" > 
			
			<cfif NOT IsNull(getProductId())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.product_id = '#getProductId()#' " />
			</cfif>
			<cfif NOT IsNull(getProductTypeId())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.product_type_id = '#getProductTypeId()#' " />
			</cfif>
			<cfif NOT IsNull(getCategoryId())>
				<cfset LOCAL.qry = LOCAL.qry & "and exists(from category_product_rela cpr where cpr.category_id = '#getCategoryId()#' and cpr.product_id = p.product_id) " />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.is_enabled = '#getIsEnabled()#' " />
			</cfif>
			
			<cfset LOCAL.products = ORMExecuteQuery(LOCAL.qry)> 
		<cfelse>
			<cfset LOCAL.filter = {} />
			<cfif NOT IsNull(getProductId())>
				<cfset LOCAL.filter.productId = getProductId() />
			</cfif>
			<cfif NOT IsNull(getProductTypeId())>
				<cfset LOCAL.filter.productTypeId = getProductTypeId() />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.filter.isEnabled = getIsEnabled() />
			</cfif>
			
			<cfset LOCAL.products = EntityLoad('product',LOCAL.filter)> 
		</cfif>
	   
		<cfreturn LOCAL.products />
    </cffunction>
	
	<cffunction name="getProductGroupPrices" output="false" access="public" returntype="array">
		<cfset LOCAL = {} />
	   
	    <cfquery name="LOCAL.getProductGroupPrices">
			SELECT	pcgr.price, cg.customer_group_id
			FROM	product_customer_group_rela pcgr
			JOIN	customer_group cg ON cg.customer_group_id = pcgr.customer_group_id
			WHERE	pcgr.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getProductId()#" />
		</cfquery>
		
		<cfset LOCAL.priceArray = {} />
		
		<cfoutput query="LOCAL.getProductGroupPrices" group="price">
			<cfset LOCAL.priceStruct = {} />
			<cfset LOCAL.priceStruct.price = LOCAL.getProductGroupPrices.price />
			<cfset LOCAL.priceStruct.customer_group_id_list = ValueList(LOCAL.getProductGroupPrices.customer_group_id) />
			<cfset ArrayAppend(LOCAL.priceArray, LOCAL.priceStruct) />
		</cfoutput>
	   
		<cfreturn LOCAL.priceArray />
    </cffunction>
	
	<cffunction name="getProductAttributes" output="false" access="public" returntype="array">
		<cfset LOCAL = {} />
	   
	    <cfquery name="LOCAL.getProductAttributes">
			SELECT	attr.attribute_id, attr.display_name, av.value, av.min_value, av.max_value
			FROM	attribute attr
			JOIN	attribute_value av ON av.attribute_id = attr.attribute_id
			WHERE	av.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getProductId()#" />
		</cfquery>
		
		<cfset LOCAL.attributeArray = [] />
		
		<cfoutput query="LOCAL.getProductAttributes" group="attribute_id">
			<cfset LOCAL.attributeStruct = {} />
			<cfset LOCAL.attributeStruct.name = LOCAL.getProductAttributes.display_name />
			
			<cfset LOCAL.attributeStruct.attributeValueArray = [] />
			
			<cfoutput>
				<cfset LOCAL.attributeValueStruct.value = LOCAL.getProductGroupPrices.value />
				<cfset LOCAL.attributeValueStruct.minValue = LOCAL.getProductGroupPrices.min_value />
				<cfset LOCAL.attributeValueStruct.maxValue = LOCAL.getProductGroupPrices.max_value />
				<cfset ArrayAppend(LOCAL.attributeStruct.attributeValueArray, LOCAL.attributeValueStruct) />
			</cfoutput>
			
			<cfset ArrayAppend(LOCAL.attributeArray, LOCAL.attributeStruct) />
		</cfoutput>
	   
		<cfreturn LOCAL.attributeArray />
    </cffunction>
</cfcomponent>