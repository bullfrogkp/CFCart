<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValuePermutationId" column="attribute_value_permutation_id" fieldtype="id" generator="native"> 
	<cfproperty name="attributeSetId" column="attribute_set_id" ormtype="integer">
	<cfproperty name="attributeValuePermutationItems" type="array" fieldtype="one-to-many" cfc="attribute_value_permutation_item" fkcolumn="attributeValuePermutationId">
</cfcomponent>
