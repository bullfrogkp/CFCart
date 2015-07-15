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
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"update_address")>
			<cfset LOCAL.address = EntityLoadByPK("address",FORM.submitted_address_id) />
			<cfset LOCAL.address.setCompany(FORM["company_#FORM.submitted_address_id#"]) />
			<cfset LOCAL.address.setFirstName(getShippingAddressStruct().firstName) />
			<cfset LOCAL.address.setMiddleName(getShippingAddressStruct().firstName) />
			<cfset LOCAL.address.setLastName(getShippingAddressStruct().lastName) />
			<cfset LOCAL.address.setPhone(getShippingAddressStruct().phone) />
			<cfset LOCAL.address.setUnit(getShippingAddressStruct().unit) />
			<cfset LOCAL.address.setStreet(getShippingAddressStruct().street) />
			<cfset LOCAL.address.setCity(getShippingAddressStruct().city) />
			<cfset LOCAL.address.setProvince(EntityLoadByPK("province",getShippingAddressStruct().provinceId)) />
			<cfset LOCAL.address.setCountry(EntityLoadByPK("country",getShippingAddressStruct().countryId)) />
			<cfset LOCAL.address.setPostalCode(getShippingAddressStruct().postalCode) />
			<cfset LOCAL.address.setIsDeleted(false) />
			<cfset LOCAL.address.setUpdatedDatetime(Now()) />
			<cfset LOCAL.address.setUpdatedUser(SESSION.user.userName) />
			<cfset EntitySave(LOCAL.address) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>