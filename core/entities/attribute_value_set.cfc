<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValueSetId" column="attribute_value_set_id" fieldtype="id" generator="native">
    <cfproperty name="attributeSetId" column="attribute_set_id" ormtype="integer">
	<cfproperty name="attributeValues" type="array" fieldtype="one-to-many" cfc="attribute_set_value" fkcolumn="attributeValueSetId">
</cfcomponent>