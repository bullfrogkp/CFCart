<cfcomponent persistent="true"> 
    <cfproperty name="pageId" column="page_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="title" column="title" ormtype="string"> 
    <cfproperty name="keywords" column="keywords" ormtype="text"> 
    <cfproperty name="description" column="description" ormtype="text"> 
	<cfproperty name="frontEndModules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="front_end_page_id" singularname="frontEndModule" cascade="delete-orphan">
	<cfproperty name="backEndModules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="back_end_page_id" singularname="backEndModule" cascade="delete-orphan">
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="getActiveFrontEndModuleData" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.modules = EntityLoad("page_module",{frontEndPage = this, isDeleted = false, isEnabled = true}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.module) />
		</cfloop>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getActiveBackEndModuleData" access="public" output="false" returnType="any">
		<cfreturn EntityLoad("page_module",{backEndPage = this, isDeleted = false, isEnabled = true}) />
	</cffunction>
</cfcomponent>