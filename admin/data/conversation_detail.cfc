<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.subject) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter the subject.") />
		</cfif>
		
		<cfif Trim(FORM.content) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter the content.") />
		</cfif>
		
		<cfif StructKeyExists(FORM,"customer_id") AND NOT IsNumeric(Trim(FORM.customer_id))>
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a numeric value for the customer id.") />
		<cfelseif StructKeyExists(FORM,"customer_id") AND IsNumeric(Trim(FORM.customer_id))>
			<cfset LOCAL.customer = EntityLoadByPK("customer",Trim(FORM.customer_id)) />
			<cfif IsNull(LOCAL.customer)>
				<cfset ArrayAppend(LOCAL.messageArray,"Cannot find the customer for id #Trim(FORM.customer_id)#.") />
			</cfif>
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
			<cfset LOCAL.conv = EntityLoadByPK("conversation", FORM.id)> 
			<cfset LOCAL.conv.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.conv.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.conv = EntityNew("conversation") />
			<cfset LOCAL.conv.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.conv.setCreatedDatetime(Now()) />
			<cfset LOCAL.conv.setIsDeleted(false) />
			<cfset LOCAL.conv.setIsNew(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfset LOCAL.conv.setSubject(Trim(FORM.subject)) />
			<cfset LOCAL.conv.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.conv.setContent(Trim(FORM.content)) />
			
			<cfif IsNumeric(FORM.customer_id)>
				<cfset LOCAL.customer = EntityLoadByPK("customer",FORM.customer_id) />
			<cfelse>
				<cfset LOCAL.customer = EntityLoad("customer",{isAnonymous = true}, true) />
			</cfif>
			
			<cfset LOCAL.conv.setCustomer(LOCAL.customer) />
			<cfset EntitySave(LOCAL.conv) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Conversation has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.conv.getConvId()#" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.conv = EntityLoadByPK("conversation", URL.id)> 
			<cfset LOCAL.pageData.conv.setIsNew(false) />
			<cfset EntitySave(LOCAL.pageData.conv) />
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.conv.getSubject()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.conv.getSubject())?"":LOCAL.pageData.conv.getSubject() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.conv.getDescription())?"":LOCAL.pageData.conv.getDescription() />
				<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.conv.getContent())?"":LOCAL.pageData.conv.getContent() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "Conversation | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.content = "" />
				<cfset LOCAL.pageData.formData.customer_id = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>