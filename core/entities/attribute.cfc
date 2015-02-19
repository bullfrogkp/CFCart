<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeId" column="attribute_id" fieldtype="id" generator="native"> 
    <cfproperty name="dataTypeId" column="date_type_id" ormtype="integer">
	<cfproperty name="attributeValues" type="array" persistent="false"> 
	<cfproperty name="attributeSets" fieldtype="many-to-many" cfc="attribute_set" linktable="attribute_set_attribute_rela" fkcolumn="attribute_id" inversejoincolumn="attribute_set_id" orderby="attributeId">
</cfcomponent>
