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
		
		<cfset LOCAL.currentPageName = "products" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.category = EntityLoadByPK("category", FORM.id)> 
			<cfset LOCAL.category.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.category.setUpdatedDatetime(Now()) />
			<cfset LOCAL.tab_id = FORM.tab_id />
			<cfset LOCAL.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.currentPage},true)> 
			<cfset LOCAL.bestSellerSection = EntityLoad("page_section", {name="best seller",page=LOCAL.currentPage},true)> 
		<cfelse>
			<cfset LOCAL.category = EntityNew("category")> 
			<cfset LOCAL.category.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.category.setCreatedDatetime(Now()) />
			<cfset LOCAL.category.setIsDeleted(false) />
			<cfset LOCAL.tab_id = "tab_1" />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfif FORM.parent_category_id NEQ "">
				<cfset LOCAL.category.setParentCategory(EntityLoadByPK("category",FORM.parent_category_id)) />
			</cfif>
			<cfset LOCAL.category.setName(Trim(FORM.display_name)) />
			<cfset LOCAL.category.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.category.setRank(Trim(FORM.rank)) />
			<cfset LOCAL.category.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.category.setDisplayCategoryList(FORM.display_category_list) />
			<cfset LOCAL.category.setDisplayCustomDesign(FORM.display_custom_design) />
			<cfset LOCAL.category.setShowCategoryOnNavigation(FORM.show_category_on_navigation) />
			<cfset LOCAL.category.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.category.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.category.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.category.setCustomDesign(Trim(FORM.custom_design)) />
			
			<cfif FORM.filter_group_id NEQ "">
				<cfif 	IsNull(LOCAL.category.getFilterGroup())
						OR
						(NOT IsNull(LOCAL.category.getFilterGroup()) AND FORM.filter_group_id NEQ LOCAL.category.getFilterGroup().getFilterGroupId())>
					<cfset LOCAL.category.removeAllCategoryFilterRelas() />
					<cfset LOCAL.category.setFilterGroup(EntityLoadByPK("filter_group",FORM.filter_group_id)) />
					
					<cfloop array="#LOCAL.category.getFilterGroup().getFilters()#" index="LOCAL.filter">
						<cfset LOCAL.newCategoryFilterRela = EntityNew("category_filter_rela") />
						<cfset LOCAL.newCategoryFilterRela.setCategory(LOCAL.category) />
						<cfset LOCAL.newCategoryFilterRela.setFilter(LOCAL.filter) />
						<cfset EntitySave(LOCAL.newCategoryFilterRela) />
						
						<cfset LOCAL.category.addCategoryFilterRela(LOCAL.newCategoryFilterRela) />
					</cfloop>
				</cfif>
			</cfif>
		
			<!--- to get the category id for image path, extra entitysave here --->
			<cfset EntitySave(LOCAL.category) />
		
			<cfif NOT IsNull(LOCAL.category.getImages())>
				<cfloop array="#LOCAL.category.getImages()#" index="LOCAL.img">
					<cfif IsNumeric(FORM["rank_#LOCAL.img.getCategoryImageId()#"])>
						<cfset LOCAL.img.setRank(FORM["rank_#LOCAL.img.getCategoryImageId()#"]) />
						<cfset EntitySave(LOCAL.img) />
					</cfif>
				</cfloop>
			</cfif>
		
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
							<cfset LOCAL.categoryImage.setIsDefault(false) />
							<cfset EntitySave(LOCAL.categoryImage) />
							<cfset LOCAL.category.addImage(LOCAL.categoryImage) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(FORM,"default_image_id") AND FORM.default_image_id NEQ "">
				<cfset LOCAL.currentDefaultImage = EntityLoad("category_image",{category=LOCAL.category,isDefault=true},true) />
				<cfif NOT IsNull(LOCAL.currentDefaultImage)>
					<cfset LOCAL.currentDefaultImage.setIsDefault(false) />
					<cfset EntitySave(LOCAL.currentDefaultImage) />
				</cfif>
				<cfset LOCAL.newDefaultImage = EntityLoadByPK("category_image", FORM.default_image_id) />
				<cfset LOCAL.newDefaultImage.setIsDefault(true) />
				<cfset EntitySave(LOCAL.newDefaultImage) />
			</cfif>
			
			<cfif NOT IsNull(LOCAL.advertisementSection.getAdvertisements())>
				<cfloop array="#LOCAL.advertisementSection.getAdvertisements()#" index="LOCAL.ad">
					<cfif IsNumeric(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"])>
						<cfset LOCAL.ad.setRank(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif NOT IsNull(LOCAL.bestSellerSection.getProducts())>
				<cfloop array="#LOCAL.bestSellerSection.getProducts()#" index="LOCAL.sectionProduct">
					<cfif IsNumeric(FORM["best_seller_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"])>
						<cfset LOCAL.sectionProduct.setRank(FORM["best_seller_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"]) />
						<cfset EntitySave(LOCAL.sectionProduct) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.category) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Category has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=#LOCAL.tab_id#" />
		
		<cfelseif StructKeyExists(FORM,"delete_item")>
		
			<cfset LOCAL.category.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.category) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Category: #LOCAL.category.getDisplayName()# has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/categories.cfm" />
		
		<cfelseif StructKeyExists(FORM,"delete_image")>
		
			<cfset LOCAL.image = EntityLoadByPK("category_image",FORM.deleted_image_id) />
			<cfset LOCAL.category.removeImage(LOCAL.image) />
			<cfset EntitySave(LOCAL.category) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_5" />
		
		<cfelseif StructKeyExists(FORM,"add_new_filter_value")>
		
			<cfset LOCAL.categoryFilterRela = EntityLoadByPK("category_filter_rela", FORM.new_filter_value_category_filter_rela_id)>
							
			<cfset LOCAL.filterValue = EntityNew("filter_value") />
			<cfset LOCAL.filterValue.setValue(FORM.new_filter_value) />
			<cfset LOCAL.filterValue.setDisplayName(FORM.new_filter_display_name) />
			<cfset EntitySave(LOCAL.filterValue) />
			
			<cfset LOCAL.categoryFilterRela.addFilterValue(LOCAL.filterValue) />
			<cfset EntitySave(LOCAL.categoryFilterRela) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New filter value: #FORM.new_filter_value# has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_3" />
			
		<cfelseif StructKeyExists(FORM,"delete_filter_value")>
			
			<cfset LOCAL.filterValue = EntityLoadByPK("filter_value",FORM.deleted_filter_value_id) />		
			<cfset LOCAL.categoryFilterRela = LOCAL.filterValue.getCategoryFilterRela() />
			<cfset LOCAL.categoryFilterRela.removeFilterValue(LOCAL.filterValue) />
			<cfset EntitySave(LOCAL.categoryFilterRela) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Filter value: #LOCAL.filterValue.getValue()# has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_3" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.filterGroups = EntityLoad("filter_group")> 
		<cfset LOCAL.pageData.relatedProductGroups = EntityLoad("related_product_group") />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.category = EntityLoadByPK("category", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.category.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			
			<cfset LOCAL.categoryService.setId(URL.id) />
			<cfif StructKeyExists(URL,"page") AND IsNumeric(Trim(URL.page))>
				<cfset LOCAL.categoryService.setPageNumber(Trim(URL.page)) />
			</cfif>
			<cfset LOCAL.recordStruct = LOCAL.categoryService.getProducts() />
			<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(LOCAL.recordStruct) />
			
			<cfset LOCAL.currentPageName = "products" />
			<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name = LOCAL.currentPageName},true)>
			<cfset LOCAL.pageData.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.pageData.currentPage},true)> 
			<cfset LOCAL.pageData.bestSellerSection = EntityLoad("page_section", {name="best seller",page=LOCAL.pageData.currentPage},true)> 
						
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.category.getDisplayName())?"":LOCAL.pageData.category.getDisplayName() />
				<cfset LOCAL.pageData.formData.parent_category_id = isNull(LOCAL.pageData.category.getParentCategory())?"":LOCAL.pageData.category.getParentCategory().getCategoryId() />
				<cfset LOCAL.pageData.formData.rank = isNull(LOCAL.pageData.category.getRank())?"":LOCAL.pageData.category.getRank() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.category.getIsEnabled())?"":LOCAL.pageData.category.getIsEnabled() />
				<cfset LOCAL.pageData.formData.display_category_list = isNull(LOCAL.pageData.category.getDisplayCategoryList())?"":LOCAL.pageData.category.getDisplayCategoryList() />
				<cfset LOCAL.pageData.formData.display_custom_design = isNull(LOCAL.pageData.category.getDisplayCustomDesign())?"":LOCAL.pageData.category.getDisplayCustomDesign() />
				<cfset LOCAL.pageData.formData.show_category_on_navigation = isNull(LOCAL.pageData.category.getShowCategoryOnNavigation())?"":LOCAL.pageData.category.getShowCategoryOnNavigation() />
				<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.category.getTitle())?"":LOCAL.pageData.category.getTitle() />
				<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.category.getKeywords())?"":LOCAL.pageData.category.getKeywords() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.category.getDescription())?"":LOCAL.pageData.category.getDescription() />
				<cfset LOCAL.pageData.formData.filter_group_id = isNull(LOCAL.pageData.category.getFilterGroup())?"":LOCAL.pageData.category.getFilterGroup().getFilterGroupId() />
				<cfset LOCAL.pageData.formData.custom_design = isNull(LOCAL.pageData.category.getCustomDesign())?"":LOCAL.pageData.category.getCustomDesign() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Category | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.parent_category_id = "" />
				<cfset LOCAL.pageData.formData.rank = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.display_category_list = "" />
				<cfset LOCAL.pageData.formData.display_custom_design = "" />
				<cfset LOCAL.pageData.formData.show_category_on_navigation = "" />
				<cfset LOCAL.pageData.formData.title = "" />
				<cfset LOCAL.pageData.formData.keywords = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.filter_group_id = "" />
				<cfset LOCAL.pageData.formData.custom_design = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>