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
		
		<cfif NOT IsNumeric(FORM.id) AND NOT IsNumeric(Trim(FORM.price))>
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid price.") />
		</cfif>
		
		<cfif StructKeyExists(FORM,"add_new_product") AND NOT IsNumeric(FORM.new_product_id)>
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid product ID.") />
		</cfif>
		
		<cfif NOT StructKeyExists(FORM,"category_id")>
			<cfset ArrayAppend(LOCAL.messageArray,"Please choose at least one category.") />
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
			<cfset LOCAL.product.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.product.setUpdatedDatetime(Now()) />
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
			<cfset LOCAL.product.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.product.setSku(Trim(FORM.sku)) />
			<cfif IsNumeric(Trim(FORM.stock))>
				<cfset LOCAL.product.setStock(Trim(FORM.stock)) />
			</cfif>
			<cfset LOCAL.product.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.product.setDetail(Trim(FORM.detail)) />
			<cfset LOCAL.product.setDescription(Trim(FORM.description)) />
			
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
				
			<cfif NOT IsNumeric(FORM.id)>	
				<cfset LOCAL.groupPrice = EntityNew("product_customer_group_rela") />
				<cfset LOCAL.groupPrice.setProduct(LOCAL.product) />
				<cfset LOCAL.groupPrice.setCustomerGroup(EntityLoad("customer_group",{isDefault=true},true)) />
				<cfset LOCAL.groupPrice.setPrice(Trim(FORM.price)) />
				<cfif IsNumeric(Trim(FORM.special_price))>
					<cfset LOCAL.groupPrice.setSpecialPrice(Trim(FORM.special_price)) />
				</cfif>
				<cfif IsDate(Trim(FORM.special_price_from_date))>
					<cfset LOCAL.groupPrice.setSpecialPriceFromDate(Trim(FORM.special_price_from_date)) />
				</cfif>
				<cfif IsDate(Trim(FORM.special_price_to_date))>
					<cfset LOCAL.groupPrice.setSpecialPriceToDate(Trim(FORM.special_price_to_date)) />
				</cfif>
				
				<cfset EntitySave(LOCAL.groupPrice) />
				
				<cfset LOCAL.shippingMethod = EntityLoad("shipping_method",{name="pickup"},true) />
				<cfset LOCAL.productShippingMethodRela = EntityNew("product_shipping_method_rela") />
				<cfset LOCAL.productShippingMethodRela.setProduct(LOCAL.product) />
				<cfset LOCAL.productShippingMethodRela.setShippingMethod(LOCAL.shippingMethod) />
				<cfset LOCAL.productShippingMethodRela.setPrice(0) />
				<cfset EntitySave(LOCAL.productShippingMethodRela) />
			</cfif>
			
			<cfif FORM.tax_category_id NEQ "">
				<cfset LOCAL.product.setTaxCategory(EntityLoadByPK("tax_category",FORM.tax_category_id)) />
			</cfif>
			
			<cfif FORM.attribute_set_id NEQ "">
				<cfif IsNull(LOCAL.product.getAttributeSet())
					OR
					(NOT IsNull(LOCAL.product.getAttributeSet()) AND FORM.attribute_set_id NEQ LOCAL.product.getAttributeSet().getAttributeSetId())>
					<cfset LOCAL.product.removeProductAttributeRelas() />
					<cfset LOCAL.product.removeSubProducts() />
					
					<cfset LOCAL.newAttributeSet = EntityLoadByPK("attribute_set", FORM.attribute_set_id) />
					<cfset LOCAL.product.setAttributeSet(LOCAL.newAttributeSet) />
					
					<cfloop array="#LOCAL.product.getAttributeSet().getAttributeSetAttributeRelas()#" index="LOCAL.attributeSetAttributeRela">
						<cfset LOCAL.newProductAttributeRela = EntityNew("product_attribute_rela") />
						<cfset LOCAL.newProductAttributeRela.setProduct(LOCAL.product) />
						<cfset LOCAL.newProductAttributeRela.setAttribute(LOCAL.attributeSetAttributeRela.getAttribute()) />
						<cfset LOCAL.newProductAttributeRela.setRequired(LOCAL.attributeSetAttributeRela.getRequired()) />
						<cfset EntitySave(LOCAL.newProductAttributeRela) />
						
						<cfset LOCAL.product.addProductAttributeRela(LOCAL.newProductAttributeRela) />
					</cfloop>
				</cfif>
			</cfif>
			
			<!--- update: not necessary for each time --->
			<cfset LOCAL.product.removeAllCategories() />
			
			<cfloop list="#FORM.category_id#" index="LOCAL.categoryId">
				<cfset LOCAL.newCategory = EntityLoadByPK("category",LOCAL.categoryId) />
				<cfset LOCAL.product.addCategory(LOCAL.newCategory) />
			</cfloop>
			
			<!--- update: not necessary for each time --->
			<cfset LOCAL.product.removeProductShippingMethodRelas() />
			
			<cfif StructKeyExists(FORM,"shipping_method_id")>
				<cfloop list="#FORM.shipping_method_id#" index="LOCAL.shippingMethodId">
					<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",LOCAL.shippingMethodId) />
					<cfset LOCAL.newProductShippingMethodRela = EntityNew("product_shipping_method_rela") />
					<cfset LOCAL.newProductShippingMethodRela.setShippingMethod(LOCAL.shippingMethod) />
					<cfset LOCAL.newProductShippingMethodRela.setProduct(LOCAL.product) />
					
					<cfif IsNumeric(FORM["default_price_#LOCAL.shippingMethodId#"])>
						<cfset LOCAL.newProductShippingMethodRela.setPrice(FORM["default_price_#LOCAL.shippingMethodId#"]) />
					<cfelse>
						<cfset LOCAL.newProductShippingMethodRela.setPrice(0) />
					</cfif>
					
					<cfset EntitySave(LOCAL.newProductShippingMethodRela) />
					
					<cfset LOCAL.product.addProductShippingMethodRela(LOCAL.newProductShippingMethodRela) />
				</cfloop>
			</cfif>
		
			<cfset EntitySave(LOCAL.product) />
			
			<cfif NOT IsNull(LOCAL.product.getImages())>
				<cfloop array="#LOCAL.product.getImages()#" index="LOCAL.img">
					<cfif IsNumeric(FORM["rank_#LOCAL.img.getProductImageId()#"])>
						<cfset LOCAL.img.setRank(FORM["rank_#LOCAL.img.getProductImageId()#"]) />
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
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlWeb#images/uploads/product/") />
						
							<cfset LOCAL.imageDir = LOCAL.imagePath & LOCAL.product.getProductId() />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>
							
							<cffile action = "move" source = "#LOCAL.imagePath##LOCAL.imgName#" destination = "#LOCAL.imagePath##LOCAL.product.getProductId()#\#LOCAL.imgName#">
						
							<cfset LOCAL.sizeArray = [{name = "medium", width = "410", height = "410", position="", crop = false}
													, {name = "small", width = "200", height = "200", position="center", crop = true}
													, {name = "thumbnail", width = "30", height = "30", position="center", crop = true}
													] />					
							<cfset _createImages(	imagePath = "#LOCAL.imagePath##LOCAL.product.getProductId()#\",
													imageNameWithExtension = LOCAL.imgName,
													sizeArray = LOCAL.sizeArray) />
															
							<cfset LOCAL.productImage = EntityNew("product_image") />
							<cfset LOCAL.productImage.setName(LOCAL.imgName) />
							<cfset EntitySave(LOCAL.productImage) />
							<cfset LOCAL.product.addImage(LOCAL.productImage) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(FORM,"default_image_id") AND FORM.default_image_id NEQ "">
				<cfset LOCAL.currentDefaultImage = EntityLoad("product_image",{product=LOCAL.product,isDefault=true},true) />
				<cfif NOT IsNull(LOCAL.currentDefaultImage)>
					<cfset LOCAL.currentDefaultImage.setIsDefault(false) />
					<cfset EntitySave(LOCAL.currentDefaultImage) />
				</cfif>
				<cfset LOCAL.newDefaultImage = EntityLoadByPK("product_image", FORM.default_image_id) />
				<cfset LOCAL.newDefaultImage.setIsDefault(true) />
				<cfset EntitySave(LOCAL.newDefaultImage) />
			</cfif>
									
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=#LOCAL.tab_id#" />
		
		<cfelseif StructKeyExists(FORM,"delete_item")>
		
			<cfset LOCAL.product.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product #LOCAL.product.getDisplayName()# has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/products.cfm" />
			
		<cfelseif StructKeyExists(FORM,"delete_image")>
		
			<cfset LOCAL.image = EntityLoadByPK("product_image",FORM.deleted_image_id) />
			<cfset LOCAL.product.removeImage(LOCAL.image) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_4" />	
		
		<cfelseif StructKeyExists(FORM,"add_new_video")>
		
			<cfset LOCAL.newProductVideo = EntityNew("product_video") />
			<cfset LOCAL.newProductVideo.setURL(Trim(FORM.new_video_url)) />
			<cfset EntitySave(LOCAL.newProductVideo) />
			<cfset LOCAL.product.addProductVideo(LOCAL.newProductVideo) />
			<cfset EntitySave(LOCAL.product) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Video has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_9" />
		
		<cfelseif StructKeyExists(FORM,"add_new_attribute_option")>
		
			<cfset LOCAL.productAttributeRela = EntityLoadByPK("product_attribute_rela",FORM.new_attribute_option_product_attribute_rela_id) />
		
			<cfset LOCAL.newAttributeValue = EntityNew("attribute_value") />
			<cfset LOCAL.newAttributeValue.setProductAttributeRela(LOCAL.productAttributeRela) />
			<cfset LOCAL.newAttributeValue.setValue(Trim(FORM.new_attribute_option_value)) />
			<cfset LOCAL.newAttributeValue.setDisplayName(Trim(FORM.new_attribute_option_name)) />
			<cfset LOCAL.newAttributeValue.setName(LCase(Trim(FORM.new_attribute_option_name))) />
			<cfset LOCAL.newAttributeValue.setThumbnailLabel(Trim(FORM.new_attribute_option_thumbnail_label)) />
			
			<cfset LOCAL.imageDir = "#APPLICATION.absolutePathRoot#images\uploads\product\#LOCAL.product.getProductId()#\" />
			<cfif NOT DirectoryExists(LOCAL.imageDir)>
				<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
			</cfif>	
			
			<cfif 	Trim(FORM.new_attribute_option_thumbnail_image) NEQ ""
					AND
					NOT(Trim(FORM.new_attribute_option_image) NEQ "" AND StructKeyExists(FORM, "generate_thumbnail"))>
			
				<cfset LOCAL.imageUtils = new "#APPLICATION.componentPathRoot#core.utils.imageUtils"() />
					
				<cffile action = "upload"  
						fileField = "new_attribute_option_thumbnail_image"
						destination = "#LOCAL.imageDir#"
						nameConflict = "MakeUnique"> 
				
				<cfset LOCAL.image = ImageRead("#cffile.serverDirectory#\#cffile.serverFile#")>
				<cfset LOCAL.newImage = ImageNew(LOCAL.image)>
				<cfset LOCAL.newImage = LOCAL.imageUtils.aspectCrop(LOCAL.newImage, 30, 30, "center")>
				<cfset ImageWrite(LOCAL.newImage,"#LOCAL.imageDir#thumbnail_#cffile.serverFile#")> 
				
				<cfset LOCAL.newAttributeValue.setThumbnailImageName("thumbnail_#cffile.serverFile#") />
			</cfif>
			
			<cfif Trim(FORM.new_attribute_option_image) NEQ "">
				<cffile action = "upload"  
						fileField = "new_attribute_option_image"
						destination = "#LOCAL.imageDir#"
						nameConflict = "MakeUnique"> 
				
				<cfset LOCAL.newAttributeValue.setImageName(cffile.serverFile) />
				<cfset LOCAL.productImage = EntityNew("product_image") />
				<cfset LOCAL.productImage.setName(cffile.serverFile) />
				<cfset EntitySave(LOCAL.productImage) />
				<cfset LOCAL.product.addImage(LOCAL.productImage) />
				<cfset EntitySave(LOCAL.product) />
				
				<cfset LOCAL.sizeArray = [{name = "medium", width = "410", height = "410", position="", crop = false}
										, {name = "small", width = "200", height = "200", position="center", crop = true}
										, {name = "thumbnail", width = "30", height = "30", position="center", crop = true}
										] />			
				<cfset _createImages(	imagePath = LOCAL.imageDir,
										imageNameWithExtension = LOCAL.newAttributeValue.getImageName(),
										sizeArray = LOCAL.sizeArray) />
				
				<cfif StructKeyExists(FORM, "generate_thumbnail")>
					<cfset LOCAL.newAttributeValue.setThumbnailImageName("thumbnail_#LOCAL.newAttributeValue.getImageName()#") />
				</cfif>
			</cfif>
			
			<cfset EntitySave(LOCAL.newAttributeValue) />
			<cfset LOCAL.ProductAttributeRela.addAttributeValue(LOCAL.newAttributeValue) />
			<cfset EntitySave(LOCAL.ProductAttributeRela) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New option has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_5" />
			
		<cfelseif StructKeyExists(FORM,"generate_attribute_option_values")>
		
			<cfset LOCAL.attributeValueIdArray = [] />
			<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
			
			<cfloop array="#LOCAL.product.getProductAttributeRelas()#" index="LOCAL.productAttributeRela">
				<cfif LOCAL.productAttributeRela.getRequired() EQ true>
					<cfset ArrayAppend(LOCAL.attributeValueIdArray, _getAttributeValueIdArray(productAttributeRelaId = LOCAL.productAttributeRela.getProductAttributeRelaId())) />
				</cfif>
			</cfloop>
			
			<cfset LOCAL.attributeValueIdPermutaionArray = _createPermutaionArray(LOCAL.attributeValueIdArray)  />
		
			<cfloop array="#LOCAL.attributeValueIdPermutaionArray#" index="LOCAL.attributeValueIdArray">
				<cfset LOCAL.subProduct = LOCAL.productService.getProduct(parentProductId = LOCAL.product.getProductId(), attributeValueIdList = ArrayToList(LOCAL.attributeValueIdArray)) />
				<cfif LOCAL.subProduct.productid EQ "">
					<cfset _createSubProduct(parentProduct = LOCAL.product, attributeValueIdList = ArrayToList(LOCAL.attributeValueIdArray)) />
				</cfif>
			</cfloop>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute values have been generated.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_5" />
			
		<cfelseif StructKeyExists(FORM,"delete_attribute_option")>
		
			<cfset LOCAL.attributeValue = EntityLoadByPK("attribute_value",FORM.deleted_attribute_value_id) />
			<cfset EntityDelete(LOCAL.attributeValue) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute option has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_5" />
			
		<cfelseif StructKeyExists(FORM,"delete_video")>
		
			<cfset LOCAL.productVideo = EntityLoadByPK("product_video",FORM.deleted_product_video_id) />
			<cfset EntityDelete(LOCAL.productVideo) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Video has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_9" />
		
		<cfelseif StructKeyExists(FORM,"delete_attribute_option_value")>
		
			<cfset LOCAL.product.removeSubProduct(EntityLoadByPK("product",FORM.sub_product_id)) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute value has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_5" />
			
		<cfelseif StructKeyExists(FORM,"add_new_attribute_option_value")>
			<cfset LOCAL.attributeValueIdList = "" />
			<cfloop array="#LOCAL.product.getAttributeSet().getAttributeSetAttributeRelas()#" index="LOCAL.attributeSetAttributeRela">
				<cfset LOCAL.attributeValueIdList &= FORM["new_attribute_value_#LOCAL.attributeSetAttributeRela.getAttribute().getAttributeId()#"] & "," />
			</cfloop>
			
			<cfset LOCAL.newProduct = _createSubProduct(parentProduct = LOCAL.product, attributeValueIdList = LOCAL.attributeValueIdList) />
			
			<cfset LOCAL.newProduct.setSku(FORM.new_sku) />
			<cfset LOCAL.newProduct.setStock(FORM.new_stock) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New attribute value has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_5" />
		
		<cfelseif StructKeyExists(FORM,"add_single_group_price")>
			<cfset LOCAL.customerGroup = EntityLoadByPK("customer_group",FORM.add_customer_group_id) />
			<cfset LOCAL.groupPrice = EntityLoad("product_customer_group_rela",{product=LOCAL.product,customerGroup=LOCAL.customerGroup},true) />
		
			<cfif IsNull(LOCAL.groupPrice)>
				<cfset LOCAL.groupPrice = EntityNew("product_customer_group_rela") />
				<cfset LOCAL.groupPrice.setProduct(LOCAL.product) />
				<cfset LOCAL.groupPrice.setCustomerGroup(LOCAL.customerGroup) />
				<cfset LOCAL.groupPrice.setPrice(Trim(FORM.new_single_price)) />
				<cfif IsNumeric(Trim(FORM.new_single_special_price))>
					<cfset LOCAL.groupPrice.setSpecialPrice(Trim(FORM.new_single_special_price)) />
					<cfif IsDate(Trim(FORM.new_single_special_price_from_date))>
						<cfset LOCAL.groupPrice.setSpecialPriceFromDate(Trim(FORM.new_single_special_price_from_date)) />
					</cfif>
					<cfif IsDate(Trim(FORM.new_single_special_price_to_date))>
						<cfset LOCAL.groupPrice.setSpecialPriceToDate(Trim(FORM.new_single_special_price_to_date)) />
					</cfif>
				</cfif>
				
				<cfset EntitySave(LOCAL.groupPrice) />
				<cfset LOCAL.product.addProductCustomerGroupRela(LOCAL.groupPrice) />
			<cfelse>
				<cfset LOCAL.groupPrice.setPrice(Trim(FORM.new_single_price)) />
				<cfif IsNumeric(Trim(FORM.new_single_special_price))>
					<cfset LOCAL.groupPrice.setSpecialPrice(Trim(FORM.new_single_special_price)) />
					<cfif IsDate(Trim(FORM.new_single_special_price_from_date))>
						<cfset LOCAL.groupPrice.setSpecialPriceFromDate(Trim(FORM.new_single_special_price_from_date)) />
					</cfif>
					<cfif IsDate(Trim(FORM.new_single_special_price_to_date))>
						<cfset LOCAL.groupPrice.setSpecialPriceToDate(Trim(FORM.new_single_special_price_to_date)) />
					</cfif>
				</cfif>
				
				<cfset EntitySave(LOCAL.groupPrice) />
			</cfif>
			
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New group price has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_3" />
		
		<cfelseif StructKeyExists(FORM,"edit_group_price")>
			
			<cfset LOCAL.groupPrice = EntityLoadByPK("product_customer_group_rela",FORM.edit_product_customer_group_rela_id) />
			<cfset LOCAL.groupPrice.setPrice(Trim(FORM.edit_price)) />
			
			<cfif IsNumeric(Trim(FORM.edit_special_price))>
				<cfset LOCAL.groupPrice.setSpecialPrice(Trim(FORM.edit_special_price)) />
			</cfif>
			<cfif IsDate(Trim(FORM.edit_special_price_from_date))>
				<cfset LOCAL.groupPrice.setSpecialPriceFromDate(Trim(FORM.edit_special_price_from_date)) />
			</cfif>
			<cfif IsDate(Trim(FORM.edit_special_price_to_date))>
				<cfset LOCAL.groupPrice.setSpecialPriceToDate(Trim(FORM.edit_special_price_to_date)) />
			</cfif>
						
			<cfset EntitySave(LOCAL.groupPrice) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New group price has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_3" />
			
		<cfelseif StructKeyExists(FORM,"delete_group_price")>
			
			<cfset LOCAL.groupPrice = EntityLoadByPK("product_customer_group_rela",FORM.deleted_product_customer_group_rela_id) />
			
			<cfset LOCAL.product.removeProductCustomerGroupRela(LOCAL.groupPrice) />
			
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Group price has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_3" />
		
		<cfelseif StructKeyExists(FORM,"add_related_product")>
			
			<cfif StructKeyExists(FORM,"related_product_group_id")>			
				<cfloop list="#FORM.related_product_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.relatedProductGroup = EntityLoadByPK("related_product_group",LOCAL.groupId) />
					<cfloop array="#LOCAL.relatedProductGroup.getRelatedProducts()#" index="LOCAL.relatedProduct">
						<cfset LOCAL.product.addRelatedProduct(LOCAL.relatedProduct) />
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_related_product_id)>
				<cfset LOCAL.newRelatedProduct = EntityLoadByPK("product",FORM.new_related_product_id) />
				<cfset LOCAL.product.addRelatedProduct(LOCAL.newRelatedProduct) />
			</cfif>
			
			<cfset EntitySave(LOCAL.product) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_6" />
		
		<cfelseif StructKeyExists(FORM,"delete_related_product")>
		
			<cfset LOCAL.relatedProduct = EntityLoadByPK("product",FORM.delete_related_product_id) />
			
			<cfset LOCAL.product.removeRelatedProduct(LOCAL.relatedProduct) />
			<cfset LOCAL.relatedProduct.removeRelatedParentProduct(LOCAL.product) />
			
			<cfset EntitySave(LOCAL.product) />
			<cfset EntitySave(LOCAL.relatedProduct) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_6" />
		
		<cfelseif StructKeyExists(FORM,"edit_default_price")>
			<cfset LOCAL.productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela", FORM.product_shipping_method_rela_id) />
			<cfset LOCAL.productShippingMethodRela.setPrice(FORM.new_default_price) />
			
			<cfset EntitySave(LOCAL.productShippingMethodRela) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Default price has been updated.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_8" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true}) />
		<cfset LOCAL.pageData.taxCategories = EntityLoad("tax_category") />
		<cfset LOCAL.pageData.relatedProductGroups = EntityLoad("related_product_group") />
		<cfset LOCAL.pageData.attributeSets = EntityLoad("attribute_set",{isDeleted = false}) />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.productService.setId(URL.id) />
			<cfset LOCAL.pageData.product = EntityLoadByPK("product", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			<cfset LOCAL.pageData.customerGroupPrices = LOCAL.productService.getCustomerGroupPrices() />
			<cfset LOCAL.pageData.shippingMethods = LOCAL.productService.getProductShippingMethods() />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.product.getDisplayName())?"":LOCAL.pageData.product.getDisplayName() />
				<cfset LOCAL.pageData.formData.detail = isNull(LOCAL.pageData.product.getDetail())?"":LOCAL.pageData.product.getDetail() />
				<cfset LOCAL.pageData.formData.sku = isNull(LOCAL.pageData.product.getSku())?"":LOCAL.pageData.product.getSku() />
				<cfset LOCAL.pageData.formData.stock = isNull(LOCAL.pageData.product.getStock())?"":LOCAL.pageData.product.getStock() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.product.getIsEnabled())?"":LOCAL.pageData.product.getIsEnabled() />
				<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.product.getTitle())?"":LOCAL.pageData.product.getTitle() />
				<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.product.getKeywords())?"":LOCAL.pageData.product.getKeywords() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.product.getDescription())?"":LOCAL.pageData.product.getDescription() />
				<cfset LOCAL.pageData.formData.attribute_set_id = isNull(LOCAL.pageData.product.getAttributeSet())?"":LOCAL.pageData.product.getAttributeSet().getAttributeSetId() />
				<cfset LOCAL.pageData.formData.tax_category_id = isNull(LOCAL.pageData.product.getTaxCategory())?"":LOCAL.pageData.product.getTaxCategory().getTaxCategoryId() />
				<cfset LOCAL.pageData.formData.length = isNull(LOCAL.pageData.product.getLength())?"":LOCAL.pageData.product.getLength() />
				<cfset LOCAL.pageData.formData.height = isNull(LOCAL.pageData.product.getHeight())?"":LOCAL.pageData.product.getHeight() />
				<cfset LOCAL.pageData.formData.width = isNull(LOCAL.pageData.product.getWidth())?"":LOCAL.pageData.product.getWidth() />
				<cfset LOCAL.pageData.formData.weight = isNull(LOCAL.pageData.product.getWeight())?"":LOCAL.pageData.product.getWeight() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Product | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			<cfset LOCAL.pageData.shippingMethods = LOCAL.productService.getProductShippingMethods() />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.detail = "" />
				<cfset LOCAL.pageData.formData.sku = "" />
				<cfset LOCAL.pageData.formData.stock = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.title = "" />
				<cfset LOCAL.pageData.formData.keywords = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.tax_category_id = "" />
				<cfset LOCAL.pageData.formData.attribute_set_id = "" />
				<cfset LOCAL.pageData.formData.length = "" />
				<cfset LOCAL.pageData.formData.height = "" />
				<cfset LOCAL.pageData.formData.width = "" />
				<cfset LOCAL.pageData.formData.weight = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
	
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="_getAttributeValueIdArray" access="private" output="false" returnType="array">
		<cfargument name="productAttributeRelaId" type="numeric" required="true">
		<cfset var LOCAL = {} />
		
		<cfquery name="LOCAL.getAttributeValueIdList">
			SELECT	attribute_value_id
			FROM	attribute_value
			WHERE	product_attribute_rela_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.productAttributeRelaId#" />
		</cfquery>
		
		<cfreturn ListToArray(ValueList(LOCAL.getAttributeValueIdList.attribute_value_id)) />
	</cffunction>
	
	<cffunction name="_createSubProduct" access="private" output="false" returnType="any">
		<cfargument name="parentProduct" type="any" required="true">
		<cfargument name="attributeValueIdList" type="string" required="true">
	
		<cfset LOCAL.newProduct = EntityNew("product")>
		<cfset LOCAL.newProduct.setParentProduct(ARGUMENTS.parentProduct) />
		
		<cfset LOCAL.newProduct.setName(ARGUMENTS.parentProduct.getName()) />
		<cfset LOCAL.newProduct.setDisplayName(ARGUMENTS.parentProduct.getDisplayName()) />
		<cfset LOCAL.newProduct.setTaxCategory(ARGUMENTS.parentProduct.getTaxCategory()) />
		<cfset LOCAL.newProduct.setAttributeSet(ARGUMENTS.parentProduct.getAttributeSet()) />
		<cfset LOCAL.newProduct.setCreatedUser(SESSION.adminUser) />
		<cfset LOCAL.newProduct.setCreatedDatetime(Now()) />
		
		<cfloop array="#ARGUMENTS.parentProduct.getProductCustomerGroupRelas()#" index="LOCAL.productCustomerGroupRela">
			<cfset LOCAL.groupPrice = EntityNew("product_customer_group_rela") />
			<cfset LOCAL.groupPrice.setProduct(LOCAL.newProduct) />
			<cfset LOCAL.groupPrice.setCustomerGroup(LOCAL.productCustomerGroupRela.getCustomerGroup()) />
			<cfset LOCAL.groupPrice.setPrice(LOCAL.productCustomerGroupRela.getPrice()) />
			<cfset LOCAL.groupPrice.setSpecialPrice(LOCAL.productCustomerGroupRela.getPrice()) />
			<cfset LOCAL.groupPrice.setSpecialPriceFromDate(LOCAL.productCustomerGroupRela.getSpecialPriceFromDate()) />
			<cfset LOCAL.groupPrice.setSpecialPriceToDate(LOCAL.productCustomerGroupRela.getSpecialPriceToDate()) />
			<cfset EntitySave(LOCAL.groupPrice) />
		
			<cfset LOCAL.newProduct.addProductCustomerGroupRela(LOCAL.groupPrice) />
		</cfloop>
	
		<cfloop list="#ARGUMENTS.attributeValueIdList#" index="LOCAL.attributeValueId">
			<cfset LOCAL.attributeValue = EntityLoadByPK("attribute_value", LOCAL.attributeValueId) />
			
			<cfset LOCAL.newProductAttributeRela = EntityNew("product_attribute_rela") />
			<cfset LOCAL.newProductAttributeRela.setProduct(LOCAL.newProduct) />
			<cfset LOCAL.newProductAttributeRela.setAttribute(LOCAL.attributeValue.getProductAttributeRela().getAttribute()) />
			<cfset LOCAL.newProductAttributeRela.setRequired(LOCAL.attributeValue.getProductAttributeRela().getRequired()) />
			<cfset EntitySave(LOCAL.newProductAttributeRela) />
			
			<cfset LOCAL.newAttributeValue = EntityNew("attribute_value") />
			<cfset LOCAL.newAttributeValue.setProductAttributeRela(LOCAL.newProductAttributeRela) />
			<cfset LOCAL.newAttributeValue.setValue(LOCAL.attributeValue.getValue()) />
			<cfset LOCAL.newAttributeValue.setName(LOCAL.attributeValue.getName()) />
			<cfset LOCAL.newAttributeValue.setDisplayName(LOCAL.attributeValue.getDisplayName()) />
			<cfset LOCAL.newAttributeValue.setThumbnailLabel(LOCAL.attributeValue.getThumbnailLabel()) />
			<cfset LOCAL.newAttributeValue.setThumbnailImageName(LOCAL.attributeValue.getThumbnailImageName()) />
			<cfset LOCAL.newAttributeValue.setImageName(LOCAL.attributeValue.getImageName()) />
			<cfset EntitySave(LOCAL.newAttributeValue) />
			
			<cfset LOCAL.newProductAttributeRela.addAttributeValue(LOCAL.newAttributeValue) />
		</cfloop>
		
		<cfset EntitySave(LOCAL.newProduct) />
		<cfset ARGUMENTS.parentProduct.addSubProduct(LOCAL.newProduct) />
		<cfset EntitySave(ARGUMENTS.parentProduct) />
		
		<cfreturn LOCAL.newProduct />
	</cffunction>
	
	<cffunction name="_createPermutaionArray" access="private" output="false" returnType="array">
		<cfargument name="attributeValueIdArray" type="array" required="true">
		<cfscript>
			var result = [];
			var _arrayslen = ArrayLen(arguments.attributeValueIdArray);
			var _size = (_arrayslen) ? 1 : 0;
			var _array = '';
			var x = 0;
			var i = 0;
			var j = 0;
			var _current = [];

			for (x=1; x lte _arrayslen; x++) {
				_size = _size * ArrayLen(arguments.attributeValueIdArray[x]);
				_current[x] = 1;
			}

			for (i=1; i lte _size; i++) {
				result[i] = [];

				for (j=1; j lte _arrayslen; j++) {
					arrayappend(result[i], arguments.attributeValueIdArray[j][_current[j]]);
				}

				for (j=_arrayslen; j gt 0; j--) {
					if (ArrayLen(arguments.attributeValueIdArray[j]) gt _current[j])  {
						_current[j]++;
						break;
					}
					else {
						_current[j] = 1;
					}
				}
			}

			return result;
		</cfscript>
	</cffunction>
</cfcomponent>