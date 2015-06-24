<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif Trim(ListGetAt(CGI.PATH_INFO,1,"/")) NEQ "">
			<cfset LOCAL.pageData.content = EntityLoad("site_content",{name=LCase(Trim(ListGetAt(CGI.PATH_INFO,1,"/")))},true) />
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.content.getTitle()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.description = LOCAL.pageData.content.getDescription() />
			<cfset LOCAL.pageData.keywords = LOCAL.pageData.content.getKeywords() />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>