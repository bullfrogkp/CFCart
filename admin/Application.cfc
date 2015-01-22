<cfcomponent output="false">
	<!------------------------------------------------------------------------------->
	<cfset this.name = Config().name>
	<cfset this.ormenabled = Config().ormenabled> 
	<cfset this.ormsettings.dbCreate = Config().ormsettings.dbCreate>
	<cfset this.ormsettings.cfclocation = Config().ormsettings.cfclocation>
	<cfset this.datasource = Config().datasource> 
	<cfset this.sessionmanagement = Config().sessionmanagement>
	<cfset this.sessionTimeout = Config().sessionTimeout>
 
    <cffunction name="Config" access="public" returntype="struct" output="false" hint="Returns the Application.cfc configuration settings struct based on the execution environment (production, staging, development, etc).">
		<cfargument type="boolean" name="reload" required="false" default="false"/>
		
		<cfif ARGUMENTS.reload EQ true OR NOT StructKeyExists( THIS, "$Config" )>
            <cfset THIS[ "$Config" ] = {} />
            <cfif Find( "127.0.0.1", CGI.server_name ) OR Find( "localhost", CGI.server_name )>
                <!--- Set development environment. --->
                <cfset THIS[ "$Config" ].islive = false />
                <cfset THIS[ "$Config" ].name = "threestar" />
                <cfset THIS[ "$Config" ].ormenabled = "false" />
                <cfset THIS[ "$Config" ].ormsettings = {} />
                <cfset THIS[ "$Config" ].ormsettings.dbCreate = "update" />
                <cfset THIS[ "$Config" ].ormsettings.cfclocation = "/cfcart/core/entity/" />
                <cfset THIS[ "$Config" ].datasource = "db_eshop" />
                <cfset THIS[ "$Config" ].sessionmanagement = "yes" />
                <cfset THIS[ "$Config" ].sessionTimeout = CreateTimeSpan(0,12,0,0) /> 
				
				<cfset THIS[ "$Config" ].env = {} />
				<cfset THIS[ "$Config" ].env.domain = "pinmydeals.com">
				<cfset THIS[ "$Config" ].env.email_customer_service = "customerservice@#THIS[ "$Config" ].env.domain#">
				<cfset THIS[ "$Config" ].env.email_admin = "admin@#THIS[ "$Config" ].env.domain#">
				<cfset THIS[ "$Config" ].env.email_development = "dev@#THIS[ "$Config" ].env.domain#">
				<cfset THIS[ "$Config" ].env.email_info = "info@#THIS[ "$Config" ].env.domain#">
				
				<!--- customized local vars --->
				<cfset var folder_name = "cfcart" />
				<cfset THIS[ "$Config" ].env.url_root = "127.0.0.1:8500">	
				
				<!--- absolute url --->
				<cfset THIS[ "$Config" ].env.absolute_url_web = "/#folder_name#/">	
				<!--- absolute path --->	
				<cfset THIS[ "$Config" ].env.absolute_path_root = ExpandPath(THIS[ "$Config" ].env.absolute_url_web) >
				<!--- url --->
				<cfset THIS[ "$Config" ].env.url_web = "http://#THIS[ "$Config" ].env.url_root##THIS[ "$Config" ].env.absolute_url_web#">
				<cfset THIS[ "$Config" ].env.url_https_web = "https://#THIS[ "$Config" ].env.url_root##THIS[ "$Config" ].env.absolute_url_web#">
				<!--- component --->
				<cfset THIS[ "$Config" ].env.component_path_root = "#folder_name#.">
            <cfelse>
                <!--- Set production environment. --->
                <cfset THIS[ "$Config" ].islive = true />
                <cfset THIS[ "$Config" ].name = "eshop" />
                <cfset THIS[ "$Config" ].ormenabled = "false" />
                <cfset THIS[ "$Config" ].ormsettings = {} />
                <cfset THIS[ "$Config" ].ormsettings.dbCreate = "update" />
				<cfset THIS[ "$Config" ].ormsettings.cfclocation = "/core/entity/" />
                <cfset THIS[ "$Config" ].datasource = "bullfrog" />
                <cfset THIS[ "$Config" ].sessionmanagement = "yes" />
                <cfset THIS[ "$Config" ].sessionTimeout = CreateTimeSpan(0,12,0,0) /> 
				
				<cfset THIS[ "$Config" ].env = {} />
				<cfset THIS[ "$Config" ].env.domain = "bullfrogdesign.ca">
				<cfset THIS[ "$Config" ].env.email_customer_service = "customerservice@#THIS[ "$Config" ].env.domain#">
				<cfset THIS[ "$Config" ].env.email_admin = "admin@#THIS[ "$Config" ].env.domain#">
				<cfset THIS[ "$Config" ].env.email_development = "dev@#THIS[ "$Config" ].env.domain#">
				<cfset THIS[ "$Config" ].env.email_info = "info@#THIS[ "$Config" ].env.domain#">
				<!--- absolute url --->
				<cfset THIS[ "$Config" ].env.absolute_url_web = "/cfcart/">	
				<!--- absolute path --->	
				<cfset THIS[ "$Config" ].env.absolute_path_root = ExpandPath(THIS[ "$Config" ].env.absolute_url_web) >
				<!--- url --->
				<cfset THIS[ "$Config" ].env.url_root = "www.#THIS[ "$Config" ].env.domain#">	
				<cfset THIS[ "$Config" ].env.url_web = "http://#THIS[ "$Config" ].env.url_root##THIS[ "$Config" ].env.absolute_url_web#">
				<cfset THIS[ "$Config" ].env.url_https_web = "https://#THIS[ "$Config" ].env.url_root##THIS[ "$Config" ].env.absolute_url_web#">
				<!--- component --->
				<cfset THIS[ "$Config" ].env.component_path_root = "cfcart.">
            </cfif>
        </cfif>
       
        <cfreturn THIS[ "$Config" ] />
    </cffunction>
	<!----------------------------------------------------------------------------
	<cferror type="Exception" template="/error.cfm" >
	<cferror type="Request" template="/error.cfm" >--->

	<!------------------------------------------------------------------------------->
	<cffunction name="onApplicationStart" returntype="boolean" output="false">
		<cfset SetEncoding("form","utf-8") />
		<cfset SetEncoding("url","utf-8") />
		
		<cfset StructAppend(APPLICATION, Config().env) />
		
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onSessionStart" returnType="void">
		<!--- sometimes run after onRequestStart, no fix order between these two functions --->
		<cfset _setUser() />
		<cfset _setTheme("default") />
		<cfset _setAdminTheme("default") />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument type="String" name="current_page_name" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolute_path_root#admin\data\#ARGUMENTS.current_page_name#.cfc")>
			<cfset var page_obj = new "#APPLICATION.component_path_root#admin.data.#current_page_name#"(page_name = ARGUMENTS.current_page_name) />
		<cfelse>
			<cfset var page_obj = new "#APPLICATION.component_path_root#admin.data.master"(page_name = ARGUMENTS.current_page_name) />
		</cfif>
		
		<cfreturn page_obj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initGlobalPageObject" output="false" access="private" returnType="any">
		<cfargument type="String" name="current_page_name" required="true"/>
		
		<cfset var page_obj = new "#APPLICATION.component_path_root#admin.data.global"(page_name = ARGUMENTS.current_page_name) />
		
		<cfreturn page_obj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onRequestStart" returntype="boolean" output="false">
		<cfargument type="String" name="targetPage" required="true"/>

		<cfif NOT StructKeyExists(SESSION,"user")>
			<cfset onSessionStart() />
		</cfif>
		
		<!--- add code for only admin can do it --->
		<cfif StructKeyExists(URL,"resetappvars")>
			<cfset StructAppend(APPLICATION, Config(reload = true).env,true) />
			<cfif reFindNoCase("android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino",CGI.HTTP_USER_AGENT) GT 0 OR reFindNoCase("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-",Left(CGI.HTTP_USER_AGENT,4)) GT 0>
				<cfset _setTheme("default") />
				<cfset _setAdminTheme("default") />
			<cfelse>
				<cfset _setTheme("default") />
				<cfset _setAdminTheme("default") />
			</cfif>
		<cfelseif StructKeyExists(URL,"sitetheme")>
			<cfset _setTheme(URL.sitetheme) />
			<cfif StructKeyExists(URL,"page") AND Trim(URL.page) NEQ "">
				<cflocation url="#URL.page#" addToken="false" />
			</cfif>
		<cfelseif StructKeyExists(URL,"admintheme")>
			<cfset _setAdminTheme(URL.admintheme) />
			<cfif StructKeyExists(URL,"page") AND Trim(URL.page) NEQ "">
				<cflocation url="#URL.page#" addToken="false" />
			</cfif>
		</cfif>
		
		<!--- exclude ajax request --->
		<cfif NOT StructKeyExists(URL,"method")>
			<cfset var current_page_name = Replace(Replace(CGI.SCRIPT_NAME,GetDirectoryFromPath(CGI.SCRIPT_NAME),""),".cfm","") />
			<!---
			<cftry>		
			--->
				<cfset var global_page_obj = _initGlobalPageObject(current_page_name = current_page_name) />
				<cfset var page_obj = _initPageObject(current_page_name = current_page_name) />
				<cfset var return_struct = {} />
				
				<!---
				<cfif StructKeyExists(APPLICATION.support_objs,current_page_name)>
					<cfset var page_obj = StructFind(APPLICATION.support_objs,current_page_name) />
				<cfelse>
				--->
					
				<!---
					<cfset StructInsert(APPLICATION.support_objs,current_page_name) />
				</cfif>
				--->
			
				<cfif IsDefined("FORM") AND NOT StructIsEmpty(FORM)>
					<!--- global data handler --->
					<cfset return_struct = global_page_obj.processGlobalFormDataBeforeValidation() />
					<cfif return_struct.redirect_url NEQ "">
						<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
					</cfif>
					
					<cfset return_struct = global_page_obj.validateGlobalFormData() />
					<cfif return_struct.redirect_url NEQ "">
						<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
					</cfif>
					
					<cfset return_struct = global_page_obj.processGlobalFormDataAfterValidation() />
					<cfif return_struct.redirect_url NEQ "">
						<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
					</cfif>
				
					<!--- page data handler --->
					<cfset return_struct = page_obj.processFormDataBeforeValidation() />
					<cfif return_struct.redirect_url NEQ "">
						<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
					</cfif>
					
					<cfset return_struct = page_obj.validateFormData() />
					<cfif return_struct.redirect_url NEQ "">
						<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
					</cfif>
					
					<cfset return_struct = page_obj.processFormDataAfterValidation() />
					<cfif return_struct.redirect_url NEQ "">
						<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
					</cfif>
					
					<cflocation url = "#_getCurrentURL()#" addToken = "no" />
				</cfif>
						
				<cfset return_struct = global_page_obj.validateGlobalAccessData() />
				<cfif return_struct.redirect_url NEQ "">
					<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
				</cfif>		
						
				<cfset return_struct = page_obj.validateAccessData() />
				<cfif return_struct.redirect_url NEQ "">
					<cflocation url = "#return_struct.redirect_url#" addToken = "no" />
				</cfif>
				
				<cfset REQUEST.page_data = global_page_obj.loadGlobalPageData() />
				<cfset StructAppend(REQUEST.page_data,page_obj.loadPageData()) />
			
				<cfset REQUEST.page_data.current_page_name = current_page_name />
				<cfset REQUEST.page_data.template_path = current_page_name & ".cfm" />
			<!---	
				<cfcatch type="any">
					<cfset new "#APPLICATION.component_path_root#core.util.utils().handleError(cfcatch = cfcatch) />
					<cflocation url="#APPLICATION.absolute_url_web#error.cfm" addtoken="false" />
				</cfcatch>
			</cftry>
			--->
		</cfif>
			
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setTheme"  access="private" returnType="void" output="false">
		<cfargument type="string" name="folder_name_theme" required=true /> 
		
		<cfset SESSION.folder_name_theme = ARGUMENTS.folder_name_theme>		
		<cfset SESSION.url_theme = "#APPLICATION.url_web#themes/#SESSION.folder_name_theme#/">
		<cfset SESSION.absolute_url_theme = "#APPLICATION.absolute_url_web#themes/#SESSION.folder_name_theme#/">
		<cfset SESSION.absolute_path_theme = "#APPLICATION.absolute_path_root#themes\#SESSION.folder_name_theme#\">
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setAdminTheme"  access="private" returnType="void" output="false">
		<cfargument type="string" name="folder_name_theme" required=true /> 
		
		<cfset SESSION.folder_name_theme_admin = ARGUMENTS.folder_name_theme>		
		<cfset SESSION.url_theme_admin = "#APPLICATION.url_web#admin/themes/#SESSION.folder_name_theme_admin#/">
		<cfset SESSION.absolute_url_theme_admin = "#APPLICATION.absolute_url_web#admin/themes/#SESSION.folder_name_theme_admin#/">
		<cfset SESSION.absolute_path_theme_admin = "#APPLICATION.absolute_path_root#admin\themes\#SESSION.folder_name_theme_admin#\">
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setUser"  access="private" returnType="void" output="false">
		<cfinvoke component="#APPLICATION.component_path_root#core.util.user" method="getUser" returnvariable="SESSION.user" />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_getCurrentURL" output="false" access="private" returnType="string">
		<cfset var theURL = getPageContext().getRequest().GetRequestUrl().toString()>
			<cfif len( CGI.query_string )>
				<cfset theURL = theURL & "?" & CGI.query_string>
			</cfif>
		<cfreturn theURL>
	</cffunction>
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absolute_url_web#admin/error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>