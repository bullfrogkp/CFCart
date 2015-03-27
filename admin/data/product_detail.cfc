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
		
		<cfif StructKeyExists(FORM,"add_new_product") AND NOT IsNumeric(FORM.new_product_id)>
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid product ID.") />
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
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.product = EntityLoadByPK("product", FORM.id)> 
			<cfset LOCAL.tab_id = FORM.tab_id />
		<cfelse>
			<cfset LOCAL.product = EntityNew("product") />
			<cfset LOCAL.product.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.product.setCreatedDatetime(Now()) />
			<cfset LOCAL.product.setIsDeleted(false) />
			<cfset LOCAL.tab_id = "tab_1" />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.product.setName(Trim(FORM.display_name)) />
			<cfset LOCAL.product.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.product.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.product.setPrice(Trim(FORM.price)) />
			<cfset LOCAL.product.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.product.setSku(Trim(FORM.sku)) />
			<cfset LOCAL.product.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.product.setDetail(Trim(FORM.detail)) />
			<cfset LOCAL.product.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.product.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.product.setUpdatedDatetime(Now()) />
			
			<cfif IsNumeric(Trim(FORM.length))>
				<cfset LOCAL.product.setLength(Trim(FORM.length)) />
			</cfif>
			<cfif IsNumeric(Trim(FORM.width))>
				<cfset LOCAL.product.setWidth(Trim(FORM.width)) />
			</cfif>
			<cfif IsNumeric(Trim(FORM.height))>
				<cfset LOCAL.product.setHeight(Trim(FORM.height)) />
			</cfif>
			<cfif IsNumeric(Trim(FORM.weight))>
				<cfset LOCAL.product.setWeight(Trim(FORM.weight)) />
			</cfif>
			
			<cfif IsNumeric(Trim(FORM.special_price))>
				<cfset LOCAL.product.setSpecialPrice(Trim(FORM.special_price)) />
			</cfif>
			<cfif IsDate(Trim(FORM.special_price_from_date))>
				<cfset LOCAL.product.setSpecialPriceFromDate(Trim(FORM.special_price_from_date)) />
			</cfif>
			<cfif IsDate(Trim(FORM.special_price_to_date))>
				<cfset LOCAL.product.setSpecialPriceToDate(Trim(FORM.special_price_to_date)) />
			</cfif>
			
			<cfif FORM.tax_category_id NEQ "">
				<cfset LOCAL.product.setTaxCategory(EntityLoadByPK("tax_category",FORM.tax_category_id)) />
			</cfif>
			
			<cfif FORM.attribute_set_id NEQ "">
				<cfif NOT IsNull(LOCAL.product.getAttributeSet()) AND FORM.attribute_set_id NEQ LOCAL.product.getAttributeSet().getAttributeSetId()>
					<cfset LOCAL.product.removeAttributeValues() />
				</cfif>
				<cfset LOCAL.product.setAttributeSet(EntityLoadByPK("attribute_set", FORM.attribute_set_id)) />
			</cfif>
			
			<cfset LOCAL.product.removeAllCategories() />
			
			<cfloop list="#FORM.category_id#" index="LOCAL.categoryId">
				<cfset LOCAL.newCategory = EntityLoadByPK("category",LOCAL.categoryId) />
				<cfset LOCAL.product.addCategory(LOCAL.newCategory) />
			</cfloop>
			
			<cfset LOCAL.product.removeShippingMethods() />
			
			<cfloop list="#FORM.shipping_method_id#" index="LOCAL.shippingMethodId">
				<cfset LOCAL.newShippingMethod = EntityLoadByPK("shipping_method",LOCAL.shippingMethodId) />
				<cfset LOCAL.product.addShippingMethod(LOCAL.newShippingMethod) />
			</cfloop>
		
			<cfset EntitySave(LOCAL.product) />
		
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlWeb#images/uploads/product/") />
						
							<cfset LOCAL.imageDir = LOCAL.imagePath & LOCAL.product.getProductId() />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>
							
							<cffile action = "move" source = "#LOCAL.imagePath##LOCAL.imgName#" destination = "#LOCAL.imagePath##LOCAL.product.getProductId()#\#LOCAL.imgName#">
						
							<cfset LOCAL.productImage = EntityNew("product_image") />
							<cfset LOCAL.productImage.setName(LOCAL.imgName) />
							<cfset EntitySave(LOCAL.productImage) />
							<cfset LOCAL.product.addImage(LOCAL.productImage) />
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
					<cfset LOCAL.product.addProductCustomerGroupRela(LOCAL.groupPrice) />
				</cfloop>
			</cfif>
			
			<cfset LOCAL.productService.setProductId(LOCAL.product.getProductId()) />
			<cfset LOCAL.groupPrices = LOCAL.productService.getProductGroupPrices() />
			
			<cfloop from="1" to="#ArrayLen(LOCAL.groupPrices)#" index="LOCAL.i">
				<cfif StructKeyExists(FORM,"delete_group_price_#LOCAL.i#")>
					<cfset LOCAL.productCustomerGroupRela = EntityLoad('product_customer_group_rela', {productId = LOCAL.product.getProductId(), price = LOCAL.groupPrices[i].price})> 
					<cfloop array="#LOCAL.productCustomerGroupRela#" index="LOCAL.rela">
						<cfset EntityDelete(LOCAL.rela) />
					</cfloop>
				</cfif>
			</cfloop>
		
			<!--- attribute values --->
			<cfif NOT IsNull(LOCAL.product.getAttributeSet())>
				<cfset LOCAL.productService.setAttributeSetId(LOCAL.product.getAttributeSet().getAttributeSetId()) />
				<cfset LOCAL.attributes = LOCAL.productService.getProductAttributeAndValues() />
				<cfloop array="#LOCAL.attributes#" index="LOCAL.attribute">
					<cfif StructKeyExists(FORM,"new_attribute_value_#LOCAL.attribute.attributeId#")>
						<cfset LOCAL.formAttributeValue = Trim(FORM["new_attribute_value_#LOCAL.attribute.attributeId#"]) />
						<cfif LOCAL.formAttributeValue NEQ "">
							<cfset LOCAL.newAttributeValue = EntityNew("attribute_value") />
							<cfset LOCAL.newAttributeValue.setProductId(LOCAL.product.getProductId()) />
							<cfset LOCAL.newAttributeValue.setAttributeId(LOCAL.attribute.attributeId) />
							<cfset LOCAL.newAttributeValue.setValue(LOCAL.formAttributeValue) />
							
							<cfset LOCAL.filename = Trim(FORM["new_image_#LOCAL.attribute.attributeId#"]) />
							
							<cfif LOCAL.filename NEQ "">
							
								<cfset LOCAL.imageDir = "#APPLICATION.absolutePathRoot#images\uploads\product\#LOCAL.product.getProductId()#\attribute\#LOCAL.attribute.attributeId#" />
								
								<cfif NOT DirectoryExists(LOCAL.imageDir)>
									<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
								</cfif>
								
								<cffile action = "upload"  
										fileField = "new_image_#LOCAL.attribute.attributeId#"
										destination = "#LOCAL.imageDir#"
										nameConflict = "MakeUnique"> 
								
								<cfset LOCAL.newAttributeValue.setImageName(cffile.serverFile) />
							</cfif>
							<cfset EntitySave(LOCAL.newAttributeValue) />
							<cfset LOCAL.product.addAttributeValue(LOCAL.newAttributeValue) />
						</cfif>
						
						<cfloop array="#attribute.attributeValueArray#" index="LOCAL.attributeValue">
							<cfif StructKeyExists(FORM,"remove_attribute_value_#LOCAL.attributeValue.attributeValueId#")>	
								<cfset LOCAL.product.removeAttributeValue(EntityLoadByPK("attribute_value",LOCAL.attributeValue.attributeValueId)) />
							</cfif>
						</cfloop>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=#LOCAL.tab_id#" />
		
		<cfelseif StructKeyExists(FORM,"delete_item")>
		
			<cfset LOCAL.product.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product #LOCAL.product.getDisplayName()# has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/products.cfm" />
			
		<cfelseif StructKeyExists(FORM,"add_new_attribute_option")>
		
			<cfset LOCAL.newAttributeValue = EntityNew("attribute_value") />
			<cfset LOCAL.newAttributeValue.setProduct(LOCAL.product) />
			<cfset LOCAL.newAttributeValue.setAttribute(EntityLoadByPK("attribute",FORM.new_attribute_option_attribute_id)) />
			<cfset LOCAL.newAttributeValue.setValue(Trim(FORM.new_attribute_option)) />
			
			<cfset LOCAL.filename = Trim(FORM.new_attribute_option_attachment) />
							
			<cfif LOCAL.filename NEQ "">
				<cfset LOCAL.imageDir = "#APPLICATION.absolutePathRoot#images\uploads\product\#LOCAL.product.getProductId()#\attribute\#FORM.new_attribute_option_attribute_id#" />
				
				<cfif NOT DirectoryExists(LOCAL.imageDir)>
					<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
				</cfif>
				
				<cffile action = "upload"  
						fileField = "new_attribute_option_attachment"
						destination = "#LOCAL.imageDir#"
						nameConflict = "MakeUnique"> 
				
				<cfset LOCAL.newAttributeValue.setImageName(cffile.serverFile) />
			</cfif>
			
			<cfset EntitySave(LOCAL.newAttributeValue) />
			<cfset LOCAL.product.addAttributeValue(LOCAL.newAttributeValue) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New option has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_5" />
			
		<cfelseif StructKeyExists(FORM,"delete_attribute_option")>
		
			<cfset LOCAL.attributeValue = EntityLoadByPK("attribute_value",FORM.deleted_attribute_value_id) />
			<cfset LOCAL.product.removeAttributeValue(LOCAL.attributeValue) /> 
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute option has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_5" />
			
		<cfelseif StructKeyExists(FORM,"delete_attribute_option_value")>
		
			<cfset LOCAL.product.removeSubProduct(EntityLoadByPK("product",FORM.sub_product_id)) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute value has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_5" />
			
		<cfelseif StructKeyExists(FORM,"add_new_attribute_option_value")>
			
			<cfset LOCAL.productService.setProductId(FORM.id) />
			<cfset LOCAL.productService.setAttributeSetId(LOCAL.product.getAttributeSet().getAttributeSetId()) />
			<cfset LOCAL.productAttributes = LOCAL.productService.getProductAttributes() />
			
			<cfset LOCAL.newProduct = EntityNew("product")>
			<cfset LOCAL.newProduct.setParentProduct(LOCAL.product) />
			
			<cfset LOCAL.newProduct.setName(LOCAL.product.getName()) />
			<cfset LOCAL.newProduct.setDisplayName(LOCAL.product.getDisplayName()) />
			<cfset LOCAL.newProduct.setSku(LOCAL.product.getSku()) />
			<cfset LOCAL.newProduct.setTaxCategory(LOCAL.product.getTaxCategory()) />
			<cfset LOCAL.newProduct.setAttributeSet(LOCAL.product.getAttributeSet()) />
			<cfset LOCAL.newProduct.setPrice(FORM.new_price) />
			<cfset LOCAL.newProduct.setStock(FORM.new_stock) />
			<cfset LOCAL.newProduct.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.newProduct.setCreatedDatetime(Now()) />
			<cfset LOCAL.newProduct.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.newProduct.setUpdatedDatetime(Now()) />
			
			<cfset EntitySave(LOCAL.newProduct) />
		
			<cfloop query="LOCAL.productAttributes">
				<cfif LOCAL.productAttributes.required>
					<cfset LOCAL.newAttributeValue = EntityNew("attribute_value") />
					<cfset LOCAL.newAttributeValue.setProduct(LOCAL.newProduct) />
					<cfset LOCAL.newAttributeValue.setAttribute(EntityLoadByPK("attribute",LOCAL.productAttributes.attribute_id)) />
					<cfset LOCAL.newAttributeValue.setValue(FORM["new_attribute_value_#LOCAL.productAttributes.attribute_id#"]) />
					<cfif FORM.new_attribute_imagename NEQ "">
						<cfset LOCAL.newAttributeValue.setImageName(FORM.new_attribute_imagename) />
					</cfif>
					
					<cfset EntitySave(LOCAL.newAttributeValue) />
					<cfset LOCAL.newProduct.addAttributeValue(LOCAL.newAttributeValue) />
				</cfif>
			</cfloop>
			
			<cfset EntitySave(LOCAL.newProduct) />
			
			<cfset LOCAL.product.addSubProduct(LOCAL.newProduct) />
			
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New attribute value has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_5" />
		
		<cfelseif StructKeyExists(FORM,"add_new_group_price")>
			<cfif IsNumeric(Trim(FORM.new_group_price))>
				<cfloop list="#FORM.customer_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.newGroupPrice = EntityNew("product_customer_group_rela") />
					<cfset LOCAL.newGroupPrice.setProduct(EntityLoadByPK("product",FORM.id)) />
					<cfset LOCAL.newGroupPrice.setCustomerGroup(EntityLoadByPK("customer_group",LOCAL.groupId)) />
					<cfset LOCAL.newGroupPrice.setPrice(Trim(FORM.new_group_price)) />
					<cfset EntitySave(LOCAL.newGroupPrice) />
					<cfset LOCAL.product.addProductCustomerGroupRela(LOCAL.newGroupPrice) />
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New group price has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_3" />
			
		<cfelseif StructKeyExists(FORM,"delete_group_price")>
			
			<cfset LOCAL.groupPrices = EntityLoad("product_customer_group_rela",{price = FORM.deleted_group_price_amount}) />
			
			<cfloop array="#LOCAL.groupPrices#" index="LOCAL.groupPrice">
				<cfset LOCAL.product.removeProductCustomerGroupRela(LOCAL.groupPrice) />
			</cfloop>
			
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Group price has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_3" />
		
		<cfelseif StructKeyExists(FORM,"add_related_product")>
						
			
			<cfset LOCAL.relatedProduct = EntityLoadByPK("product",FORM.new_related_product_id) />
			
			<cfset LOCAL.product.addRelatedProduct(LOCAL.relatedProduct) />
			<cfset LOCAL.relatedProduct.addRelatedParentProduct(LOCAL.product) />
			
			<cfset EntitySave(LOCAL.product) />
			<cfset EntitySave(LOCAL.relatedProduct) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_6" />
		
		<cfelseif StructKeyExists(FORM,"delete_related_product")>
		
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.id) />
			<cfset LOCAL.relatedProduct = EntityLoadByPK("product",FORM.delete_related_product_id) />
			
			<cfset LOCAL.product.removeRelatedProduct(LOCAL.relatedProduct) />
			<cfset LOCAL.relatedProduct.removeRelatedParentProduct(LOCAL.product) />
			
			<cfset EntitySave(LOCAL.product) />
			<cfset EntitySave(LOCAL.relatedProduct) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_6" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.categories = LOCAL.categoryService.getCategories() />
		<cfset LOCAL.pageData.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true}) />
		<cfset LOCAL.pageData.shippingCarriers = EntityLoad("shipping_carrier") />
		<cfset LOCAL.pageData.taxCategories = EntityLoad("tax_category") />
		<cfset LOCAL.pageData.attributeSets = EntityLoad("attribute_set",{isDeleted = false, isEnabled = true}) />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.productService.setProductId(URL.id) />
			<cfset LOCAL.pageData.product = EntityLoadByPK("product", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			<cfset LOCAL.pageData.groupPriceClass = "" />
			<cfset LOCAL.pageData.groupPrices = LOCAL.productService.getProductGroupPrices() />
			
			<cfif NOT IsNull(LOCAL.pageData.product.getAttributeSet())>
				<cfset LOCAL.productService.setAttributeSetId(LOCAL.pageData.product.getAttributeSet().getAttributeSetId()) />
				<cfset LOCAL.pageData.attributes = LOCAL.productService.getProductAttributeAndValues() />
				<cfset LOCAL.pageData.isProductAttributeComplete = LOCAL.productService.isProductAttributeComplete() />
			</cfif>
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.product.getDisplayName())?"":LOCAL.pageData.product.getDisplayName() />
				<cfset LOCAL.pageData.formData.detail = isNull(LOCAL.pageData.product.getDetail())?"":LOCAL.pageData.product.getDetail() />
				<cfset LOCAL.pageData.formData.sku = isNull(LOCAL.pageData.product.getSku())?"":LOCAL.pageData.product.getSku() />
				<cfset LOCAL.pageData.formData.price = isNull(LOCAL.pageData.product.getPrice())?"":LOCAL.pageData.product.getPrice() />
				<cfset LOCAL.pageData.formData.special_price = isNull(LOCAL.pageData.product.getSpecialPrice())?"":LOCAL.pageData.product.getSpecialPrice() />
				<cfset LOCAL.pageData.formData.special_price_from_date = isNull(LOCAL.pageData.product.getSpecialPriceFromDate())?"":DateFormat(LOCAL.pageData.product.getSpecialPriceFromDate(),"mm/dd/yyyy") />
				<cfset LOCAL.pageData.formData.special_price_to_date = isNull(LOCAL.pageData.product.getSpecialPriceToDate())?"":DateFormat(LOCAL.pageData.product.getSpecialPriceToDate(),"mm/dd/yyyy") />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.product.getIsEnabled())?"":LOCAL.pageData.product.getIsEnabled() />
				<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.product.getTitle())?"":LOCAL.pageData.product.getTitle() />
				<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.product.getKeywords())?"":LOCAL.pageData.product.getKeywords() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.product.getDescription())?"":LOCAL.pageData.product.getDescription() />
				<cfset LOCAL.pageData.formData.tax_category_id = isNull(LOCAL.pageData.product.getTaxCategory())?"":LOCAL.pageData.product.getTaxCategory().getTaxCategoryId() />
				<cfset LOCAL.pageData.formData.length = isNull(LOCAL.pageData.product.getLength())?"":LOCAL.pageData.product.getLength() />
				<cfset LOCAL.pageData.formData.height = isNull(LOCAL.pageData.product.getHeight())?"":LOCAL.pageData.product.getHeight() />
				<cfset LOCAL.pageData.formData.width = isNull(LOCAL.pageData.product.getWidth())?"":LOCAL.pageData.product.getWidth() />
				<cfset LOCAL.pageData.formData.weight = isNull(LOCAL.pageData.product.getWeight())?"":LOCAL.pageData.product.getWeight() />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.product = EntityNew("product") />
			<cfset LOCAL.pageData.title = "New Product | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			<cfset LOCAL.pageData.groupPriceClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.detail = "" />
				<cfset LOCAL.pageData.formData.sku = "" />
				<cfset LOCAL.pageData.formData.price = "" />
				<cfset LOCAL.pageData.formData.special_price = "" />
				<cfset LOCAL.pageData.formData.special_price_from_date = "" />
				<cfset LOCAL.pageData.formData.special_price_to_date = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.title = "" />
				<cfset LOCAL.pageData.formData.keywords = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.tax_category_id = "" />
				<cfset LOCAL.pageData.formData.length = "" />
				<cfset LOCAL.pageData.formData.height = "" />
				<cfset LOCAL.pageData.formData.width = "" />
				<cfset LOCAL.pageData.formData.weight = "" />
			</cfif>
		</cfif>
	
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>