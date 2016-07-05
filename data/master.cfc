<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	<cfproperty name="formData" type="struct" required="true"> 
	
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
		
		<cfset SESSION.temp.formdata = Duplicate(FORM) />
		
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
	
	<cffunction name="processPageFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>
	
	<cffunction name="processModuleFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageEntity = EntityLoad("page",{name = getPageName()},true) />
		<cfloop array="#LOCAL.pageEntity.getModules()#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(pageName = getPageName(), moduleName = LOCAL.module.getName()) />
			<cfset LOCAL.moduleObj.processFormData() />
		</cfloop>
		<cfreturn LOCAL />	
	</cffunction>

	<cffunction name="processURLDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="processURLDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>		
	
	<cffunction name="loadData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.pageData = _loadPageData() />
		<cfset LOCAL.retStruct.pageView = _loadPageView() />
		<cfset LOCAL.retStruct.moduleData = _loadModuleData() />
		<cfset LOCAL.retStruct.moduleView = _loadModuleView() />
				
		<cfreturn LOCAL.retStruct />	
	</cffunction>
	
	<cffunction name="_loadPageData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
				
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="_loadPageView" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
				
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="_loadModuleData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.pageEntity = EntityLoad("page",{name = getPageName()},true) />
		<cfloop array="#LOCAL.pageEntity.getModules()#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(pageName = getPageName(), moduleName = LOCAL.module.getName()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getFrontendData()) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	
	<cffunction name="_loadModuleView" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.pageEntity = EntityLoad("page",{name = getPageName()},true) />
		<cfloop array="#LOCAL.pageEntity.getModules()#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(pageName = getPageName(), moduleName = LOCAL.module.getName()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getFrontendView()) />
		</cfloop>
		<cfreturn LOCAL.retStruct />
	</cffunction>
	
	<cffunction name="_setTempMessage" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.message = {} />
	
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.message.messageArray = SESSION.temp.message.messageArray />
			<cfset LOCAL.message.messageType = SESSION.temp.message.messageType />
		</cfif>
		
		<cfreturn LOCAL.message /> 
	</cffunction>
	
	<cffunction name="_getPaginationInfo" access="private" output="false" returnType="struct">
		<cfargument name="recordStruct" type="struct" required="true"> 
		<cfargument name="currentPage" type="numeric" required="true"> 
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.records = ARGUMENTS.recordStruct.records />
		<cfset LOCAL.totalCount = ARGUMENTS.recordStruct.totalCount />
		<cfset LOCAL.totalPages = ARGUMENTS.recordStruct.totalPages />
		
		<cfset LOCAL.currentPage = ARGUMENTS.currentPage />
		
		<cfreturn LOCAL /> 
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_initModuleObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="moduleName" required="true"/>
		<cfset var moduleObj = new "#APPLICATION.componentPathRoot#core.modules.#ARGUMENTS.moduleName#"(pageName = ARGUMENTS.pageName) />
		<cfreturn moduleObj />
	</cffunction>
</cfcomponent>