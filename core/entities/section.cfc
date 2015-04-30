<cfcomponent persistent="true"> 
    <cfproperty name="sectionId" column="section_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="content" column="content" ormtype="text"> 
	<cfproperty name="page" fieldtype="many-to-one" cfc="page" fkcolumn="page_id">
	<cfproperty name="pageProducts" type="array" fieldtype="one-to-many" cfc="page_product" fkcolumn="section_id" singularname="pageProduct">
	<cfproperty name="advertisements" type="array" fieldtype="one-to-many" cfc="advertisement" fkcolumn="section_id" singularname="advertisement">
</cfcomponent>