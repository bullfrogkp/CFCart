<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValuePermutationSetId" column="attribute_value_permutation_set_id" fieldtype="id" generator="native"> 
	<cfproperty name="attributeValuePermutationItems" type="array" fieldtype="one-to-many" cfc="attribute_value_permutation_item" fkcolumn="attributeValuePermutationSetId">
</cfcomponent>
