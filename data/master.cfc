<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.formdata = Duplicate(FORM) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
				
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="_getPaginationInfo" access="private" output="false" returnType="struct">
		<cfargument name="recordStruct" type="struct" required="true"> 
		<cfargument name="currentPage" type="numeric" required="true"> 
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.records = ARGUMENTS.recordStruct.records />
		<cfset LOCAL.totalCount = ARGUMENTS.recordStruct.totalCount />
		<cfset LOCAL.totalPages = ARGUMENTS.recordStruct.totalPages />
		
		<cfset LOCAL.currentPage = ARGUMENTS.currentPage />
		
		<cfset LOCAL.pageArray = _getPageArray(currentPage = LOCAL.currentPage, totalPages = LOCAL.totalPages) />
		
		<cfreturn LOCAL /> 
	</cffunction>
	
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getPageArray" access="private" output="false" returnType="array">
		<cfargument name="currentPage" type="string" required="true" />
		<cfargument name="totalPages" type="string" required="true" />
		
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.pageArray = [] />
		
		<cfif ARGUMENTS.currentPage GT 3 AND ARGUMENTS.totalPages GT 5>
			<cfset LOCAL.pageStruct = {} />
			<cfset LOCAL.pageStruct.number = "&laquo;" />
			<cfset LOCAL.pageStruct.link = "" />
			<cfset ArrayAppend(LOCAL.pageArray, LOCAL.pageStruct) />
		</cfif>
		
		<cfif ARGUMENTS.totalPages LTE 5>
			<cfset LOCAL.from = 1 />
			<cfset LOCAL.to = ARGUMENTS.totalPages />
		<cfelseif ARGUMENTS.totalPages GT 5 AND ARGUMENTS.currentPage LTE 3>
			<cfset LOCAL.from = 1 />
			<cfset LOCAL.to = 5 />
		<cfelseif ARGUMENTS.totalPages GT 5 AND ARGUMENTS.currentPage GT 3 AND ARGUMENTS.currentPage LTE (ARGUMENTS.totalPages - 3)>
			<cfset LOCAL.from = ARGUMENTS.currentPage - 2 />
			<cfset LOCAL.to = ARGUMENTS.currentPage + 2 />
		<cfelseif ARGUMENTS.totalPages GT 5 AND ARGUMENTS.currentPage GT (ARGUMENTS.totalPages - 3)> 
			<cfset LOCAL.from = ARGUMENTS.totalPages - 5 />
			<cfset LOCAL.to = ARGUMENTS.totalPages />
		</cfif>
		
		<cfloop from="#LOCAL.from#" to="#LOCAL.to#" index="LOCAL.i">
			<cfset LOCAL.pageStruct = {} />
			<cfset LOCAL.pageStruct.number = LOCAL.i />
			<cfset LOCAL.pageStruct.link = "" />
			<cfset ArrayAppend(LOCAL.pageArray, LOCAL.pageStruct) />
		</cfloop>
		
		<cfif ARGUMENTS.currentPage LT ARGUMENTS.totalPages-2 AND ARGUMENTS.totalPages GT 5>
			<cfset LOCAL.pageStruct = {} />
			<cfset LOCAL.pageStruct.number = "&raquo;" />
			<cfset LOCAL.pageStruct.link = "" />
			<cfset ArrayAppend(LOCAL.pageArray, LOCAL.pageStruct) />
		</cfif>
				
		<cfreturn LOCAL.pageArray />	
	</cffunction>
</cfcomponent>