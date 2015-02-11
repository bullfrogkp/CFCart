<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeSetId" column="attribute_group_id" fieldtype="id" generator="native">
	<cfproperty name="attributesInSet" fieldtype="many-to-many" cfc="attribute" linktable="attribute_set_attribute_rela" fkcolumn="attribute_set_id" inversejoincolumn="attribute_id" orderby="attributeId">
	<cfproperty name="attributesForSet" type="array" fieldtype="one-to-many" cfc="attribute_set_attribute" fkcolumn="attributeSetId">
</cfcomponent>