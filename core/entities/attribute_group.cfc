<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeGroupId" column="filter_group_id" fieldtype="id" generator="native">
	<cfproperty name="attributesInGroup" fieldtype="many-to-many" cfc="attribute" linktable="attribute_group_attribute_rela" fkcolumn="attribute_group_id" inversejoincolumn="attribute_id" orderby="attributeId">
	<cfproperty name="attributesForGroup" type="array" fieldtype="one-to-many" cfc="attribute_group_attribute" fkcolumn="attributeGroupId">
</cfcomponent>