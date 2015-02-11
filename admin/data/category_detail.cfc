<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"save_category")>
			<cfif IsNumeric(FORM.category_id)>
				<cfset LOCAL.category = EntityLoad("category", FORM.category_id, true)> 
				<cfset LOCAL.tab_id = FORM.tab_id />
			<cfelse>
				<cfset LOCAL.category = EntityNew("category") />
				<cfset LOCAL.tab_id = "tab_1" />
			</cfif>
			
			<cfset LOCAL.category.setParentCategoryId(FORM.parent_category_id) />
			<cfset LOCAL.category.setName(Trim(FORM.display_name)) />
			<cfset LOCAL.category.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.category.setRank(Trim(FORM.rank)) />
			<cfset LOCAL.category.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.category.setShowCategoryOnNavigation(FORM.show_category_on_navigation) />
			<cfset LOCAL.category.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.category.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.category.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.category.setCustomDesign(Trim(FORM.custom_design)) />
			<cfset LOCAL.category.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.category.setUpdatedUser(SESSION.adminUser) />
			<cfif StructKeyExists(FORM,"filter_group_id")>
				<cfset LOCAL.category.setFilterGroupId(FORM.filter_group_id) />
			</cfif>
		
			<cfif SESSION.temp.formdata["uploader_count"] NEQ 0>
				<cfloop collection="#SESSION.temp.formdata#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(SESSION.temp.formdata,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(SESSION.temp.formdata,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlWeb#admin/uploads/category/") />
						
							<cfset LOCAL.imageDir = LOCAL.imagePath & LOCAL.category.getCategoryId() />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>
							
							<cffile action = "move" source = "#LOCAL.imagePath##LOCAL.imgName#" destination = "#LOCAL.imagePath##LOCAL.category.getCategoryId()#\#LOCAL.imgName#">
						
							<cfset LOCAL.categoryImage = EntityNew("category_image") />
							<cfset LOCAL.categoryImage.setName(LOCAL.imgName) />
							<cfset EntitySave(LOCAL.categoryImage) />
							<cfset LOCAL.category.addImages(LOCAL.categoryImage) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.category) />
			
			<cfset SESSION.temp.message = "Category has been saved successfully." />
			<cfset SESSION.temp.message_type = "alert-success" />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/category_detail.cfm?category_id=#LOCAL.category.getCategoryId()#&active_tab_id=#LOCAL.tab_id#" />
		<cfelseif StructKeyExists(FORM,"delete_category")>
			<cfset LOCAL.category = EntityLoad("category", FORM.category_id, true)> 
			<cfset LOCAL.category.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.category) />
			
			<cfset SESSION.temp.message = "Category: #LOCAL.category.getDisplayName()# has been deleted." />
			<cfset SESSION.temp.message_type = "alert-success" />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/categories.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		
		<cfif StructKeyExists(URL,"category_id") AND IsNumeric(URL.category_id)>
			<cfset LOCAL.pageData.category = EntityLoad("category", URL.category_id, true)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.category.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
		<cfelse>
			<cfset LOCAL.pageData.category = EntityNew("category") />
			<cfset LOCAL.pageData.title = "New Category | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
		</cfif>
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.filterGroups = EntityLoad("filter_group",{isEnabled = true, isDeleted = false}, "displayName ASC")> 
		
		<cfset LOCAL.pageData.filterGroup = EntityLoad("filter_group",{filterGroupId = LOCAL.pageData.category.getFilterGroupId()}, true) />
		<cfset LOCAL.pageData.categoryImages = LOCAL.pageData.category.getImages() />
					
		<cfset LOCAL.pageData.tabs = {} />
		<cfset LOCAL.pageData.tabs["tab_1"] = "" />
		<cfset LOCAL.pageData.tabs["tab_2"] = "" />
		<cfset LOCAL.pageData.tabs["tab_3"] = "" />
		<cfset LOCAL.pageData.tabs["tab_4"] = "" />
		<cfset LOCAL.pageData.tabs["tab_5"] = "" />
		<cfset LOCAL.pageData.tabs["tab_6"] = "" />
		<cfset LOCAL.pageData.tabs["tab_7"] = "" />
				
		<cfif StructKeyExists(URL,"active_tab_id")>	
			<cfset LOCAL.pageData.activeTabId = URL.active_tab_id />
			<cfset LOCAL.pageData.tabs["#LOCAL.pageData.activeTabId#"] = "active" />
		<cfelse>
			<cfset LOCAL.pageData.activeTabId = "tab_1" />
			<cfset LOCAL.pageData.tabs["tab_1"] = "active" />
		</cfif>
		
		<cfif IsDefined("SESSION.temp.message")>
			<cfset LOCAL.pageData.message = SESSION.temp.message />
			<cfset LOCAL.pageData.message_type = SESSION.temp.message_type />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>