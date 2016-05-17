<cfcomponent persistent="true"> 
    <cfproperty name="pageId" column="page_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="title" column="title" ormtype="string"> 
    <cfproperty name="keywords" column="keywords" ormtype="text"> 
    <cfproperty name="description" column="description" ormtype="text"> 
	<cfproperty name="modules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="page_id" singularname="module" cascade="delete-orphan">
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="getActiveModules" access="public" output="false" returnType="any">
		
		<cfreturn EntityLoad("page_module",{page = this, isDeleted = false, isEnabled = true}) />
		
	</cffunction>
</cfcomponent>