<cfcomponent output="false" accessors="true">
    <cfproperty name="productId" type="numeric"> 
    <cfproperty name="typeId" type="numeric"> 
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
			<cfif NOT IsNull(getTypeId())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.type_id = '#getTypeId()#' " />
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
			<cfif NOT IsNull(getTypeId())>
				<cfset LOCAL.filter.typeId = getTypeId() />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.filter.isEnabled = getIsEnabled() />
			</cfif>
			
			<cfset LOCAL.products = EntityLoad('product',LOCAL.filter)> 
		</cfif>
	   
		<cfreturn LOCAL.products />
    </cffunction>
</cfcomponent>