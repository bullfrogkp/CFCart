<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Sign In | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"checkout_login")>
			<cfset LOCAL.customer = EntityLoadByPK("customer",1) />
			
			<cfset SESSION.user.userName = LOCAL.customer.getFullName() />
			<cfset SESSION.user.customerId = LOCAL.customer.getCustomerId() />
			<cfset SESSION.user.customerGroupName = LOCAL.customer.getCustomerGroup().getName() />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#myaccount/checkout_step1_customer.cfm" />
		
		<cfelseif StructKeyExists(FORM,"guest_checkout")>
		
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#myaccount/checkout_step1_guest.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>