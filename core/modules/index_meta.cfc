<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct.title = "pinmydeals" />
		<cfset LOCAL.retStruct.description = "pinmydeals" />
		<cfset LOCAL.retStruct.keywords = "pinmydeals" />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>