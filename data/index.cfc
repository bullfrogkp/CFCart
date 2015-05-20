<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name=getPageName()},true)> 
		
		<cfset LOCAL.pageData.title = LOCAL.pageData.currentPage.getTitle() />
		<cfset LOCAL.pageData.description = LOCAL.pageData.currentPage.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.currentPage.getKeywords() />
		
		<cfif NOT IsNull(LOCAL.pageData.slideSection)>
			<cfset LOCAL.pageData.slideContent = LOCAL.pageData.slideSection.getContent() />
		<cfelse>
			<cfset LOCAL.pageData.slideContent = "" />
		</cfif>
		
		<cfif Trim(LOCAL.pageData.title) EQ "">
			<cfset LOCAL.pageData.title = "Home | #APPLICATION.applicationName#" />
		</cfif>
		
		<cfset LOCAL.pageData.slideSection = EntityLoad("page_section", {name="slide",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.topSellingSection = EntityLoad("page_section", {name="top selling",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.groupBuyingSection = EntityLoad("page_section", {name="group buying",page=LOCAL.pageData.currentPage},true)> 
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>