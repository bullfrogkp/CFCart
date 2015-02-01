<cfcomponent extends="admin.application">
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolutePathRoot#data\#ARGUMENTS.pageName#.cfc")>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.#ARGUMENTS.pageName#"(pageName = ARGUMENTS.pageName) />
		<cfelse>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.master"(pageName = ARGUMENTS.pageName) />
		</cfif>
		
		<cfreturn pageObj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initGlobalPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		
		<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.global"(pageName = ARGUMENTS.pageName) />
		
		<cfreturn pageObj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absoluteUrlWeb#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>