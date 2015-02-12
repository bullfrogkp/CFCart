<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeSetId" column="attribute_set_id" fieldtype="id" generator="native">
    <cfproperty name="entityTypeId" column="entity_type_id" ormtype="integer" default="-1"> 
	<cfproperty name="attributes" fieldtype="many-to-many" cfc="attribute" linktable="attribute_set_attribute_rela" fkcolumn="attribute_set_id" inversejoincolumn="attribute_id" orderby="attributeId">
</cfcomponent>