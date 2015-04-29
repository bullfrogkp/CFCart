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
		
		<cfif LOCAL.pageData.title EQ "">
			<cfset LOCAL.pageData.title = "Home | #APPLICATION.applicationName#" />
		</cfif>
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.homepageAds = EntityLoad("homepage_ad",{isDeleted=false},"rank asc") />	
		<cfset LOCAL.pageData.topSellings = EntityLoad("top_selling",{},"rank asc") />	
		<cfset LOCAL.pageData.groupBuyings = EntityLoad("group_buying",{},"rank asc") />
		
		<cfset LOCAL.pageData.topSellingCategory = EntityLoad("category",{displayName="Top Selling"},true) />
		<cfset LOCAL.pageData.groupBuyingCategory = EntityLoad("category",{displayName="Group Buying"},true) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>