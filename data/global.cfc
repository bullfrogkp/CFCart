<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
    <cfproperty name="URLStruct" type="struct" required="false"> 
    <cfproperty name="FORMStruct" type="struct" required="false"> 
	
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
				
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadGlobalPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfreturn LOCAL.pageData />
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
	
		<cfif StructKeyExists(FORM,"search_category_id")>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#search_results.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>