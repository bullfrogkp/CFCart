<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid name.") />
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
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.attributeSet = EntityLoadByPK("attribute_set", FORM.id)> 
		<cfelse>
			<cfset LOCAL.attributeSet = EntityNew("attribute_set") />
			<cfset LOCAL.attributeSet.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.attributeSet.setCreatedDatetime(Now()) />
			<cfset LOCAL.attributeSet.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.attributeSet.setName(Trim(FORM.display_name)) />
			<cfset LOCAL.attributeSet.removeAttributes() />
			
			<cfset LOCAL.currentAttributes = EntityLoad("attribute",{isDeleted=false}) />
			
			<cfloop array="#LOCAL.currentAttributes#" index="LOCAL.attribute">
				<cfif StructKeyExists(FORM,"attribute_#LOCAL.attribute.getAttributeId()#")>
					<cfset LOCAL.attributeSetAttributeRela = EntityNew("attribute_set_attribute_rela") />
					<cfset LOCAL.attributeSetAttributeRela.setAttributeSet(LOCAL.attributeSet) />
					<cfset LOCAL.attributeSetAttributeRela.setAttribute(LOCAL.attribute) />
					<cfset LOCAL.attributeSetAttributeRela.setRequired(StructFind(FORM,"attribute_required_#LOCAL.attribute.getAttributeId()#")) />
					<cfset EntitySave(LOCAL.attributeSetAttributeRela) />
					
					<cfset LOCAL.attributeSet.addAttributeSetAttributeRela(LOCAL.attributeSetAttributeRela) />
				</cfif>
			</cfloop>
			
			<cfset EntitySave(LOCAL.attributeSet) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute set has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.attributeSet.getAttributeSetId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			<cfset LOCAL.attributeSet.setIsDeleted(false) />
			
			<cfset EntitySave(LOCAL.attributeSet) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute set has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/attribute_sets.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.attributes = EntityLoad("attribute",{isDeleted=false}) />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.attributeSet = EntityLoadByPK("attribute_set", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.attributeSet.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.attributeSet.getDisplayName())?"":LOCAL.pageData.attributeSet.getDisplayName() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Attribute Set | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>