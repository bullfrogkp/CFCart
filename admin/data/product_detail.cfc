<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid product name.") />
		</cfif>
		
		<cfif Trim(FORM.sku) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid SKU.") />
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
		
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfif IsNumeric(FORM.id)>
				<cfset LOCAL.product = EntityLoad("product", FORM.id, true)> 
				<cfset LOCAL.tab_id = FORM.tab_id />
			<cfelse>
				<cfset LOCAL.product = EntityNew("product") />
				<cfset LOCAL.product.setCreatedUser(SESSION.adminUser) />
				<cfset LOCAL.tab_id = "tab_1" />
			</cfif>
			
			<cfset LOCAL.product.setName(Trim(FORM.display_name)) />
			<cfset LOCAL.product.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.product.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.product.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.product.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.product.setDescription(Trim(FORM.description)) />
			<cfif StructKeyExists(FORM,"shipping_method_id")>
				<cfset LOCAL.product.setShippingMethodId(FORM.shipping_method_id) />
			</cfif>
			<cfset LOCAL.product.setUpdatedUser(SESSION.adminUser) />
			<cfif StructKeyExists(FORM,"attribute_set_id")>
				<cfset LOCAL.product.setAttributeSetId(FORM.attribute_set_id) />
			</cfif>
			
			<cfset LOCAL.product.removeAllCategories() />
			
			<cfloop list="#FORM.category_id#" index="LOCAL.categoryId">
				<cfset LOCAL.newCategory = EntityLoad("category",LOCAL.categoryId,true) />
				<cfset LOCAL.product.addCategory(LOCAL.newCategory) />
			</cfloop>
		
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlWeb#admin/uploads/product/") />
						
							<cfset LOCAL.imageDir = LOCAL.imagePath & LOCAL.product.getProductId() />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>
							
							<cffile action = "move" source = "#LOCAL.imagePath##LOCAL.imgName#" destination = "#LOCAL.imagePath##LOCAL.product.getProductId()#\#LOCAL.imgName#">
						
							<cfset LOCAL.productImage = EntityNew("product_image") />
							<cfset LOCAL.productImage.setName(LOCAL.imgName) />
							<cfset EntitySave(LOCAL.productImage) />
							<cfset LOCAL.product.addImages(LOCAL.productImage) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_group_price) AND ListLen(FORM.new_customer_group_id) NEQ 0>
				<cfloop list="#FORM.new_customer_group_id#" index="LOCAL.customerGroupId">
					<cfset LOCAL.groupPrice = EntityNew("product_customer_group_rela") />
					<cfset LOCAL.groupPrice.setProductId(LOCAL.product.getProductId()) />
					<cfset LOCAL.groupPrice.setCustomerGroupId(LOCAL.customerGroupId) />
					<cfset LOCAL.groupPrice.setPrice(FORM.new_group_price) />
					
					<cfset EntitySave(LOCAL.groupPrice) />
				</cfloop>
			</cfif>
			
			<cfset LOCAL.productService.setProductId(LOCAL.product.getProductId()) />
			<cfset LOCAL.groupPrices = LOCAL.productService.getProductGroupPrices() />
			
			<cfloop array="#LOCAL.groupPrices#" index="groupPrice">
				<cfif StructKeyExists(FORM,"delete_group_price_#groupPrice.getCustomerGroupId()#")>
					<cfset LOCAL.productCustomerGroupRela = EntityLoad('product_customer_group_rela', {price = groupPrice.getPrice()})> 
					<cfloop array="#LOCAL.productCustomerGroupRela#" index="LOCAL.rela">
						<cfset EntityDelete(LOCAL.rela) />
					</cfloop>
				</cfif>
			</cfloop>
			
			<cfset EntitySave(LOCAL.product) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=#LOCAL.tab_id#" />
		<cfelseif StructKeyExists(FORM,"delete_item")>
			<cfset LOCAL.product = EntityLoad("product", FORM.id, true)> 
			<cfset LOCAL.product.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.product) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product #LOCAL.product.getDisplayName()# has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/products.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.productService.setProductId(URL.id) />
			<cfset LOCAL.pageData.product = EntityLoad("product", URL.id, true)> 
			<cfset LOCAL.productService.setAttributeSetId(LOCAL.pageData.product.getAttributeSetId()) />
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			<cfset LOCAL.pageData.groupPrices = LOCAL.productService.getProductGroupPrices() />
			<cfset LOCAL.pageData.attributes = LOCAL.productService.getProductAttributes() />
		<cfelse>
			<cfset LOCAL.pageData.product = EntityNew("product") />
			<cfset LOCAL.pageData.title = "New Product | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
		</cfif>
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.categories = LOCAL.categoryService.getCategories() />
		<cfset LOCAL.pageData.customerGroups = EntityLoad("customer_group") />
		<cfset LOCAL.pageData.taxCategories = EntityLoad("tax_category") />
		<cfset LOCAL.pageData.attributeSets = EntityLoad("attribute_set") />
		<cfset LOCAL.pageData.shippingMethods = EntityLoad("shipping_method") />
				
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.product.getDisplayName())?"":LOCAL.pageData.product.getDisplayName() />
			<cfset LOCAL.pageData.formData.detail = isNull(LOCAL.pageData.product.getDetail())?"":LOCAL.pageData.product.getDetail() />
			<cfset LOCAL.pageData.formData.sku = isNull(LOCAL.pageData.product.getSku())?"":LOCAL.pageData.product.getSku() />
			<cfset LOCAL.pageData.formData.price = isNull(LOCAL.pageData.product.getPrice())?"":LOCAL.pageData.product.getPrice() />
			<cfset LOCAL.pageData.formData.special_price = isNull(LOCAL.pageData.product.getSpecialPrice())?"":LOCAL.pageData.product.getSpecialPrice() />
			<cfset LOCAL.pageData.formData.from_date = isNull(LOCAL.pageData.product.getSpecialPriceFromDate())?"":DateFormat(LOCAL.pageData.product.getSpecialPriceFromDate(),"mm/dd/yyyy") />
			<cfset LOCAL.pageData.formData.to_date = isNull(LOCAL.pageData.product.getSpecialPriceToDate())?"":DateFormat(LOCAL.pageData.product.getSpecialPriceToDate(),"mm/dd/yyyy") />
			<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.product.getIsEnabled())?"":LOCAL.pageData.product.getIsEnabled() />
			<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.product.getTitle())?"":LOCAL.pageData.product.getTitle() />
			<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.product.getKeywords())?"":LOCAL.pageData.product.getKeywords() />
			<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.product.getDescription())?"":LOCAL.pageData.product.getDescription() />
			<cfset LOCAL.pageData.formData.shipping_method_id = isNull(LOCAL.pageData.product.getShippingMethodId())?"":LOCAL.pageData.product.getShippingMethodId() />
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>