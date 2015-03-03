<cfcomponent output="false" accessors="true">
    <cfproperty name="customerId" type="numeric"> 
    <cfproperty name="name" type="string"> 
    <cfproperty name="searchKeywords" type="string"> 
    <cfproperty name="isEnabled" type="boolean"> 
    <cfproperty name="isDeleted" type="boolean"> 
    <cfproperty name="offset" type="numeric"> 
    <cfproperty name="limit" type="numeric"> 

   <cffunction name="getCustomers" output="false" access="public" returntype="array">
		<cfset var LOCAL = {} />
	   
	    <cfif getSearchKeywords() NEQ "">
			<cfset LOCAL.qry = "from customer c where (c.display_name like '%#getSearchKeywords()#%' or c.keywords like '%#getSearchKeywords()#%' or c.description like '%#getSearchKeywords()#%' )" > 
			
			<cfif NOT IsNull(getCustomerId())>
				<cfset LOCAL.qry = LOCAL.qry & "and c.customer_id = '#getCustomerId()#' " />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.is_enabled = '#getIsEnabled()#' " />
			</cfif>
			
			<cfset LOCAL.customers = ORMExecuteQuery(LOCAL.qry)> 
		<cfelse>
			<cfset LOCAL.filter = {} />
			<cfif NOT IsNull(getCustomerId())>
				<cfset LOCAL.filter.customerId = getCustomerId() />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.filter.isEnabled = getIsEnabled() />
			</cfif>
	
			<cfset LOCAL.customers = EntityLoad('customer',LOCAL.filter)> 
		</cfif>
	   
		<cfreturn LOCAL.customers />
    </cffunction>
</cfcomponent>