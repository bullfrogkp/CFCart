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
				
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>