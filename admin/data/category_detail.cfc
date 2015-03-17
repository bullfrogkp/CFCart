<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid category name.") />
		</cfif>
		
		<cfif NOT IsNumeric(Trim(FORM.rank))>
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid rank number.") />
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = _setRedirectURL() />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif StructKeyExists(FORM,"save_category")>
			<cfif IsNumeric(FORM.id)>
				<cfset LOCAL.category = EntityLoadByPK("category", FORM.id)>
				<cfset LOCAL.tab_id = FORM.tab_id />
			<cfelse>
				<cfset LOCAL.category = EntityNew("category") />
				<cfset LOCAL.tab_id = "tab_1" />
			</cfif>
			
			<cfif FORM.parent_category_id NEQ "">
				<cfset LOCAL.category.setParentCategory(EntityLoadByPK("category",FORM.parent_category_id)) />
			</cfif>
			<cfset LOCAL.category.setName(Trim(FORM.display_name)) />
			<cfset LOCAL.category.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.category.setRank(Trim(FORM.rank)) />
			<cfset LOCAL.category.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.category.setIsDeleted(false) />
			<cfset LOCAL.category.setShowCategoryOnNavigation(FORM.show_category_on_navigation) />
			<cfset LOCAL.category.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.category.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.category.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.category.setCustomDesign(Trim(FORM.custom_design)) />
			<cfset LOCAL.category.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.category.setUpdatedUser(SESSION.adminUser) />
			<cfif FORM.filter_group_id NEQ "">
				<cfif FORM.filter_group_id NEQ LOCAL.category.getFilterGroup().getFilterGroupId()>
					<cfset LOCAL.category.removeAllCategoryFilterRelas() />
				</cfif>
				<cfset LOCAL.category.setFilterGroup(EntityLoadByPK("filter_group",FORM.filter_group_id)) />
			</cfif>
		
			<!--- to get the category id for image path, extra entitysave here --->
			<cfset EntitySave(LOCAL.category) />
		
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlWeb#images/uploads/category/") />
						
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
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Category has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/category_detail.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=#LOCAL.tab_id#" />
		<cfelseif StructKeyExists(FORM,"delete_category")>
			<cfset LOCAL.category = EntityLoadByPK("category", FORM.id)> 
			<cfset LOCAL.category.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.category) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Category: #LOCAL.category.getDisplayName()# has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/categories.cfm" />
		<cfelseif StructKeyExists(FORM,"add_new_filter_value")>
		
			<cfset LOCAL.category = EntityLoadByPK("category",FORM.id) />
			<cfset LOCAL.filter = EntityLoadByPK("filter",FORM.new_value_filter_id) />
		
			<cfset LOCAL.categoryFilterRela = EntityLoad("category_filter_rela", {category = LOCAL.category, filter = LOCAL.filter},true)>
						
			<cfif IsNull(LOCAL.categoryFilterRela)>
				<cfset LOCAL.categoryFilterRela = EntityNew("category_filter_rela") /> />
				<cfset LOCAL.categoryFilterRela.setCategory(LOCAL.category) /> />
				<cfset LOCAL.categoryFilterRela.setFilter(LOCAL.filter) /> />
				
				<cfset EntitySave(LOCAL.categoryFilterRela) />
			</cfif>
			
			<cfset LOCAL.filterValue = EntityNew("filter_value") />
			<cfset LOCAL.filterValue.setValue(FORM.new_filter_value) />
			<cfset EntitySave(LOCAL.filterValue) />
			
			<cfset LOCAL.categoryFilterRela.addFilterValue(LOCAL.filterValue) />
			<cfset EntitySave(LOCAL.categoryFilterRela) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New filter value: #FORM.new_filter_value# has been added.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/category_detail.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_3" />
		<cfelseif StructKeyExists(FORM,"delete_filter_value")>
			<cfset LOCAL.category = EntityLoadByPK("category",FORM.id) />
			<cfset LOCAL.filterValue = EntityLoadByPK("filter_value",FORM.deleted_filter_value_id) />		
			<cfset LOCAL.categoryFilterRela = LOCAL.filterValue.getCategoryFilterRela() />
			<cfset LOCAL.categoryFilterRela.removeFilterValue(LOCAL.filterValue) />
			<cfset EntitySave(LOCAL.categoryFilterRela) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Filter value: #LOCAL.filterValue.getValue()# has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/category_detail.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_3" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.category = EntityLoadByPK("category", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.category.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			
			<cfset LOCAL.productService.setCategoryId(URL.id) />
			<cfset LOCAL.pageData.products = LOCAL.productService.getProducts() />
		<cfelse>
			<cfset LOCAL.pageData.category = EntityNew("category") />
			<cfset LOCAL.pageData.title = "New Category | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
		</cfif>
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.filterGroups = EntityLoad("filter_group")> 
		<cfif NOT IsNull(LOCAL.pageData.category.getFilterGroup())>
			<cfset LOCAL.pageData.filterValues = [] />
			<cfloop array="#LOCAL.pageData.category.getFilterGroup().getFilters()#" index="LOCAL.filter">
				<cfset LOCAL.filterValueStruct = {} />
				<cfset LOCAL.filterValueStruct.filterId = LOCAL.filter.getFilterId() />
				<cfset LOCAL.filterValueStruct.filterName = LOCAL.filter.getDisplayName() />
				<cfset LOCAL.categoryFilterRela = EntityLoad("category_filter_rela", {category = LOCAL.pageData.category, filter = EntityLoadByPK("filter",LOCAL.filter.getFilterId())},true)>
				
				<cfif NOT IsNull(LOCAL.categoryFilterRela)>
					<cfset LOCAL.filterValueStruct.filterValues = LOCAL.categoryFilterRela.getFilterValues() />
				<cfelse>
					<cfset LOCAL.filterValueStruct.filterValues = [] />
				</cfif>
				
				<cfset ArrayAppend(LOCAL.pageData.filterValues, LOCAL.filterValueStruct) />
			</cfloop>
		</cfif>
						
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.category.getDisplayName())?"":LOCAL.pageData.category.getDisplayName() />
			<cfset LOCAL.pageData.formData.parent_category_id = isNull(LOCAL.pageData.category.getParentCategory())?"":LOCAL.pageData.category.getParentCategory().getParentCategoryId() />
			<cfset LOCAL.pageData.formData.rank = isNull(LOCAL.pageData.category.getRank())?"":LOCAL.pageData.category.getRank() />
			<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.category.getIsEnabled())?"":LOCAL.pageData.category.getIsEnabled() />
			<cfset LOCAL.pageData.formData.show_category_on_navigation = isNull(LOCAL.pageData.category.getShowCategoryOnNavigation())?"":LOCAL.pageData.category.getShowCategoryOnNavigation() />
			<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.category.getTitle())?"":LOCAL.pageData.category.getTitle() />
			<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.category.getKeywords())?"":LOCAL.pageData.category.getKeywords() />
			<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.category.getDescription())?"":LOCAL.pageData.category.getDescription() />
			<cfset LOCAL.pageData.formData.filter_group_id = isNull(LOCAL.pageData.category.getFilterGroup())?"":LOCAL.pageData.category.getFilterGroup().getFilterGroupId() />
			<cfset LOCAL.pageData.formData.custom_design = isNull(LOCAL.pageData.category.getCustomDesign())?"":LOCAL.pageData.category.getCustomDesign() />
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>