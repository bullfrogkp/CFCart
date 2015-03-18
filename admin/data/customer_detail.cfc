<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif IsValid("email",Trim(FORM.email)) EQ false>
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email.") />
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
		
		<cfset LOCAL.customerService = new "#APPLICATION.componentPathRoot#core.services.customerService"() />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.tab_id = FORM.tab_id />
		<cfelse>
			<cfset LOCAL.tab_id = "tab_1" />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfif IsNumeric(FORM.id)>
				<cfset LOCAL.customer = EntityLoadByPK("customer", FORM.id)> 
			<cfelse>
				<cfset LOCAL.customer = EntityNew("customer") />
			</cfif>
			
			<cfset LOCAL.customer.setFirstName(Trim(FORM.first_name)) />
			<cfset LOCAL.customer.setMiddleName(Trim(FORM.middle_name)) />
			<cfset LOCAL.customer.setLastName(Trim(FORM.last_name)) />
			<cfset LOCAL.customer.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.customer.setPrefix(Trim(FORM.prefix)) />
			<cfset LOCAL.customer.setSuffix(Trim(FORM.suffix)) />
			<cfset LOCAL.customer.setEmail(Trim(FORM.email)) />
			<cfset LOCAL.customer.setGender(Trim(FORM.gender)) />
			<cfset LOCAL.customer.setWebsite(Trim(FORM.website)) />
			<cfset LOCAL.customer.setSubscribed(FORM.subscribed) />
			<cfset LOCAL.customer.setComments(FORM.comments) />
			<cfset LOCAL.customer.setDateOfBirth(Trim(FORM.date_of_birth)) />
			<cfset LOCAL.customer.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.customer.setCreatedDatetime(Now()) />
			
			<cfset EntitySave(LOCAL.customer) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Customer has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.customer.getCustomerId()#&active_tab_id=#LOCAL.tab_id#" />
		<cfelseif StructKeyExists(FORM,"delete_item")>
			<cfset LOCAL.customer = EntityLoadByPK("customer", FORM.id)> 
			<cfset LOCAL.customer.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.customer) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Customer #LOCAL.customer.getDisplayName()# has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/customers.cfm" />
			
		<cfelseif StructKeyExists(FORM,"add_new_address")>
			<cfset LOCAL.customer = EntityLoadByPK("customer", FORM.id)> 
			<cfset LOCAL.newAddress = EntityNew("address") />
			<cfset LOCAL.newAddress.setStreet(FORM.new_address_street) />
			<cfset LOCAL.newAddress.setUnit(FORM.new_address_unit) />
			<cfset LOCAL.newAddress.setCity(FORM.new_address_city) />
			<cfset LOCAL.newAddress.setProvince(EntityLoadByPK("province", FORM.new_address_province_id)) />
			<cfset LOCAL.newAddress.setPostalCode(FORM.new_address_postal_code) />
			<cfset LOCAL.newAddress.setCountry(EntityLoadByPK("province", FORM.new_address_country_id)) />
			<cfset EntitySave(LOCAL.newAddress) />
			
			<cfset LOCAL.customer.addAddress(LOCAL.newAddress) />
			<cfset EntitySave(LOCAL.customer) />
		
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Address has been added.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.customer.getCustomerId()#&active_tab_id=tab_4" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.customerService = new "#APPLICATION.componentPathRoot#core.services.customerService"() />
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.customer = EntityLoadByPK("customer", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.customer.getFirstName()# #LOCAL.pageData.customer.getMiddleName()# #LOCAL.pageData.customer.getLastName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
		<cfelse>
			<cfset LOCAL.pageData.customer = EntityNew("customer") />
			<cfset LOCAL.pageData.title = "New Customer | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
		</cfif>
		
		<cfset LOCAL.pageData.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true}) />
			
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.first_name = isNull(LOCAL.pageData.customer.getFirstName())?"":LOCAL.pageData.customer.getFirstName() />
			<cfset LOCAL.pageData.formData.middle_name = isNull(LOCAL.pageData.customer.getFirstName())?"":LOCAL.pageData.customer.getMiddleName() />
			<cfset LOCAL.pageData.formData.last_name = isNull(LOCAL.pageData.customer.getFirstName())?"":LOCAL.pageData.customer.getLastName() />
			<cfset LOCAL.pageData.formData.prefix = isNull(LOCAL.pageData.customer.getPrefix())?"":LOCAL.pageData.customer.getPrefix() />
			<cfset LOCAL.pageData.formData.suffix = isNull(LOCAL.pageData.customer.getSuffix())?"":LOCAL.pageData.customer.getSuffix() />
			<cfset LOCAL.pageData.formData.email = isNull(LOCAL.pageData.customer.getEmail())?"":LOCAL.pageData.customer.getEmail() />
			<cfset LOCAL.pageData.formData.gender = isNull(LOCAL.pageData.customer.getGender())?"":LOCAL.pageData.customer.getGender() />
			<cfset LOCAL.pageData.formData.website = isNull(LOCAL.pageData.customer.getWebsite())?"":LOCAL.pageData.customer.getWebsite() />
			<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.customer.getIsEnabled())?"":LOCAL.pageData.customer.getIsEnabled() />
			<cfset LOCAL.pageData.formData.phone = isNull(LOCAL.pageData.customer.getPhone())?"":LOCAL.pageData.customer.getPhone() />
			<cfset LOCAL.pageData.formData.last_login_datetime = isNull(LOCAL.pageData.customer.getLastLoginDatetime())?"":DateFormat(LOCAL.pageData.customer.getLastLoginDatetime(),"mmm dd, yyyy") />
			<cfset LOCAL.pageData.formData.last_login_ip = isNull(LOCAL.pageData.customer.getLastLoginIp())?"":LOCAL.pageData.customer.getLastLoginIp() />
			<cfset LOCAL.pageData.formData.date_of_birth = isNull(LOCAL.pageData.customer.getDateOfBirth())?"":DateFormat(LOCAL.pageData.customer.getDateOfBirth(),"mmm dd, yyyy") />
			<cfset LOCAL.pageData.formData.created_datetime = isNull(LOCAL.pageData.customer.getCreatedDatetime())?"":DateFormat(LOCAL.pageData.customer.getCreatedDatetime(),"mmm dd, yyyy") />
			<cfset LOCAL.pageData.formData.created_user = isNull(LOCAL.pageData.customer.getCreatedUser())?"":LOCAL.pageData.customer.getCreatedUser() />
			<cfset LOCAL.pageData.formData.subscribed = isNull(LOCAL.pageData.customer.getSubscribed())?"":LOCAL.pageData.customer.getSubscribed() />
			<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.customer.getDescription())?"":LOCAL.pageData.customer.getDescription() />
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>