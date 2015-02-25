<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeSetId" column="attribute_set_id" fieldtype="id" generator="native">
	<cfproperty name="attributeSetAttributeRelas" type="array" fieldtype="one-to-many" cfc="attribute_set_attribute_rela" fkcolumn="attribute_set_id">
</cfcomponent>