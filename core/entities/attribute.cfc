<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeId" column="attribute_id" fieldtype="id" generator="native">
	<cfproperty name="filters" type="array" fieldtype="one-to-many" cfc="filter" fkcolumn="attribute_id" singularname="filter">
	<cfproperty name="attributeSetAttributeRelas" type="array" fieldtype="one-to-many" cfc="attribute_set_attribute_rela" fkcolumn="attribute_id">
</cfcomponent>
