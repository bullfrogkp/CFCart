<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct.title = "bpinmydeals" />
		<cfset LOCAL.retStruct.description = "bpinmydeals" />
		<cfset LOCAL.retStruct.keywords = "bpinmydeals" />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>