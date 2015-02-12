<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValuePermutationItemId" column="attribute_value_permutation_item_id" fieldtype="id" generator="native"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" ormtype="integer">
	<cfproperty name="attributeGroups" fieldtype="many-to-many" cfc="attribute_group" linktable="attribute_group_attribute_rela" fkcolumn="attribute_id" inversejoincolumn="attribute_group_id" orderby="attributeId">
</cfcomponent>
