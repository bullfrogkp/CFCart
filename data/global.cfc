<cfcomponent>	
	<cfset VARIABLES.page_name = "" />
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="page_name" type="string" required="true" />
		
		<cfset VARIABLES.page_name = ARGUMENTS.page_name />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="validateGlobalAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
				
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadGlobalPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
		
		<cfreturn LOCAL.page_data />
	</cffunction>
	
	<cffunction name="processGlobalFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfset SESSION.temp.formdata = Duplicate(FORM) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateGlobalFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processGlobalFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "" />
	
		<cfif StructKeyExists(FORM,"search_category_id")>
			<cfset LOCAL.redirect_url = "#APPLICATION.absolute_url_web#search_results.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>