<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.relatedProductGroup = EntityLoadByPK("related_product_group", FORM.id)> 
		<cfelse>
			<cfset LOCAL.relatedProductGroup = EntityNew("related_product_group") />
			<cfset LOCAL.relatedProductGroup.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.relatedProductGroup.setCreatedDatetime(Now()) />
			<cfset LOCAL.relatedProductGroup.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
		
			<cfset LOCAL.relatedProductGroup.setDiplayName(Trim(FORM.display_name)) />
			
			<cfset EntitySave(LOCAL.relatedProductGroup) />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.relatedProductGroup.getRelatedProductGroupId()#" />
			
		<cfelseif StructKeyExists(FORM,"add_related_product")>
			
			<cfset LOCAL.newProduct = EntityLoadByPK("product", FORM.new_related_product_id) />
			
			<cfset LOCAL.relatedProductGroup.addRelatedProduct(LOCAL.newProduct) />
			
			<cfset EntitySave(LOCAL.relatedProductGroup) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Related product has been added successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.relatedProductGroup.getRelatedProductGroupId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_related_product")>
			
			<cfset LOCAL.relatedProduct = EntityLoadByPK("product", FORM.related_product_id) />
			
			<cfset LOCAL.relatedProductGroup.removewRelatedProduct(LOCAL.relatedProduct) />
			
			<cfset EntitySave(LOCAL.relatedProductGroup) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Related product has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.relatedProductGroup.getRelatedProductGroupId()#" />
					
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.relatedProduct.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.relatedProduct) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Related product group has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/related_product_groups.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.relatedProductGroup = EntityLoadByPK("related_product_group", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.relatedProductGroup.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = LOCAL.pageData.relatedProductGroup.getDisplayName() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "Related Product Group | #APPLICATION.applicationName#" />
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