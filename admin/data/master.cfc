﻿<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		<cfset SESSION.temp.messageArray = [] />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.formdata = Duplicate(FORM) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.keywords = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="_setRedirectURL" access="private" output="false" returnType="string">
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>	
			<cfif StructKeyExists(URL,"active_tab_id")>	
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#URL.id#&active_tab_id=#URL.active_tab_id#" />
			<cfelse>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#URL.id#" />
			</cfif>
		<cfelse>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm" />
		</cfif>
		
		<cfreturn LOCAL.redirectUrl />	
	</cffunction>
</cfcomponent>