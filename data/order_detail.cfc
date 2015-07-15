<cfcomponent extends="master">	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT StructKeyExists(URL,"id")>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#myaccount/orders.cfm" />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Order Detail | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.order = EntityLoadByPK("order",URL.id) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>