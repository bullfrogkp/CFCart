<cfcomponent extends="module">	
    <cffunction name="getFrondEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif NOT IsNull(LOCAL.advertisementSection.getSectionData())>
				<cfloop array="#LOCAL.advertisementSection.getSectionData()#" index="LOCAL.ad">
					<cfif IsNumeric(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"])>
						<cfset LOCAL.ad.setRank(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
					<cfif Trim(FORM["advertisement_link_#LOCAL.ad.getPageSectionAdvertisementId()#"]) NEQ "">
						<cfset LOCAL.ad.setLink(FORM["advertisement_link_#LOCAL.ad.getPageSectionAdvertisementId()#"]) />
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
							
							<cfset LOCAL.sizeArray = [{name = "small", width = "200", height = "200", position="center", crop = true}] />	
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlWeb#images/uploads/advertise/") />
							<cfset _createImages(	imagePath = LOCAL.imagePath,
													imageNameWithExtension = LOCAL.imgName,
													sizeArray = LOCAL.sizeArray) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
		
			
		<cfelseif StructKeyExists(FORM,"delete_ad")>
			
			<cfset LOCAL.ad = EntityLoadByPK("page_section_advertisement",FORM.deleted_ad_id) />
			<cfset LOCAL.advertisementSection.removeAdvertisement(LOCAL.ad) />
			<cfset EntitySave(LOCAL.advertisementSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Advertise image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?&active_tab_id=tab_2" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>