﻿<cfcomponent extends="admin.application">
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolutePathRoot#data/#ARGUMENTS.pageName#.cfc")>
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
	<cffunction name="onSessionStart" returnType="void">
		<cfset _setUser() />
		<cfset _setCurrency() />
		<cfset _setTrackingRecord() />
		<cfset _setTheme("default") />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onRequestStart" returntype="boolean" output="false">
		<cfargument type="String" name="targetPage" required="true"/>
		
		<cfif NOT StructKeyExists(SESSION,"user")>
			<cfset onSessionStart() />
		</cfif>
		
		<cfif StructKeyExists(URL,"sitetheme")>
			<cfset _setTheme(URL.sitetheme) />
			<cfif StructKeyExists(URL,"page") AND Trim(URL.page) NEQ "">
				<cflocation url="#URL.page#" addToken="false" />
			</cfif>
		</cfif>
		
		<!--- exclude ajax request --->
		<cfif NOT StructKeyExists(URL,"method")>
			<cfset var currentPageName = Replace(Replace(CGI.SCRIPT_NAME,GetDirectoryFromPath(CGI.SCRIPT_NAME),""),".cfm","") />
			<!---
			<cftry>		
			--->
				<cfset var args = {} />
				<cfset args.pageName = currentPageName />
				
				<cfset var globalPageObj = _initGlobalPageObject(argumentCollection = args) />
				<cfset var pageObj = _initPageObject(argumentCollection = args) />
				<cfset var returnStruct = {} />
			
				<!--- form.file is image upload plugin --->
				<cfif IsDefined("FORM") AND NOT StructIsEmpty(FORM) AND NOT StructKeyExists(FORM,"file")>
					<!--- global data handler --->
					<cfset returnStruct = globalPageObj.processGlobalFormDataBeforeValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
					
					<cfset returnStruct = globalPageObj.validateGlobalFormData() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					<cfelse>
						<cfif IsDefined("SESSION.temp.formData")>
							<cfset StructDelete(SESSION.temp,"formData") />
						</cfif>
					</cfif>
					
					<cfset returnStruct = globalPageObj.processGlobalFormDataAfterValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
				
					<!--- page data handler --->
					<cfset returnStruct = pageObj.processFormDataBeforeValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
					
					<cfset returnStruct = pageObj.validateFormData() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					<cfelse>
						<cfif IsDefined("SESSION.temp.formData")>
							<cfset StructDelete(SESSION.temp,"formData") />
						</cfif>
					</cfif>
					
					<cfset returnStruct = pageObj.processFormDataAfterValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
					
					<cflocation url = "#_getCurrentURL()#" addToken = "no" />
				</cfif>
						
				<cfset returnStruct = globalPageObj.validateGlobalAccessData() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>		
				
				<cfset returnStruct = globalPageObj.processGlobalURLDataBeforeValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>		
						
				<cfset returnStruct = pageObj.processURLDataBeforeValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>
				
				<cfset returnStruct = pageObj.validateAccessData() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>
				
				<cfset returnStruct = globalPageObj.processGlobalURLDataAfterValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>		
						
				<cfset returnStruct = pageObj.processURLDataAfterValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>
				
				<cfset REQUEST.pageData = globalPageObj.loadGlobalPageData() />
				<cfset StructAppend(REQUEST.pageData, pageObj.loadPageData()) />
			
				<cfloop array="#pageObj.getActiveFrontEndModules()#" index="module">
					<cfset StructAppend(REQUEST.pageData, module.gerFrontEndData()) />
				</cfloop>
			
				<cfif StructKeyExists(SESSION,"temp")>	
					<cfset StructDelete(SESSION,"temp") />
				</cfif>
			
				<cfset REQUEST.pageData.currentPageName = currentPageName />
				<cfset REQUEST.pageData.templatePath = currentPageName & ".cfm" />
			<!---	
				<cfcatch type="any">
					<cfset new "#APPLICATION.componentPathRoot#core.utils.utils().handleError(cfcatch = cfcatch) />
					<cflocation url="#APPLICATION.absoluteUrlWeb#error.cfm" addtoken="false" />
				</cfcatch>
			</cftry>
			--->
		</cfif>
		
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setUser"  access="private" returnType="void" output="false">
		<cfset var LOCAL = {} />
		<cfset LOCAL.defaultCustomerGroup = EntityLoad("customer_group",{isDefault = true},true) />
		
		<cfset SESSION.user = {} />
		<cfset SESSION.user.userName = CGI.REMOTE_ADDR />
		<cfset SESSION.user.customerId = "" />
		<cfset SESSION.user.customerGroupName = LOCAL.defaultCustomerGroup.getName() />
		<cfset SESSION.user.ip = CGI.REMOTE_ADDR />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setCurrency"  access="private" returnType="void" output="false">
	
		<cfset var defaultCurrency = EntityLoad("currency",{isDefault=true},true) />
	
		<cfset SESSION.currency = {} />
		<cfset SESSION.currency.id = defaultCurrency.getCurrencyId() />
		<cfset SESSION.currency.code = defaultCurrency.getCode() />
		<cfset SESSION.currency.locale = defaultCurrency.getLocale() />
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	<cffunction name="_setTrackingRecord"  access="private" returnType="void" output="false">
		<cfset var trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken}, true) />
		<cfif IsNull(trackingEntity)>
			<cfset trackingEntity = EntityNew("tracking_entity") />
			<cfset trackingEntity.setCfid(COOKIE.cfid) />
			<cfset trackingEntity.setCftoken(COOKIE.cftoken) />
			<cfset trackingEntity.setLastAccessDatetime(Now()) />
			<cfset EntitySave(trackingEntity) />
			<cfset ORMFlush() />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setTheme"  access="private" returnType="void" output="false">
		<cfargument type="string" name="folderNameTheme" required=true /> 
		
		<cfset SESSION.folderNameTheme = ARGUMENTS.folderNameTheme>		
		<cfset SESSION.urlTheme = "#APPLICATION.urlWeb#themes/#SESSION.folderNameTheme#/">
		<cfset SESSION.absoluteUrlTheme = "#APPLICATION.absoluteUrlWeb#themes/#SESSION.folderNameTheme#/">
		<cfset SESSION.absolutePathTheme = "#APPLICATION.absolutePathRoot#themes\#SESSION.folderNameTheme#\">
	</cffunction>
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absoluteUrlWeb#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>