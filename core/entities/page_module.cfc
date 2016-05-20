﻿<cfcomponent persistent="true"> 
    <cfproperty name="pageModuleId" column="page_module_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string">  
    <cfproperty name="isDeleted" column="is_deleted" ormtype="boolean">  
    <cfproperty name="isEnabled" column="is_enabled" ormtype="boolean">  
	<cfproperty name="frontEndPage" fieldtype="many-to-one" cfc="page" fkcolumn="frontend_page_id">
	<cfproperty name="backEndPage" fieldtype="many-to-one" cfc="page" fkcolumn="backend_page_id">
</cfcomponent>