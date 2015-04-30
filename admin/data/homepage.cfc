<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfset LOCAL.currentPage = EntityLoad("page", {adminPageName = getPageName()},true)> 
		<cfset LOCAL.slideSection = EntityLoad("section", {name="slide",page=LOCAL.currentPage},true)> 
		<cfset LOCAL.advertisementSection = EntityLoad("section", {name="advertisement",page=LOCAL.currentPage},true)> 
		<cfset LOCAL.topSellingSection = EntityLoad("section", {name="top selling",page=LOCAL.currentPage},true)> 
		<cfset LOCAL.groupBuyingSection = EntityLoad("section", {name="group buying",page=LOCAL.currentPage},true)> 
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfif NOT IsNull(LOCAL.advertisementSection.getAdvertisements())>
				<cfloop array="#LOCAL.advertisementSection.getAdvertisements()#" index="LOCAL.ad">
					<cfif IsNumeric(FORM["advertisement_rank_#LOCAL.ad.getAdvertisementId()#"])>
						<cfset LOCAL.ad.setRank(FORM["advertisement_rank_#LOCAL.ad.getAdvertisementId()#"]) />
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
							<cfset LOCAL.newAdvertisement = EntityNew("advertisement") />
							<cfset LOCAL.newAdvertisement.setName(LOCAL.imgName) />
							<cfset LOCAL.newAdvertisement.setSection(LOCAL.advertisementSection) />
							<cfset EntitySave(LOCAL.newAdvertisement) />
							
							<cfset LOCAL.advertisementSection.addAdvertisement(LOCAL.newAdvertisement) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif NOT IsNull(LOCAL.topSellingSection.getPageProducts())>
				<cfloop array="#LOCAL.topSellingSection.getPageProducts()#" index="LOCAL.pageProduct">
					<cfif IsNumeric(FORM["top_selling_rank_#LOCAL.pageProduct.getPageProductId()#"])>
						<cfset LOCAL.pageProduct.setRank(FORM["top_selling_rank_#LOCAL.pageProduct.getPageProductId()#"]) />
						<cfset EntitySave(LOCAL.pageProduct) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif NOT IsNull(LOCAL.groupBuyingSection.getPageProducts())>
				<cfloop array="#LOCAL.groupBuyingSection.getPageProducts()#" index="LOCAL.pageProduct">
					<cfif IsNumeric(FORM["group_buying_rank_#LOCAL.pageProduct.getPageProductId()#"])>
						<cfset LOCAL.pageProduct.setRank(FORM["group_buying_rank_#LOCAL.pageProduct.getPageProductId()#"]) />
						<cfset EntitySave(LOCAL.pageProduct) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset LOCAL.currentPage.setTitle(Trim(FORM.title)) />			
			<cfset LOCAL.currentPage.setKeywords(Trim(FORM.keywords)) />			
			<cfset LOCAL.currentPage.setDescription(Trim(FORM.description)) />	
			<cfset LOCAL.slideSection.setContent(Trim(FORM.slide_content)) />
			
			<cfset EntitySave(LOCAL.slideSection) />
			<cfset EntitySave(LOCAL.topSellingSection) />
			<cfset EntitySave(LOCAL.groupBuyingSection) />
			<cfset EntitySave(LOCAL.currentPage) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm" />
			
		<cfelseif StructKeyExists(FORM,"add_top_selling_product")>
		
			<cfif StructKeyExists(FORM,"top_selling_product_group_id")>			
				<cfloop list="#FORM.top_selling_product_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.relatedProductGroup = EntityLoadByPK("related_product_group",LOCAL.groupId) />
					<cfloop array="#LOCAL.relatedProductGroup.getRelatedProducts()#" index="LOCAL.relatedProduct">
						<cfset LOCAL.newPageProduct = EntityNew("page_product") />
						<cfset LOCAL.newPageProduct.setSection(LOCAL.topSellingSection) />
						<cfset LOCAL.newPageProduct.setProduct(LOCAL.relatedProduct) />
						<cfset EntitySave(LOCAL.newPageProduct) />
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_top_selling_product_id)>
				<cfset LOCAL.newProduct = EntityLoadByPK("product",FORM.new_top_selling_product_id) />
				<cfset LOCAL.newPageProduct = EntityNew("page_product") />
				<cfset LOCAL.newPageProduct.setSection(LOCAL.topSellingSection) />
				<cfset LOCAL.newPageProduct.setProduct(LOCAL.newProduct) />
				<cfset EntitySave(LOCAL.newPageProduct) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_3" />
			
		<cfelseif StructKeyExists(FORM,"add_group_buying_product")>
		
			<cfif StructKeyExists(FORM,"group_buying_product_group_id")>			
				<cfloop list="#FORM.group_buying_product_group_id#" index="LOCAL.groupId">
					<cfset LOCAL.relatedProductGroup = EntityLoadByPK("related_product_group",LOCAL.groupId) />
					<cfloop array="#LOCAL.relatedProductGroup.getRelatedProducts()#" index="LOCAL.relatedProduct">
						<cfset LOCAL.newPageProduct = EntityNew("page_product") />
						<cfset LOCAL.newPageProduct.setSection(LOCAL.groupBuyingSection) />
						<cfset LOCAL.newPageProduct.setProduct(LOCAL.relatedProduct) />
						<cfset EntitySave(LOCAL.newPageProduct) />
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfif IsNumeric(FORM.new_group_buying_product_id)>
				<cfset LOCAL.newProduct = EntityLoadByPK("product",FORM.new_group_buying_product_id) />
				<cfset LOCAL.newPageProduct = EntityNew("page_product") />
				<cfset LOCAL.newPageProduct.setSection(LOCAL.groupBuyingSection) />
				<cfset LOCAL.newPageProduct.setProduct(LOCAL.newProduct) />
				<cfset EntitySave(LOCAL.newPageProduct) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?active_tab_id=tab_4" />
			
		<cfelseif StructKeyExists(FORM,"delete_top_selling_product")>
			
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.delete_top_selling_product_id) />
			<cfset LOCAL.pageProduct = EntityLoad("page_product", {section = LOCAL.topSellingSection, product = LOCAL.product}, true) />
			<cfset LOCAL.topSellingSection.removePageProduct(LOCAL.pageProduct) />
			
			<cfset EntitySave(LOCAL.topSellingSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_3" />
			
		<cfelseif StructKeyExists(FORM,"delete_group_buying_product")>
		
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.delete_group_buying_product_id) />
			<cfset LOCAL.pageProduct = EntityLoad("page_product", {section = LOCAL.groupBuyingSection, product = LOCAL.product}, true) />
			<cfset LOCAL.groupBuyingSection.removePageProduct(LOCAL.pageProduct) />
			
			<cfset EntitySave(LOCAL.groupBuyingSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_4" />
			
		<cfelseif StructKeyExists(FORM,"delete_ad")>
			
			<cfset LOCAL.ad = EntityLoadByPK("advertisement",FORM.deleted_ad_id) />
			<cfset LOCAL.ad.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.ad) />
			
			<cfset LOCAL.currentPage.removeAdvertisement(LOCAL.ad) />
			<cfset EntitySave(LOCAL.currentPage) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Advertise image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Homepage | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		<cfset LOCAL.pageData.homepageAds = EntityLoad("homepage_ad",{isDeleted=false},"rank asc") />	
		<cfset LOCAL.pageData.topSellings = EntityLoad("top_selling",{},"rank asc") />	
		<cfset LOCAL.pageData.groupBuyings = EntityLoad("group_buying",{},"rank asc") />	
		<cfset LOCAL.pageData.relatedProductGroups = EntityLoad("related_product_group") />
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.page = EntityLoad("page", {name="index"},true)> 
		
			<cfif NOT IsNull(LOCAL.pageData.page)>
				<cfset LOCAL.pageData.formData.title = LOCAL.pageData.page.getTitle() />
				<cfset LOCAL.pageData.formData.keywords = LOCAL.pageData.page.getKeywords() />
				<cfset LOCAL.pageData.formData.description = LOCAL.pageData.page.getDescription() />
				
				<cfset LOCAL.pageData.slide = EntityLoad("section", {name="slide",page=LOCAL.pageData.page},true)> 
				<cfset LOCAL.pageData.formData.slide_content = isNull(LOCAL.pageData.slide)?"":LOCAL.pageData.slide.getContent() />
			<cfelse>
				<cfset LOCAL.pageData.formData.title = "" />
				<cfset LOCAL.pageData.formData.keywords = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.slide_content = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>