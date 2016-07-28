<cfcomponent extends="modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />	
		<cfset LOCAL.retStruct = {} />	

		<cfif FileExists("#APPLICATION.absolutePathRoot#core/modules/#getPageName()#_meta.cfc")>
			<cfset LOCAL.retStruct = new "#APPLICATION.componentPathRoot#core.modules.#getPageName()#_meta"(pageName = getPageName(), formData = getFormData(), urlData = getUrlData()).getFrontEndData() />
		<cfelse>
			<cfset LOCAL.retStruct.title = "cpinmydeals" />
			<cfset LOCAL.retStruct.description = "cpinmydeals" />
			<cfset LOCAL.retStruct.keywords = "cpinmydeals" />
		</cfif>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>