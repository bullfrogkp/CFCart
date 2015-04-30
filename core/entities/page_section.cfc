<cfcomponent persistent="true"> 
    <cfproperty name="pageSectionId" column="page_section_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="content" column="content" ormtype="text"> 
	<cfproperty name="page" fieldtype="many-to-one" cfc="page" fkcolumn="page_id">
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="page_section_product" fkcolumn="page_section_id" singularname="product">
	<cfproperty name="advertisements" type="array" fieldtype="one-to-many" cfc="page_section_advertisement" fkcolumn="page_section_id" singularname="advertisement">
</cfcomponent>