<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfset LOCAL.homePage = EntityLoad("page", {name="homepage"}, true)> 
		
		<cfif NOT IsNull(LOCAL.homePage)>
			<cfset LOCAL.homePage.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.homePage.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.homePage = EntityNew("page") />
			<cfset LOCAL.homePage.setName("homepage") />
			<cfset LOCAL.homePage.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.homePage.setCreatedDatetime(Now()) />
			<cfset LOCAL.homePage.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.homepageAd = EntityNew("homepage_ad") />
							<cfset LOCAL.homepageAd.setName(LOCAL.imgName) />
							<cfset LOCAL.homepageAd.setIsDeleted(false) />
							<cfset EntitySave(LOCAL.homepageAd) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset LOCAL.homepageAds = EntityLoad("homepage_ad",{isDeleted=false}) />
			
			<cfif NOT ArrayIsEmpty(LOCAL.homepageAds)>
				<cfloop array="#LOCAL.homepageAds#" index="LOCAL.ad">
					<cfif StructKeyExists(FORM,"rank_#LOCAL.ad.getHomepageAdId()#") AND IsNumeric(FORM["rank_#LOCAL.ad.getHomepageAdId()#"])>
						<cfset LOCAL.ad.setRank(FORM["rank_#LOCAL.ad.getHomepageAdId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset LOCAL.homePage.setContent(Trim(FORM.slide_content)) />			
			<cfset EntitySave(LOCAL.homePage) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm" />
			
		<cfelseif StructKeyExists(FORM,"delete_ad")>
			
			<cfset LOCAL.ad = EntityLoadByPK("homepage_ad",FORM.deleted_ad_id) />
			<cfset LOCAL.ad.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.ad) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Advertise image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.page = EntityLoad("page", {name="homepage"},true)> 
		<cfset LOCAL.pageData.title = "Homepage | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		<cfset LOCAL.pageData.homepageAds = EntityLoad("homepage_ad",{isDeleted=false},"rank asc") />	
		<cfset LOCAL.pageData.topSellings = EntityLoad("top_selling",{},"rank asc") />	
		<cfset LOCAL.pageData.groupBuyings = EntityLoad("group_buying",{},"rank asc") />	
		<cfset LOCAL.pageData.relatedProductGroups = EntityLoad("related_product_group") />
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.slide_content = isNull(LOCAL.pageData.page)?"":LOCAL.pageData.page.getContent() />
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>