<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset SESSION.temp.message = "Please enter a valid product name." />
			<cfset SESSION.temp.message_type = "alert-danger" />
			
			<cfif StructKeyExists(URL,"product_id") AND IsNumeric(URL.product_id)>	
				<cfif StructKeyExists(URL,"active_tab_id")>	
					<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?product_id=#URL.product_id#&active_tab_id=#URL.active_tab_id#" />
				<cfelse>
					<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?product_id=#URL.product_id#" />
				</cfif>
			<cfelse>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"save_product")>
			<cfif IsNumeric(FORM.product_id)>
				<cfset LOCAL.product = EntityLoad("product", FORM.product_id, true)> 
				<cfset LOCAL.tab_id = FORM.tab_id />
			<cfelse>
				<cfset LOCAL.product = EntityNew("product") />
				<cfset LOCAL.tab_id = "tab_1" />
			</cfif>
			
			<cfset LOCAL.product.setParentproductId(FORM.parent_product_id) />
			<cfset LOCAL.product.setName(Trim(FORM.display_name)) />
			<cfset LOCAL.product.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.product.setRank(Trim(FORM.rank)) />
			<cfset LOCAL.product.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.product.setShowproductOnNavigation(FORM.show_product_on_navigation) />
			<cfset LOCAL.product.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.product.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.product.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.product.setCustomDesign(Trim(FORM.custom_design)) />
			<cfset LOCAL.product.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.product.setUpdatedUser(SESSION.adminUser) />
			<cfif StructKeyExists(FORM,"filter_group_id")>
				<cfset LOCAL.product.setFilterGroupId(FORM.filter_group_id) />
			</cfif>
		
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlWeb#admin/uploads/product/") />
						
							<cfset LOCAL.imageDir = LOCAL.imagePath & LOCAL.product.getCategoryId() />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>
							
							<cffile action = "move" source = "#LOCAL.imagePath##LOCAL.imgName#" destination = "#LOCAL.imagePath##LOCAL.product.getCategoryId()#\#LOCAL.imgName#">
						
							<cfset LOCAL.productImage = EntityNew("product_image") />
							<cfset LOCAL.productImage.setName(LOCAL.imgName) />
							<cfset EntitySave(LOCAL.productImage) />
							<cfset LOCAL.product.addImages(LOCAL.productImage) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.product) />
			
			<cfset SESSION.temp.message = "Category has been saved successfully." />
			<cfset SESSION.temp.message_type = "alert-success" />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?product_id=#LOCAL.product.getCategoryId()#&active_tab_id=#LOCAL.tab_id#" />
		<cfelseif StructKeyExists(FORM,"delete_product")>
			<cfset LOCAL.product = EntityLoad("product", FORM.product_id, true)> 
			<cfset LOCAL.product.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.product) />
			
			<cfset SESSION.temp.message = "Category: #LOCAL.product.getDisplayName()# has been deleted." />
			<cfset SESSION.temp.message_type = "alert-success" />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/categories.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		<cfset LOCAL.customerService = new "#APPLICATION.componentPathRoot#core.services.customerService"() />
		
		<cfif StructKeyExists(URL,"product_id") AND IsNumeric(URL.product_id)>
			<cfset LOCAL.pageData.product = EntityLoad("product", URL.product_id, true)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
		<cfelse>
			<cfset LOCAL.pageData.product = EntityNew("product") />
			<cfset LOCAL.pageData.title = "New Product | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
		</cfif>
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.customerGroups = LOCAL.customerService.getCustomerGroups() />
		<cfset LOCAL.pageData.taxCategories = LOCAL.taxService.getTaxCategories() />
		<cfset LOCAL.pageData.attributeSets = LOCAL.attributeSetService.getAttributeSets() />
		<cfset LOCAL.pageData.attributeValueSet = LOCAL.attributeSetService.getAttributeValueSets() />
					
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
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.product.getDisplayName())?"":LOCAL.pageData.product.getDisplayName() />
			<cfset LOCAL.pageData.formData.sku = isNull(LOCAL.pageData.product.getSku())?"":LOCAL.pageData.product.getSku() />
			<cfset LOCAL.pageData.formData.price = isNull(LOCAL.pageData.product.getPrice())?"":LOCAL.pageData.product.getPrice() />
			<cfset LOCAL.pageData.formData.special_price = isNull(LOCAL.pageData.product.getSpecialPrice())?"":LOCAL.pageData.product.getSpecialPrice() />
			<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.product.getIsEnabled())?"":LOCAL.pageData.product.getIsEnabled() />
			<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.product.getTitle())?"":LOCAL.pageData.product.getTitle() />
			<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.product.getKeywords())?"":LOCAL.pageData.product.getKeywords() />
			<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.product.getDescription())?"":LOCAL.pageData.product.getDescription() />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>