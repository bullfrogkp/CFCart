<cfcomponent extends="admin.application">
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		<cfargument type="struct" name="URLStruct" required="false"/>
		<cfargument type="struct" name="FORMStruct" required="false"/>
		
		<cfif FileExists("#APPLICATION.absolutePathRoot#data\#ARGUMENTS.pageName#.cfc")>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.#ARGUMENTS.pageName#"(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.master"(argumentCollection = ARGUMENTS) />
		</cfif>
		
		<cfreturn pageObj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initGlobalPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		<cfargument type="struct" name="URLStruct" required="false"/>
		<cfargument type="struct" name="FORMStruct" required="false"/>
		
		<cfset var pageObj = new "#APPLICATION.componentPathRoot#data.global"(argumentCollection = ARGUMENTS) />
		
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