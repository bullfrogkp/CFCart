<cfcomponent output="false" accessors="true">
    <cfproperty name="id" type="numeric"> 
    <cfproperty name="searchKeywords" type="string"> 
    <cfproperty name="isEnabled" type="boolean"> 
    <cfproperty name="isDeleted" type="boolean"> 
    <cfproperty name="pageNumber" type="numeric"> 

    <cffunction name="getPaginationStruct" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
		
	    <cfif NOT IsNull(getPageNumber())>
			<cfset LOCAL.offset = APPLICATION.recordsPerPage * (getPageNumber() - 1) />
		<cfelse>
			<cfset LOCAL.offset = 0 />
		</cfif>
			
		<cfset LOCAL.maxResults = APPLICATION.recordsPerPage />
	   
		<cfreturn LOCAL />
    </cffunction>
</cfcomponent>