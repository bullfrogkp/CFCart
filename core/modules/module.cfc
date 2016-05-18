<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getFrondEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="getBackEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="getFrondEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
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
</cfcomponent>