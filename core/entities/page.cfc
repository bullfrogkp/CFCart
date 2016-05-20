<cfcomponent persistent="true"> 
    <cfproperty name="pageId" column="page_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="title" column="title" ormtype="string"> 
    <cfproperty name="keywords" column="keywords" ormtype="text"> 
    <cfproperty name="description" column="description" ormtype="text"> 
	<cfproperty name="frontEndModules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="front_end_page_id" singularname="frontEndModule" cascade="delete-orphan">
	<cfproperty name="backEndModules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="back_end_page_id" singularname="backEndModule" cascade="delete-orphan">
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="getFrontEndModuleData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.modules = EntityLoad("page_module",{frontEndPage = this, isDeleted = false, isEnabled = true}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(pageName = getName(), moduleName = LOCAL.module.getName()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getFrontEndData()) />
		</cfloop>
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getBackEndModuleData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.modules = EntityLoad("page_module",{backEndPage = this, isDeleted = false, isEnabled = true}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(pageName = getName(), moduleName = LOCAL.module.getName()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getBackEndData()) />
		</cfloop>
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initModuleObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="pageName" required="true"/>
		<cfargument type="string" name="moduleName" required="true"/>
		<cfset var moduleObj = new "#APPLICATION.componentPathRoot#core.modules.#ARGUMENTS.moduleName#_#ARGUMENTS.pageName#"(pageName = ARGUMENTS.pageName) />
		<cfreturn moduleObj />
	</cffunction>
</cfcomponent>