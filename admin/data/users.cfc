<cfcomponent extends="master">
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Users | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.users = EntityLoad("user",{isDeleted=false}) />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>