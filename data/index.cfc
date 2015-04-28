<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.page = EntityLoad("page", {name=getPageName()},true)> 
		
		<cfif NOT IsNull(LOCAL.pageData.page)>
			<cfset LOCAL.pageData.title = LOCAL.pageData.page.getTitle() />
			<cfset LOCAL.pageData.description = LOCAL.pageData.page.getDescription() />
			<cfset LOCAL.pageData.keywords = LOCAL.pageData.page.getKeywords() />
			
			<cfset LOCAL.pageData.slideSection = EntityLoad("section", {name="slide",page=LOCAL.pageData.page},true)>
			
			<cfif NOT IsNull(LOCAL.pageData.slideSection)>
				<cfset LOCAL.pageData.slideContent = LOCAL.pageData.slideSection.getContent() />
			<cfelse>
				<cfset LOCAL.pageData.slideContent = "" />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "" />
			<cfset LOCAL.pageData.description = "" />
			<cfset LOCAL.pageData.keywords = "" />
			<cfset LOCAL.pageData.slideContent = "" />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>