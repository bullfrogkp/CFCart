<cfcomponent persistent="true"> 
    <cfproperty name="pageId" column="page_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="title" column="title" ormtype="string"> 
    <cfproperty name="keywords" column="keywords" ormtype="text"> 
    <cfproperty name="description" column="description" ormtype="text"> 
	<cfproperty name="frontEndModules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="front_end_page_id" singularname="frontEndModule" cascade="delete-orphan">
	<cfproperty name="backEndModules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="back_end_page_id" singularname="backEndModule" cascade="delete-orphan">
</cfcomponent>