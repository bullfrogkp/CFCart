<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValuePermutationItemId" column="attribute_value_permutation_item_id" fieldtype="id" generator="native"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" ormtype="integer">
	<cfproperty name="attributeValuePermutationSet" fieldtype="many-to-one" cfc="attribute_value_permutation_set">
</cfcomponent>
