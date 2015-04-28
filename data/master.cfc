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
	
	<cffunction name="loadMetaData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.metaData = {} />
				
		<cfset LOCAL.page = EntityLoad("page", {name=getPageName()},true)> 
		
		<cfif NOT IsNull(LOCAL.page)>
			<cfset LOCAL.metaData.title = LOCAL.page.getTitle() />
			<cfset LOCAL.metaData.description = LOCAL.page.getDescription() />
			<cfset LOCAL.metaData.keywords = LOCAL.page.getKeywords() />
		<cfelse>
			<cfset LOCAL.metaData.title = "" />
			<cfset LOCAL.metaData.description = "" />
			<cfset LOCAL.metaData.keywords = "" />
		</cfif>		
				
		<cfreturn LOCAL.metaData />	
	</cffunction>
</cfcomponent>