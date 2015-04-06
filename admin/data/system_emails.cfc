<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "System Emails | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.systemEmails = EntityLoad("system_email",{isDeleted = false}) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>