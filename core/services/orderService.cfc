<cfcomponent extends="service" output="false" accessors="true">
    
   <cffunction name="getOrders" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
	   
		<cfif getSearchKeywords() NEQ "">	
			<cfset LOCAL.qry = "from order where (display_name like '%#getSearchKeywords()#%' )" /> 
		<cfelse>
			<cfset LOCAL.qry = "from order where 1=1 " /> 
		</cfif>
		
		<cfif NOT IsNull(getId())>
			<cfset LOCAL.qry = LOCAL.qry & "and order_id = '#getId()#' " />
		</cfif>
		<cfif NOT IsNull(getIsEnabled())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_enabled = '#getIsEnabled()#' " />
		</cfif>
		<cfif NOT IsNull(getIsDeleted())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_deleted = '#getIsDeleted()#' " />
		</cfif>
		
		<cfset LOCAL.records = ORMExecuteQuery(LOCAL.qry, false, getPaginationStruct()) /> 
		<cfset LOCAL.totalCount = ORMExecuteQuery( "select count(order_id) as count " & LOCAL.qry, true) /> 
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / APPLICATION.recordsPerPage) /> 
	
		<cfreturn LOCAL />
    </cffunction>
</cfcomponent>