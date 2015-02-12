<!---
<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeId" column="filter_id" fieldtype="id" generator="native"> 
    <cfproperty name="value" column="filter_value" ormtype="string">
	<cfproperty name="attributeGroups" fieldtype="many-to-many" cfc="attribute_group" linktable="attribute_group_attribute_rela" fkcolumn="attribute_id" inversejoincolumn="attribute_group_id" orderby="attributeId">
</cfcomponent>
--->