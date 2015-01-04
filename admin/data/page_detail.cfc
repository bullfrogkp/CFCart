<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
		
		<cfset LOCAL.page_detail = EntityLoad("site_pages",URL.site_page_id,true) />
		
		<cfset LOCAL.page_data.site_page_id = LOCAL.page_detail.getsite_page_id() />
		<cfset LOCAL.page_data.site_page_display_name = LOCAL.page_detail.getsite_page_display_name() />
		<cfset LOCAL.page_data.site_page_title = LOCAL.page_detail.getsite_page_title() />
		<cfset LOCAL.page_data.site_page_keywords = LOCAL.page_detail.getsite_page_keywords() />
		<cfset LOCAL.page_data.site_page_description = LOCAL.page_detail.getsite_page_description() />
		<cfset LOCAL.page_data.site_page_content = LOCAL.page_detail.getsite_page_content() />
	
		<cfreturn LOCAL.page_data />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfset LOCAL.site_page = EntityLoad("site_pages",FORM.site_page_id,true) />
		<cfset LOCAL.site_page.setSite_page_title(FORM.site_page_title) />
		<cfset LOCAL.site_page.setSite_page_keywords(FORM.site_page_keywords) />
		<cfset LOCAL.site_page.setSite_page_description(FORM.site_page_description) />
		<cfset LOCAL.site_page.setSite_page_content(FORM.site_page_content) />
		
		<cfset EntitySave(LOCAL.site_page) />
		<cfset ormflush() />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>