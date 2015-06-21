<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Order Tracking Detail | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.order = EntityLoad("order",{orderTrackingNumber = Trim(FORM.order_number), email = Trim(FORM.email)},true) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>