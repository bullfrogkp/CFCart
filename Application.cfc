<cfcomponent extends="admin.application">
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="currentPageName" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolutePathRoot#data\#ARGUMENTS.currentPageName#.cfc")>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.#currentPageName#"(pageName = ARGUMENTS.currentPageName) />
		<cfelse>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.master"(pageName = ARGUMENTS.currentPageName) />
		</cfif>
		
		<cfreturn pageObj />
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_initGlobalPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="currentPageName" required="true"/>
		
		<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.global"(pageName = ARGUMENTS.currentPageName) />
		
		<cfreturn pageObj />
	</cffunction>
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absolute_url_web#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>