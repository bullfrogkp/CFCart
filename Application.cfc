<cfcomponent extends="admin.application">
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument type="String" name="current_page_name" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolute_path_root#data\#ARGUMENTS.current_page_name#.cfc")>
			<cfset var page_obj = new "#APPLICATION.component_path_root#data.#current_page_name#"(page_name = ARGUMENTS.current_page_name) />
		<cfelse>
			<cfset var page_obj = new "#APPLICATION.component_path_root#data.master"(page_name = ARGUMENTS.current_page_name) />
		</cfif>
		
		<cfreturn page_obj />
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_initGlobalPageObject" output="false" access="private" returnType="any">
		<cfargument type="String" name="current_page_name" required="true"/>
		
		<cfset var page_obj = new "#APPLICATION.component_path_root#data.global"(page_name = ARGUMENTS.current_page_name) />
		
		<cfreturn page_obj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setTheme"  access="private" returnType="void" output="false">
		<cfargument type="string" name="folder_name_theme" required=true /> 
		
		<cfset SESSION.folder_name_theme = ARGUMENTS.folder_name_theme>		
		<cfset SESSION.url_theme = "#APPLICATION.url_web#themes/#SESSION.folder_name_theme#/">
		<cfset SESSION.absolute_url_theme = "#APPLICATION.absolute_url_web#themes/#SESSION.folder_name_theme#/">
		<cfset SESSION.absolute_path_theme = "#APPLICATION.absolute_path_root#themes\#SESSION.folder_name_theme#\">
	</cffunction>
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absolute_url_web#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>