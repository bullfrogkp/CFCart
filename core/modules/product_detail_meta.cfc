<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct.title = "apinmydeals" />
		<cfset LOCAL.retStruct.description = "apinmydeals" />
		<cfset LOCAL.retStruct.keywords = "apinmydeals" />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>