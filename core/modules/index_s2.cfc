<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.retStruct.categoryTree = LOCAL.categoryService.getCategoryTree(isSpecial=false) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>