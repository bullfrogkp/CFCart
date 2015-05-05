<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfset LOCAL.currentPageName = "index" />
		
		<cfset LOCAL.currentPage = EntityLoad("page", {name = LOCAL.currentPageName},true)> 
		<cfset LOCAL.slideSection = EntityLoad("page_section", {name="slide",page=LOCAL.currentPage},true)> 
		<cfset LOCAL.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.currentPage},true)> 
		<cfset LOCAL.topSellingSection = EntityLoad("page_section", {name="top selling",page=LOCAL.currentPage},true)> 
		<cfset LOCAL.groupBuyingSection = EntityLoad("page_section", {name="group buying",page=LOCAL.currentPage},true)> 
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfif NOT IsNull(LOCAL.advertisementSection.getAdvertisements())>
				<cfloop array="#LOCAL.advertisementSection.getAdvertisements()#" index="LOCAL.ad">
					<cfif IsNumeric(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"])>
						<cfset LOCAL.ad.setRank(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
				</cfloop>
			</cfif>
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.newAdvertisement = EntityNew("page_section_advertisement") />
							<cfset LOCAL.newAdvertisement.setName(LOCAL.imgName) />
							<cfset LOCAL.newAdvertisement.setSection(LOCAL.advertisementSection) />
							<cfset EntitySave(LOCAL.newAdvertisement) />
							
							<cfset LOCAL.advertisementSection.addAdvertisement(LOCAL.newAdvertisement) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif NOT IsNull(LOCAL.topSellingSection.getProducts())>
				<cfloop array="#LOCAL.topSellingSection.getProducts()#" index="LOCAL.sectionProduct">
					<cfif IsNumeric(FORM["top_selling_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"])>
						<cfset LOCAL.sectionProduct.setRank(FORM["top_selling_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"]) />
						<cfset EntitySave(LOCAL.sectionProduct) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif NOT IsNull(LOCAL.groupBuyingSection.getProducts())>
				<cfloop array="#LOCAL.groupBuyingSection.getProducts()#" index="LOCAL.sectionProduct">
					<cfif IsNumeric(FORM["group_buying_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"])>
						<cfset LOCAL.sectionProduct.setRank(FORM["group_buying_rank_#LOCAL.sectionProduct.getPageSectionProductId()#"]) />
						<cfset EntitySave(LOCAL.sectionProduct) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset LOCAL.currentPage.setTitle(Trim(FORM.title)) />			
			<cfset LOCAL.currentPage.setKeywords(Trim(FORM.keywords)) />			
			<cfset LOCAL.currentPage.setDescription(Trim(FORM.description)) />	
			<cfset LOCAL.slideSection.setContent(Trim(FORM.slide_content)) />
			
			<cfset EntitySave(LOCAL.slideSection) />
			<cfset EntitySave(LOCAL.currentPage) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?&active_tab_id=#FORM.tab_id#" />
			
		<cfelseif StructKeyExists(FORM,"add_top_selling_product")>
		
			<cfif StructKeyExists(FORM,"top_selling_product_group_id")>			
				<cfloop list="#FORM.top_selling_product_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.relatedProductGroup = EntityLoadByPK("related_product_group",LOCAL.groupId) />
					<cfloop array="#LOCAL.relatedProductGroup.getRelatedProducts()#" index="LOCAL.relatedProduct">
						<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
						<cfset LOCAL.newSectionProduct.setSection(LOCAL.topSellingSection) />
						<cfset LOCAL.newSectionProduct.setProduct(LOCAL.relatedProduct) />
						<cfset EntitySave(LOCAL.newSectionProduct) />
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_top_selling_product_id)>
				<cfset LOCAL.newProduct = EntityLoadByPK("product",FORM.new_top_selling_product_id) />
				<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
				<cfset LOCAL.newSectionProduct.setSection(LOCAL.topSellingSection) />
				<cfset LOCAL.newSectionProduct.setProduct(LOCAL.newProduct) />
				<cfset EntitySave(LOCAL.newSectionProduct) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_3" />
			
		<cfelseif StructKeyExists(FORM,"add_group_buying_product")>
		
			<cfif StructKeyExists(FORM,"group_buying_product_group_id")>			
				<cfloop list="#FORM.group_buying_product_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.relatedProductGroup = EntityLoadByPK("related_product_group",LOCAL.groupId) />
					<cfloop array="#LOCAL.relatedProductGroup.getRelatedProducts()#" index="LOCAL.relatedProduct">
						<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
						<cfset LOCAL.newSectionProduct.setSection(LOCAL.groupBuyingSection) />
						<cfset LOCAL.newSectionProduct.setProduct(LOCAL.relatedProduct) />
						<cfset EntitySave(LOCAL.newSectionProduct) />
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_group_buying_product_id)>
				<cfset LOCAL.newProduct = EntityLoadByPK("product",FORM.new_group_buying_product_id) />
				<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
				<cfset LOCAL.newSectionProduct.setSection(LOCAL.groupBuyingSection) />
				<cfset LOCAL.newSectionProduct.setProduct(LOCAL.newProduct) />
				<cfset EntitySave(LOCAL.newSectionProduct) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_4" />
			
		<cfelseif StructKeyExists(FORM,"delete_top_selling_product")>
			
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.delete_top_selling_product_id) />
			<cfset LOCAL.sectionProduct = EntityLoad("page_section_product", {section = LOCAL.topSellingSection, product = LOCAL.product}, true) />
			<cfset LOCAL.topSellingSection.removePageProduct(LOCAL.sectionProduct) />
			
			<cfset EntitySave(LOCAL.topSellingSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_3" />
			
		<cfelseif StructKeyExists(FORM,"delete_group_buying_product")>
		
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.delete_group_buying_product_id) />
			<cfset LOCAL.sectionProduct = EntityLoad("page_product", {section = LOCAL.groupBuyingSection, product = LOCAL.product}, true) />
			<cfset LOCAL.groupBuyingSection.removePageProduct(LOCAL.sectionProduct) />
			
			<cfset EntitySave(LOCAL.groupBuyingSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_4" />
			
		<cfelseif StructKeyExists(FORM,"delete_ad")>
			
			<cfset LOCAL.ad = EntityLoadByPK("page_section_advertisement",FORM.deleted_ad_id) />
			<cfset LOCAL.currentPage.removeAdvertisement(LOCAL.ad) />
			<cfset EntitySave(LOCAL.currentPage) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Advertise image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?&active_tab_id=tab_2" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Homepage | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		
		<cfset LOCAL.currentPageName = "index" />
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name = LOCAL.currentPageName},true)>
		<cfset LOCAL.pageData.slideSection = EntityLoad("page_section", {name="slide",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.topSellingSection = EntityLoad("page_section", {name="top selling",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.groupBuyingSection = EntityLoad("page_section", {name="group buying",page=LOCAL.pageData.currentPage},true)> 
		
		<cfset LOCAL.pageData.relatedProductGroups = EntityLoad("related_product_group") />
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.title = LOCAL.pageData.currentPage.getTitle() />
			<cfset LOCAL.pageData.formData.keywords = LOCAL.pageData.currentPage.getKeywords() />
			<cfset LOCAL.pageData.formData.description = LOCAL.pageData.currentPage.getDescription() />
			<cfset LOCAL.pageData.formData.slide_content = LOCAL.pageData.slideSection.getContent() />
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>