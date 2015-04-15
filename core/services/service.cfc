<cfcomponent output="false" accessors="true">
    <cfproperty name="id" type="numeric"> 
    <cfproperty name="searchKeywords" type="string"> 
    <cfproperty name="isEnabled" type="boolean"> 
    <cfproperty name="isDeleted" type="boolean"> 
    <cfproperty name="pageNumber" type="numeric"> 

    <cffunction name="getPaginationStruct" output="false" access="public" returntype="struct">
		<!--- if use local scope, it will return extra field named 'arguments', it will break cfquery ormoptions value --->
		<cfset var retStruct = {} />
		
	    <cfif NOT IsNull(getPageNumber())>
			<cfset retStruct.offset = APPLICATION.recordsPerPage * (getPageNumber() - 1) />
		<cfelse>
			<cfset retStruct.offset = 0 />
		</cfif>
			
		<cfset retStruct.maxResults = APPLICATION.recordsPerPage />
	   
		<cfreturn retStruct />
    </cffunction>
</cfcomponent>