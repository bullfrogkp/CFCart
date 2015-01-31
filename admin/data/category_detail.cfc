<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfset LOCAL.new_category = EntityNew("category") />
		<cfif IsNumeric(FORM.category_id)>
			<cfset LOCAL.new_category.setCategoryId(FORM.category_id) />
		</cfif>
		<cfset LOCAL.new_category.setParentCategoryId(FORM.parent_category_id) />
		<cfset LOCAL.new_category.setCategoryName(Trim(FORM.category_display_name)) />
		<cfset LOCAL.new_category.setCategoryDisplayName(Trim(FORM.category_display_name)) />
		<cfset LOCAL.new_category.setRank(Trim(FORM.rank)) />
		<cfset LOCAL.new_category.setCategoryIsEnabled(FORM.category_is_enabled) />
		<cfset LOCAL.new_category.setShowCategoryOnNav(FORM.show_category_on_nav) />
		<cfset LOCAL.new_category.setCategoryTitle(Trim(FORM.category_title)) />
		<cfset LOCAL.new_category.setCategoryKeywords(Trim(FORM.category_keywords)) />
		<cfset LOCAL.new_category.setCategoryDescription(Trim(FORM.category_description)) />
		<cfset LOCAL.new_category.setCategoryCustomDesign(Trim(FORM.category_custom_design)) />
		<cfset LOCAL.new_category.setCreateDatetime(Now()) />
		<cfset LOCAL.new_category.setCreateUser(SESSION.admin_user) />
		<cfset LOCAL.new_category.setUpdateDatetime(Now()) />
		<cfset LOCAL.new_category.setUpdateUser(SESSION.admin_user) />
		<cfset LOCAL.new_category.setFilterGroupId(FORM.filter_group_id) />
		
		<cfset EntitySave(LOCAL.new_category) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
		
		<cfset LOCAL.page_data.title = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.page_data.keywords = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.page_data.description = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfreturn LOCAL.page_data />	
	</cffunction>
</cfcomponent>