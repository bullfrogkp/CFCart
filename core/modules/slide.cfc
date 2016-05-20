<cfcomponent extends="module">	
    <cffunction name="getFrondEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.slideSection = EntityLoad("page_section", {name="slide",page=LOCAL.pageData.currentPage},true)>
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
</cfcomponent>