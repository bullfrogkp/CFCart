<cfcomponent extends="service" output="false" accessors="true">
    
   <cffunction name="getSystemEmails" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
	   
		<cfif getSearchKeywords() NEQ "">	
			<cfset LOCAL.qry = "from system_email where (subject like '%#getSearchKeywords()#%' or content like '%#getSearchKeywords()#%')" /> 
		<cfelse>
			<cfset LOCAL.qry = "from system_email where 1=1 " /> 
		</cfif>
		
		<cfif NOT IsNull(getId())>
			<cfset LOCAL.qry = LOCAL.qry & "and system_email_id = '#getId()#' " />
		</cfif>
		<cfif NOT IsNull(getIsEnabled())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_enabled = '#getIsEnabled()#' " />
		</cfif>
		<cfif NOT IsNull(getIsDeleted())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_deleted = '#getIsDeleted()#' " />
		</cfif>
		
		<cfset LOCAL.records = ORMExecuteQuery(LOCAL.qry, false, getPaginationStruct()) /> 
		<cfset LOCAL.totalCount = ORMExecuteQuery( "select count(system_email_id) as count " & LOCAL.qry, true) /> 
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / APPLICATION.recordsPerPage) /> 
	
		<cfreturn LOCAL />
    </cffunction>
	
	<cffunction name="getNewsLetters" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
	   
		<cfif getSearchKeywords() NEQ "">	
			<cfset LOCAL.qry = "from newsletter where (subject like '%#getSearchKeywords()#%' or content like '%#getSearchKeywords()#%')" /> 
		<cfelse>
			<cfset LOCAL.qry = "from newsletter where 1=1 " /> 
		</cfif>
		
		<cfif NOT IsNull(getId())>
			<cfset LOCAL.qry = LOCAL.qry & "and newsletter_id = '#getId()#' " />
		</cfif>
		<cfif NOT IsNull(getIsEnabled())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_enabled = '#getIsEnabled()#' " />
		</cfif>
		<cfif NOT IsNull(getIsDeleted())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_deleted = '#getIsDeleted()#' " />
		</cfif>
		
		<cfset LOCAL.records = ORMExecuteQuery(LOCAL.qry, false, getPaginationStruct()) /> 
		<cfset LOCAL.totalCount = ORMExecuteQuery( "select count(newsletter_id) as count " & LOCAL.qry, true) /> 
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / APPLICATION.recordsPerPage) /> 
	
		<cfreturn LOCAL />
    </cffunction>
</cfcomponent>