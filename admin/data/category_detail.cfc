<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"save_category")>
			<cfif IsNumeric(FORM.category_id)>
				<cfset LOCAL.category = EntityLoad("category", FORM.category_id, true)> 
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
			<cfset LOCAL.category.setCreatedDatetime(Now()) />
			<cfset LOCAL.category.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.category.setUpdatedDatetime(Now()) />
			<cfset LOCAL.category.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.category.setFilterGroupId(FORM.filter_group_id) />
		
			<cfset EntitySave(LOCAL.category) />
		<cfelseif StructKeyExists(FORM,"delete_category")>
			<cfset LOCAL.category = EntityLoad("category", FORM.category_id, true)> 
			<cfset LOCAL.category.setCategoryIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.category) />
		</cfif>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/category_detail.cfm?category_id=#LOCAL.category.getCategoryId()#" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.keywords = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfif StructKeyExists(URL,"category_id") AND IsNumeric(URL.category_id)>
			<cfset LOCAL.pageData.category = EntityLoad("category", URL.category_id, true)> 
			<cfset LOCAL.pageData.allImages = EntityLoad("category_image", {imageIsDeleted = false})> 
		<cfelse>
			<cfset LOCAL.pageData.category = EntityNew("category") />
		</cfif>
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.filterGroups = EntityLoad("filter_group",{filterGroupIsEnabled = true, filterGroupIsDeleted = false}, "filterGroupDisplayName ASC")> 
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>