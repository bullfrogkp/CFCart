<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT StructIsEmpty(FORM)>
			<cfset SESSION.temp.formdata = Duplicate(FORM) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="_setRedirectURL" access="private" output="false" returnType="string">
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>	
			<cfif StructKeyExists(URL,"active_tab_id")>	
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#URL.id#&active_tab_id=#URL.active_tab_id#" />
			<cfelse>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#URL.id#" />
			</cfif>
		<cfelse>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm" />
		</cfif>
		
		<cfreturn LOCAL.redirectUrl />	
	</cffunction>
	
	<cffunction name="_setActiveTab" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
	
		<cfset LOCAL.tabs = {} />
		<cfset LOCAL.tabs["tab_1"] = "" />
		<cfset LOCAL.tabs["tab_2"] = "" />
		<cfset LOCAL.tabs["tab_3"] = "" />
		<cfset LOCAL.tabs["tab_4"] = "" />
		<cfset LOCAL.tabs["tab_5"] = "" />
		<cfset LOCAL.tabs["tab_6"] = "" />
		<cfset LOCAL.tabs["tab_7"] = "" />
		<cfset LOCAL.tabs["tab_8"] = "" />
				
		<cfif StructKeyExists(URL,"active_tab_id")>	
			<cfset LOCAL.tabs["activeTabId"] = URL.active_tab_id />
			<cfset LOCAL.tabs["#URL.active_tab_id#"] = "active" />
		<cfelse>
			<cfset LOCAL.tabs["activeTabId"] = "tab_1" />
			<cfset LOCAL.tabs["tab_1"] = "active" />
		</cfif>
		
		<cfreturn LOCAL.tabs /> 
	</cffunction>
	
	<cffunction name="_setTempMessage" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.message = {} />
	
		<cfif IsDefined("SESSION.temp.message")>
			<cfset LOCAL.message.messageArray = SESSION.temp.message.messageArray />
			<cfset LOCAL.message.messageType = SESSION.temp.message.messageType />
		</cfif>
		
		<cfreturn LOCAL.message /> 
	</cffunction>
</cfcomponent>