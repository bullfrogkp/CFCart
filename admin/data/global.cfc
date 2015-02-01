<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="integer"> 
    <cfproperty name="URLStruct" type="struct"> 
    <cfproperty name="FORMStruct" type="struct"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		<cfargument name="URLStruct" type="struct" required="false" />
		<cfargument name="FORMStruct" type="struct" required="false" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		
		<cfif StructKeyExists(ARGUMENTS,"URLStruct")>
			<cfset setURLStruct(ARGUMENTS.URLStruct) />
		</cfif>
		
		<cfif StructKeyExists(ARGUMENTS,"FORMStruct")>
			<cfset setFORMStruct(ARGUMENTS.FORMStruct) />
		</cfif>
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="validateGlobalAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT StructKeyExists(SESSION,"admin_user") AND VARIABLES.pageName NEQ "login">
			<cfset LOCAL.redirectUrl = "login.cfm" />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadGlobalPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
		
		<cfreturn LOCAL.page_data />
	</cffunction>
	
	<cffunction name="processGlobalFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.formdata = Duplicate(FORM) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateGlobalFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processGlobalFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>