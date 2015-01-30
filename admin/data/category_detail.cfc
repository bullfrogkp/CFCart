<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfset LOCAL.new_category = EntityNew("category") />
		<cfset LOCAL.new_category.setCategoryId(FORM.category_id) />
		<cfset LOCAL.new_category.setParentCategoryId(FORM.category_id) />
		<cfset LOCAL.new_category.setCategoryName(FORM.category_id) />
		<cfset LOCAL.new_category.setCategoryDisplayName(FORM.category_id) />
		<cfset LOCAL.new_category.setRank(FORM.category_id) />
		<cfset LOCAL.new_category.setCategoryIsEnabled(FORM.category_id) />
		<cfset LOCAL.new_category.setShowCategoryOnNav(FORM.category_id) />
		<cfset LOCAL.new_category.setCategoryTitle(FORM.category_id) />
		<cfset LOCAL.new_category.setCategoryKeywords(FORM.category_id) />
		<cfset LOCAL.new_category.setCategoryDescription(FORM.category_id) />
		<cfset LOCAL.new_category.setCategoryCustomDesign(FORM.category_id) />
		<cfset LOCAL.new_category.setCreateDatetime(FORM.category_id) />
		<cfset LOCAL.new_category.setCreateUser(FORM.category_id) />
		<cfset LOCAL.new_category.setUpdateDatetime(FORM.category_id) />
		<cfset LOCAL.new_category.setUpdateUser(FORM.category_id) />
		
		<cfset EntitySave(LOCAL.new_category) />
     
		<cfloop list="#FORM.filters#" index="LOCAL.i">
		
			<cfset LOCAL.new_filter = EntityNew("filter") />
			<cfset LOCAL.new_filter.setName(LOCAL.i.name) />
			<cfset LOCAL.new_filter.setValue(LOCAL.i.value) />
			
			<cfset EntitySave(LOCAL.new_filter) />
		</cfloop>
		
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