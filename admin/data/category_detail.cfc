<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif IsNumeric(FORM.category_id)>
			<cfset LOCAL.category = EntityLoad("category", 1, true)> 
		<cfelse>
			<cfset LOCAL.category = EntityNew("category") />
		</cfif>
		
		<cfset LOCAL.category.setParentCategoryId(FORM.parent_category_id) />
		<cfset LOCAL.category.setCategoryName(Trim(FORM.category_display_name)) />
		<cfset LOCAL.category.setCategoryDisplayName(Trim(FORM.category_display_name)) />
		<cfset LOCAL.category.setRank(Trim(FORM.rank)) />
		<cfset LOCAL.category.setCategoryIsEnabled(FORM.category_is_enabled) />
		<cfset LOCAL.category.setShowCategoryOnNav(FORM.show_category_on_nav) />
		<cfset LOCAL.category.setCategoryTitle(Trim(FORM.category_title)) />
		<cfset LOCAL.category.setCategoryKeywords(Trim(FORM.category_keywords)) />
		<cfset LOCAL.category.setCategoryDescription(Trim(FORM.category_description)) />
		<cfset LOCAL.category.setCategoryCustomDesign(Trim(FORM.category_custom_design)) />
		<cfset LOCAL.category.setCreateDatetime(Now()) />
		<cfset LOCAL.category.setCreateUser(SESSION.adminUser) />
		<cfset LOCAL.category.setUpdateDatetime(Now()) />
		<cfset LOCAL.category.setUpdateUser(SESSION.adminUser) />
		<cfset LOCAL.category.setFilterGroupId(FORM.filter_group_id) />
		
		<cfset EntitySave(LOCAL.category) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.keywords = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>