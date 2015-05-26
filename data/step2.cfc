<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		<cfdump var="#FORM#" abort>	
		
		
		<cfreturn LOCAL />
	</cffunction>
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Shipping Information | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfdump var="#FORM#" abort>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/confirmation.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>