<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Addresses | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"update_address")>
			<cfset LOCAL.address = EntityLoadByPK("address",FORM.submitted_address_id) />
			<cfset LOCAL.address.setCompany(FORM["company_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setFirstName(FORM["first_name_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setMiddleName(FORM["middle_name_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setLastName(FORM["last_name_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setPhone(FORM["phone_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setUnit(FORM["unit_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setStreet(FORM["street_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setCity(FORM["city_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setProvince(EntityLoadByPK("province",FORM["province_id_#FORM.submitted_address_id#"])) />)
			<cfset LOCAL.address.setCountry(EntityLoadByPK("country",FORM["country_id_#FORM.submitted_address_id#"])) />)
			<cfset LOCAL.address.setPostalCode(FORM["postal_code_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setUpdatedDatetime(Now()) />
			<cfset LOCAL.address.setUpdatedUser(SESSION.user.userName) />
			<cfset EntitySave(LOCAL.address) />
			
			<cfset LOCAL.messageArray = [] />
			<cfset ArrayAppend(LOCAL.messageArray,"Your address has been updated") />
			<cfif ArrayLen(LOCAL.messageArray) GT 0>
				<cfset SESSION.temp.message = {} />
				<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
				<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>