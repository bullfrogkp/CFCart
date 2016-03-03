<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
	<cfdump var="#FORM#" abort>	
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid product name.") />
		</cfif>
		
		<cfif Trim(FORM.sku) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid SKU.") />
		</cfif>
		
		<cfif NOT IsNumeric(Trim(FORM.stock))>
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid stock number.") />
		</cfif>
		
		<cfif NOT StructKeyExists(FORM,"category_id")>
			<cfset ArrayAppend(LOCAL.messageArray,"Please choose at least one category.") />
		</cfif>
		
		<cfif NOT StructKeyExists(FORM,"shipping_carrier_id")>
			<cfset ArrayAppend(LOCAL.messageArray,"Please choose at least one shipping carrier.") />
		<cfelse>
			<cfloop list="#FORM.shipping_carrier_id#" index="LOCAL.shippingCarrierId">				
				<cfif StructKeyExists(FORM,"use_default_price_#LOCAL.shippingCarrierId#") AND FORM["use_default_price_#LOCAL.shippingCarrierId#"] EQ 0
					AND
					NOT IsNumeric(Trim(FORM.weight))>
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter the product weight to calculate the shipping fee.") />
				</cfif>
			</cfloop>
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
			<cfset LOCAL.product.setProductType(EntityLoad("product_type",{name="simple"},true)) />
			<cfset LOCAL.product.setSoldCount(0) />
			<cfset LOCAL.product.setReviewCount(0) />
			<cfset LOCAL.product.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.product.setCreatedDatetime(Now()) />
			<cfset LOCAL.product.setIsDeleted(false) />
			<cfset LOCAL.product.setViewCount(0) />
			<cfset LOCAL.tab_id = "tab_1" />
		</cfif>
		
		<cfif StructKeyExists(FORM,"id")>
			<!--- general information --->
			<cfset LOCAL.product.setName(LCase(Trim(Replace(FORM.display_name,"/","-","all")))) />
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
			
			<!--- shipping information --->
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
				
			<!--- price information --->
			<cfset LOCAL.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true}) />
								
			<cfif FORM.product_type EQ "single">
			
				<cfset LOCAL.product.removeSubProducts() />
			
				<cfset LOCAL.product.setSku(Trim(FORM.single_sku)) />
				<cfset LOCAL.product.setStock(Trim(FORM.single_stock)) />
				<cfset LOCAL.product.setProductType(EntityLoad("product_type",{name="single"},true)) />
				<cfif StructKeyExists(FORM,"single_advanced_price_settings")>
					<cfset LOCAL.subProduct.setAdvancedPrice(true) />
				<cfelse>
					<cfset LOCAL.subProduct.setAdvancedPrice(false) />
				</cfif>
				
				<cfloop array="#LOCAL.customerGroups#" index="LOCAL.group">
					<cfset LOCAL.groupPrice = EntityNew("product_customer_group_rela") />
					<cfset LOCAL.groupPrice.setProduct(LOCAL.product) /> />
					<cfset LOCAL.groupPrice.setCustomerGroup(LOCAL.group) /> />
					
					<cfif StructKeyExists(FORM,"single_advanced_price_settings")>
						<cfset LOCAL.newPrice = Trim(FORM["single_advanced_price_#LOCAL.group.getCustomerGroupId()#"]) />
						<cfset LOCAL.newSpecialPrice = Trim(FORM["single_advanced_special_price_#LOCAL.group.getCustomerGroupId()#"]) />
						<cfset LOCAL.newSpecialPriceFromDate = Trim(FORM["single_advanced_from_date_#LOCAL.group.getCustomerGroupId()#"]) />
						<cfset LOCAL.newSpecialPriceToDate = Trim(FORM["single_advanced_to_date_#LOCAL.group.getCustomerGroupId()#"]) />
					<cfelse>
						<cfset LOCAL.newPrice = Trim(FORM.single_simple_price) />
						<cfset LOCAL.newSpecialPrice = Trim(FORM.single_simple_special_price) />
						<cfset LOCAL.newSpecialPriceFromDate = "" />
						<cfset LOCAL.newSpecialPriceToDate = "" />
					</cfif>
					
					<cfset LOCAL.groupPrice.setPrice(LOCAL.newPrice) />
					<cfif IsNumeric(LOCAL.newSpecialPrice)>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(LOCAL.newSpecialPrice) />
					<cfelse>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(JavaCast("NULL","")) />
					</cfif>
					<cfif IsDate(LOCAL.newSpecialPriceFromDate)>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(LOCAL.newSpecialPriceFromDate) />
					<cfelse>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(JavaCast("NULL","")) />
					</cfif>
					<cfif IsDate(LOCAL.newSpecialPriceToDate)>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(LOCAL.newSpecialPriceToDate) />
					<cfelse>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(JavaCast("NULL","")) />
					</cfif>
					
					<!--- for listing page sorting --->
					<cfif LOCAL.group.getIsDefault() EQ true>
						<cfset LOCAL.product.setPriceMV(LOCAL.newPrice) />
					</cfif>
					
					<cfset EntitySave(LOCAL.groupPrice) />
				</cfloop>
				
			<cfelseif FORM.product_type EQ "configurable">
			
				<cfset LOCAL.product.removeProductCustomerGroupRelas() />
				
				<cfloop array="#LOCAL.product.getSubProducts()#" index="LOCAL.subProduct">
					<cfif ListFind(FORM.c_sub_product_id, LOCAL.subProduct.getProductId())>
						<cfset LOCAL.subProduct.setSku(FORM["c_sub_product_sku_#LOCAL.sub_product_id#"]) />
						<cfset LOCAL.subProduct.setStock(FORM["c_sub_product_stock_#LOCAL.sub_product_id#"]) />
						
						<cfif StructKeyExists(FORM,"c_sub_product_use_advanced_price_#LOCAL.sub_product_id#")>
							<cfset LOCAL.subProduct.setAdvancedPrice(true) />
						<cfelse>
							<cfset LOCAL.subProduct.setAdvancedPrice(false) />
						</cfif>
						
						<cfloop array="#LOCAL.customerGroups#" index="LOCAL.group">
							<cfif StructKeyExists(FORM,"c_sub_product_use_advanced_price_#LOCAL.sub_product_id#")>
								<cfset LOCAL.newPrice = Trim(FORM["c_sub_product_price_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
								<cfset LOCAL.newSpecialPrice =Trim(FORM["c_sub_product_specialprice_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
								<cfset LOCAL.newSpecialPriceFromDate = Trim(FORM["c_sub_product_fromdate_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
								<cfset LOCAL.newSpecialPriceToDate = Trim(FORM["c_sub_product_todate_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
							<cfelse>
								<cfset LOCAL.newPrice = Trim(FORM["c_sub_product_simple_price_#LOCAL.sub_product_id#"]) />
								<cfset LOCAL.newSpecialPrice = Trim(FORM["c_sub_product_simple_special_price_#LOCAL.sub_product_id#"]) />
								<cfset LOCAL.newSpecialPriceFromDate = "" />
								<cfset LOCAL.newSpecialPriceToDate = "" />
							</cfif>
						
							<cfset LOCAL.productCustomerGroupRela = EntityLoad("product_customer_group_rela",{product = LOCAL.subProduct, customerGroup = LOCAL.group},true) />
							<cfset LOCAL.productCustomerGroupRela.setPrice(LOCAL.newPrice) />
							<cfif IsNumeric(LOCAL.newSpecialPrice)>
								<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(LOCAL.newSpecialPrice) />
							<cfelse>
								<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(JavaCast("NULL","")) />
							</cfif>
							<cfif IsDate(LOCAL.newSpecialPriceFromDate)>
								<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(LOCAL.newSpecialPriceFromDate) />
							<cfelse>
								<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(JavaCast("NULL","")) />
							</cfif>
							<cfif IsDate(LOCAL.newSpecialPriceToDate)>
								<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(LOCAL.newSpecialPriceToDate) />
							<cfelse>
								<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(JavaCast("NULL","")) />
							</cfif>
							
							<!--- for listing page sorting --->
							<cfif LOCAL.group.getIsDefault() EQ true>
								<cfset LOCAL.product.setPriceMV(LOCAL.newPrice) />
							</cfif>
							
							<cfset EntitySave(LOCAL.productCustomerGroupRela) />
						</cfloop>
					<cfelse>
						<cfset EntityDelete(LOCAL.subProduct) />
					</cfif>
				</cfloop>
				
				<cfloop list="#FORM.c_sub_product_id#" index="LOCAL.sub_product_id">
					<cfif NOT IsNumeric(LOCAL.sub_product_id)>
						<cfset LOCAL.newSubProduct = EntityNew("product")>
						<cfset LOCAL.newSubProduct.setParentProduct(LOCAL.product) />
						<cfset LOCAL.newSubProduct.setProductType(EntityLoad("product_type",{name="option"},true)) />
						<cfset LOCAL.newSubProduct.setStock(LOCAL.product.getStock()) />
						<cfset LOCAL.newSubProduct.setCreatedUser(SESSION.adminUser) />
						<cfset LOCAL.newSubProduct.setCreatedDatetime(Now()) />
						
						<cfset LOCAL.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true}) />
					
						<cfloop array="#LOCAL.customerGroups#" index="LOCAL.customerGroup">
							<cfset LOCAL.groupPrice = EntityNew("product_customer_group_rela") />
							<cfset LOCAL.groupPrice.setProduct(LOCAL.newSubProduct) />
							<cfset LOCAL.groupPrice.setCustomerGroup(LOCAL.customerGroup) />
							
							<cfset LOCAL.productCustomerGroupRela = EntityLoad("product_customer_group_rela",{product=LOCAL.product,customerGroup=LOCAL.customerGroup},true) />
							
							<cfset LOCAL.groupPrice.setPrice(LOCAL.productCustomerGroupRela.getPrice()) />
							<cfset LOCAL.groupPrice.setSpecialPrice(LOCAL.productCustomerGroupRela.getPrice()) />
							<cfset LOCAL.groupPrice.setSpecialPriceFromDate(LOCAL.productCustomerGroupRela.getSpecialPriceFromDate()) />
							<cfset LOCAL.groupPrice.setSpecialPriceToDate(LOCAL.productCustomerGroupRela.getSpecialPriceToDate()) />
							<cfset EntitySave(LOCAL.groupPrice) />
						</cfloop>
					
						<cfloop list="#ARGUMENTS.attributeValueIdList#" index="LOCAL.attributeValueId">
							<cfset LOCAL.attributeValue = EntityLoadByPK("attribute_value", LOCAL.attributeValueId) />
							
							<cfset LOCAL.newProductAttributeRela = EntityNew("product_attribute_rela") />
							<cfset LOCAL.newProductAttributeRela.setProduct(LOCAL.newSubProduct) />
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
						
						<cfset EntitySave(LOCAL.newSubProduct) />
						<cfset LOCAL.newSubProduct.setSKU(LOCAL.product.getSKU() & "-" & LOCAL.newSubProduct.getProductId()) />
						<cfset EntitySave(LOCAL.newSubProduct) />
						<cfset LOCAL.product.addSubProduct(LOCAL.newSubProduct) />
						<cfset EntitySave(LOCAL.product) />
						<cfset ORMFlush() />
					</cfif>
				</cfloop>
			
			
			
				<cfloop list="#FORM.c_attribute_id#" index="LOCAL.attribute_id">
					<cfset LOCAL.existingProductAttributeRela = EntityLoad("product_attribute_rela",{product = LOCAL.product, attribute = EntityLoadByPK("attribute",LOCAL.attribute_id)},true) />
					<cfif NOT IsNull(LOCAL.existingProductAttributeRela)>
						<cfset LOCAL.existingProductAttributeRela.set
					<cfelse>
						<cfset LOCAL.productAttributeRela = EntityNew("product_attribute_rela") />
						<cfset LOCAL.productAttributeRela.setProduct(LOCAL.product) />
						<cfset LOCAL.productAttributeRela.setAttribute(EntityLoadByID("attribute",LOCAL.attribute_id)) />
						
						<cfloop list="#FORM["c_sub_product_id_#LOCAL.sub_product_id#"]#" index="LOCAL.aoid">
						
						
						</cfloop>
						
						<cfset EntitySave(LOCAL.productAttributeRela) />
					</cfif>
				</cfloop>
			
			
				
			
			
				
			</cfif>
				
			<cfset EntitySave(LOCAL.product) />
			
			
			
			
			
			
			
			
			<cfif FORM.tax_category_id NEQ "">
				<cfset LOCAL.product.setTaxCategory(EntityLoadByPK("tax_category",FORM.tax_category_id)) />
			</cfif>
			
			<!--- attribute information --->
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
				
				<cfset EntitySave(LOCAL.product) />
				<cfset ORMFlush() />
				
				<cfif FORM.new_attribute_option_id_list NEQ "">
					<cfloop list="#FORM.new_attribute_option_id_list#" index="LOCAL.i">
						<cfif StructKeyExists(FORM,"new_attribute_option_#LOCAL.i#_aset#FORM.attribute_set_id#_attribute_id")>
							<cfset LOCAL.newAttributeOptionAttributeId = FORM["new_attribute_option_#LOCAL.i#_aset#FORM.attribute_set_id#_attribute_id"] />
							<cfset LOCAL.newAttributeOptionName = Trim(FORM["new_attribute_option_#LOCAL.i#_name"]) />
							<cfset LOCAL.newAttributeOptionAttributeName = Trim(FORM["new_attribute_option_name_hidden"]) />
							<cfif LOCAL.newAttributeOptionAttributeName EQ "color">
								<cfset LOCAL.newAttributeOptionThumbnailLabel = Trim(FORM["new_attribute_option_#LOCAL.i#_thumbnail_label"]) />
							<cfelse>
								<cfset LOCAL.newAttributeOptionThumbnailLabel = LOCAL.newAttributeOptionName />
							</cfif>
							<cfset LOCAL.newAttributeOptionGenerateOption = FORM["new_attribute_option_#LOCAL.i#_generate_option"] />
							<cfset LOCAL.newAttributeOptionRquired = FORM["new_attribute_option_#LOCAL.i#_req"] />			
							<cfset LOCAL.newAttributeOptionImage = FORM["new_attribute_option_#LOCAL.i#_image"] />			
						
							<cfset LOCAL.newAttributeOptionAttribute = EntityLoadByPK("attribute",LOCAL.newAttributeOptionAttributeId) />
						
							<cfset LOCAL.productAttributeRela = EntityLoad("product_attribute_rela",{product=LOCAL.product,attribute=LOCAL.newAttributeOptionAttribute},true) />
									
							<cfset LOCAL.newAttributeValue = EntityNew("attribute_value") />
							<cfset LOCAL.newAttributeValue.setProductAttributeRela(LOCAL.productAttributeRela) />
							<cfset LOCAL.newAttributeValue.setValue(LOCAL.newAttributeOptionThumbnailLabel) />
							<cfset LOCAL.newAttributeValue.setDisplayName(LOCAL.newAttributeOptionName) />
							<cfset LOCAL.newAttributeValue.setName(LCase(LOCAL.newAttributeOptionName)) />
							<cfset LOCAL.newAttributeValue.setThumbnailLabel(LOCAL.newAttributeOptionThumbnailLabel) />
							
							<cfset LOCAL.imageDir = "#APPLICATION.absolutePathRoot#images\uploads\product\#LOCAL.product.getProductId()#\" />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>	
												
							<cfif LOCAL.newAttributeOptionImage NEQ "">
								<cffile action = "upload"  
										fileField = "new_attribute_option_#LOCAL.i#_image"
										destination = "#LOCAL.imageDir#"
										nameConflict = "MakeUnique"> 
								
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
														imageNameWithExtension = cffile.serverFile,
														sizeArray = LOCAL.sizeArray) />
								
								<cfif LOCAL.newAttributeOptionGenerateOption EQ 1>
									<cfset LOCAL.newAttributeValue.setThumbnailImageName("thumbnail_#cffile.serverFile#") />
								<cfelseif LOCAL.newAttributeOptionGenerateOption EQ 2>
									<cfset LOCAL.newAttributeValue.setImageName(cffile.serverFile) />
								<cfelseif LOCAL.newAttributeOptionGenerateOption EQ 3>
									<cfset LOCAL.newAttributeValue.setImageName(cffile.serverFile) />
									<cfset LOCAL.newAttributeValue.setThumbnailImageName("thumbnail_#cffile.serverFile#") />
								</cfif>
							</cfif>
							
							<cfset EntitySave(LOCAL.newAttributeValue) />
							<cfset LOCAL.ProductAttributeRela.addAttributeValue(LOCAL.newAttributeValue) />
							<cfset EntitySave(LOCAL.ProductAttributeRela) />
						</cfif>
					</cfloop>
				</cfif>
				
				<cfif FORM.remove_attribute_option_id_list NEQ "">
					<cfloop list="#FORM.remove_attribute_option_id_list#" index="LOCAL.i">
						<cfset LOCAL.attributeValue = EntityLoadByPK("attribute_value",LOCAL.i) />
						<cfset EntityDelete(LOCAL.attributeValue) />
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
			<cfset LOCAL.product.removeProductShippingCarrierRelas() />
			
			<cfloop list="#FORM.shipping_carrier_id#" index="LOCAL.shippingCarrierId">
				<cfset LOCAL.shippingCarrier = EntityLoadByPK("shipping_carrier",LOCAL.shippingCarrierId) />
				<cfset LOCAL.newProductShippingCarrierRela = EntityNew("product_shipping_carrier_rela") />
				<cfset LOCAL.newProductShippingCarrierRela.setShippingCarrier(LOCAL.shippingCarrier) />
				<cfset LOCAL.newProductShippingCarrierRela.setProduct(LOCAL.product) />
				
				<cfif IsNumeric(FORM["default_price_#LOCAL.shippingCarrierId#"])>
					<cfset LOCAL.newProductShippingCarrierRela.setPrice(FORM["default_price_#LOCAL.shippingCarrierId#"]) />
				<cfelse>
					<cfset LOCAL.newProductShippingCarrierRela.setPrice(0) />
				</cfif>
				
				<cfif StructKeyExists(FORM,"use_default_price_#LOCAL.shippingCarrierId#") AND FORM["use_default_price_#LOCAL.shippingCarrierId#"] EQ 1>
					<cfset LOCAL.newProductShippingCarrierRela.setUseDefaultPrice(true) />
				<cfelse>
					<cfset LOCAL.newProductShippingCarrierRela.setUseDefaultPrice(false) />
				</cfif>
				
				<cfset EntitySave(LOCAL.newProductShippingCarrierRela) />
				
				<cfset LOCAL.product.addProductShippingCarrierRela(LOCAL.newProductShippingCarrierRela) />
			</cfloop>
					
			<!--- product images --->
			<cfif NOT IsNull(LOCAL.product.getImages())>
				<cfloop array="#LOCAL.product.getImages()#" index="LOCAL.img">
					<cfif StructKeyExists(FORM,"rank_#LOCAL.img.getProductImageId()#") AND IsNumeric(FORM["rank_#LOCAL.img.getProductImageId()#"])>
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
			<cfset ORMFlush() />
			
			<!--- related product --->
			<cfset LOCAL.product.removeAllRelatedProducts() />
		
			<cfif StructKeyExists(FORM,"products_selected") AND FORM.products_selected NEQ "">
				<cfloop list="#FORM.products_selected#" index="LOCAL.productId">
					<cfset LOCAL.product.addRelatedProduct(EntityLoadByPK("product",LOCAL.productId)) />
				</cfloop>
			</cfif>
			
			<!--- videos --->
			<cfif NOT IsNumeric(FORM.id)>
				<cfloop from="1" to="5" index="LOCAL.i">
					<cfif Trim(FORM["video#LOCAL.i#"]) NEQ "">
						<cfset LOCAL.newProductVideo = EntityNew("product_video") />
						<cfset LOCAL.newProductVideo.setURL(Trim(FORM["video#LOCAL.i#"])) />
						<cfset LOCAL.newProductVideo.setProduct(LOCAL.product) />
						<cfset EntitySave(LOCAL.newProductVideo) />
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
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree(isSpecial=false) />
		<cfset LOCAL.pageData.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true},"isDefault Desc") />
		<cfset LOCAL.pageData.taxCategories = EntityLoad("tax_category") />
		<cfset LOCAL.pageData.productGroups = EntityLoad("product_group") />
		<cfset LOCAL.pageData.attributes = EntityLoad("attribute",{isDeleted = false}, "attributeId ASC") />
		<cfset LOCAL.pageData.defaultCustomerGroup = EntityLoad("customer_group",{isDefault = true},true) />
		<cfset LOCAL.pageData.specialCategories = EntityLoad("category",{isDeleted = false, isSpecial = true, isEnabled = true},"rank Asc") />
		<cfset LOCAL.pageData.shippingCarriers = EntityLoad("shipping_carrier",{isEnabled = true}) />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.productService.setId(URL.id) />
			<cfset LOCAL.pageData.product = EntityLoadByPK("product", URL.id)>
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayNameMV()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			<cfset LOCAL.pageData.customerGroupPrices = LOCAL.productService.getCustomerGroupPrices() />
			<cfset LOCAL.pageData.defaultCustomerGroup = EntityLoad("customer_group",{isDefault = true},true) />
			<cfset LOCAL.pageData.defaultCustomerGroupPrice = EntityLoad("product_customer_group_rela", {product = LOCAL.pageData.product, customerGroup = EntityLoad("customer_group",{isDefault = true},true)},true) />
			<cfset LOCAL.pageData.attributeList = "" />
			<cfloop array="#LOCAL.pageData.product.getProductAttributeRelas()#" index="LOCAL.productAttributeRela">
				<cfset LOCAL.pageData.attributeList &= "#LOCAL.productAttributeRela.getAttribute().getAttributeId()#," />
			</cfloop>
			
			<cfif NOT ArrayIsEmpty(LOCAL.pageData.product.getSubProducts())>
				<cfset LOCAL.pageData.productArray = LOCAL.pageData.product.getSubProducts() />
			<cfelse>
				<cfset LOCAL.pageData.productArray = [] />
				<cfset ArrayAppend(LOCAL.pageData.productArray, LOCAL.pageData.product) />
			</cfif>
						
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.product.getDisplayNameMV())?"":LOCAL.pageData.product.getDisplayNameMV() />
				<cfset LOCAL.pageData.formData.detail = isNull(LOCAL.pageData.product.getDetailMV())?"":LOCAL.pageData.product.getDetailMV() />
				<cfset LOCAL.pageData.formData.sku = isNull(LOCAL.pageData.product.getSku())?"":LOCAL.pageData.product.getSku() />
				<cfset LOCAL.pageData.formData.stock = isNull(LOCAL.pageData.product.getStock())?"":LOCAL.pageData.product.getStock() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.product.getIsEnabledMV())?"":LOCAL.pageData.product.getIsEnabledMV() />
				<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.product.getTitleMV())?"":LOCAL.pageData.product.getTitleMV() />
				<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.product.getKeywordsMV())?"":LOCAL.pageData.product.getKeywordsMV() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.product.getDescriptionMV())?"":LOCAL.pageData.product.getDescriptionMV() />
				<cfset LOCAL.pageData.formData.attribute_set_id = isNull(LOCAL.pageData.product.getAttributeSetMV())?"":LOCAL.pageData.product.getAttributeSetMV().getAttributeSetId() />
				<cfset LOCAL.pageData.formData.tax_category_id = isNull(LOCAL.pageData.product.getTaxCategoryMV())?"":LOCAL.pageData.product.getTaxCategoryMV().getTaxCategoryId() />
				<cfset LOCAL.pageData.formData.length = isNull(LOCAL.pageData.product.getLengthMV())?"":LOCAL.pageData.product.getLengthMV() />
				<cfset LOCAL.pageData.formData.height = isNull(LOCAL.pageData.product.getHeightMV())?"":LOCAL.pageData.product.getHeightMV() />
				<cfset LOCAL.pageData.formData.width = isNull(LOCAL.pageData.product.getWidthMV())?"":LOCAL.pageData.product.getWidthMV() />
				<cfset LOCAL.pageData.formData.weight = isNull(LOCAL.pageData.product.getWeightMV())?"":LOCAL.pageData.product.getWeightMV() />
		
				<cfset LOCAL.pageData.formData.price = isNull(LOCAL.pageData.defaultCustomerGroupPrice.getPrice())?"":LOCAL.pageData.defaultCustomerGroupPrice.getPrice() />
				<cfset LOCAL.pageData.formData.special_price = isNull(LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPrice())?"":LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPrice() />
				<cfset LOCAL.pageData.formData.special_price_from_date = isNull(LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPriceFromDate())?"":LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPriceFromDate() />
				<cfset LOCAL.pageData.formData.special_price_to_date = isNull(LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPriceToDate())?"":LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPriceToDate() />
				
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Product | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			<cfset LOCAL.pageData.attributeList = "" />
			
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
				
				<cfset LOCAL.pageData.formData.price = "" />
				<cfset LOCAL.pageData.formData.special_price = "" />
				<cfset LOCAL.pageData.formData.special_price_from_date = "" />
				<cfset LOCAL.pageData.formData.special_price_to_date = "" />
				
				<cfset LOCAL.pageData.formData.video1 = "" />
				<cfset LOCAL.pageData.formData.video2 = "" />
				<cfset LOCAL.pageData.formData.video3 = "" />
				<cfset LOCAL.pageData.formData.video4 = "" />
				<cfset LOCAL.pageData.formData.video5 = "" />
				
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
		<cfargument name="parentProductId" type="numeric" required="true">
		<cfargument name="attributeValueIdList" type="string" required="true">
	
		<cfset LOCAL.parentProduct = EntityLoadByPK("product",ARGUMENTS.parentProductId)>
		<cfset LOCAL.newProduct = EntityNew("product")>
		<cfset LOCAL.newProduct.setParentProduct(LOCAL.parentProduct) />
		<cfset LOCAL.newProduct.setProductType(EntityLoad("product_type",{name="option"},true)) />
		<cfset LOCAL.newProduct.setStock(LOCAL.parentProduct.getStock()) />
		<cfset LOCAL.newProduct.setCreatedUser(SESSION.adminUser) />
		<cfset LOCAL.newProduct.setCreatedDatetime(Now()) />
		
		<cfset LOCAL.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true}) />
	
		<cfloop array="#LOCAL.customerGroups#" index="LOCAL.customerGroup">
			<cfset LOCAL.groupPrice = EntityNew("product_customer_group_rela") />
			<cfset LOCAL.groupPrice.setProduct(LOCAL.newProduct) />
			<cfset LOCAL.groupPrice.setCustomerGroup(LOCAL.customerGroup) />
			
			<cfset LOCAL.productCustomerGroupRela = EntityLoad("product_customer_group_rela",{product=LOCAL.parentProduct,customerGroup=LOCAL.customerGroup},true) />
			
			<cfset LOCAL.groupPrice.setPrice(LOCAL.productCustomerGroupRela.getPrice()) />
			<cfset LOCAL.groupPrice.setSpecialPrice(LOCAL.productCustomerGroupRela.getPrice()) />
			<cfset LOCAL.groupPrice.setSpecialPriceFromDate(LOCAL.productCustomerGroupRela.getSpecialPriceFromDate()) />
			<cfset LOCAL.groupPrice.setSpecialPriceToDate(LOCAL.productCustomerGroupRela.getSpecialPriceToDate()) />
			<cfset EntitySave(LOCAL.groupPrice) />
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
		<cfset LOCAL.newProduct.setSKU(LOCAL.parentProduct.getSKU() & "-" & LOCAL.newProduct.getProductId()) />
		<cfset EntitySave(LOCAL.newProduct) />
		<cfset LOCAL.parentProduct.addSubProduct(LOCAL.newProduct) />
		<cfset EntitySave(LOCAL.parentProduct) />
		<cfset ORMFlush() />
		
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