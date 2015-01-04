<cfcomponent>	
	<cfset VARIABLES.page_name = "" />
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="page_name" type="string" required="true" />
		
		<cfset VARIABLES.page_name = ARGUMENTS.page_name />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="validateCommonAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfif NOT StructKeyExists(SESSION,"admin_user") AND VARIABLES.page_name NEQ "login">
			<cfset LOCAL.redirect_url = "login.cfm" />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfset SESSION.temp.formdata = Duplicate(FORM) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
				
		<cfreturn LOCAL.page_data />	
	</cffunction>
	
	<cffunction name="loadCommonPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
		
		<cfreturn LOCAL.page_data />
	</cffunction>
</cfcomponent>