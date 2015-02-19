<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" fieldtype="id" generator="native">
    <cfproperty name="value" column="value" ormtype="string">
    <cfproperty name="attributeId" column="attribute_id" ormtype="integer">
    <cfproperty name="minValue" column="min_value" ormtype="string">
    <cfproperty name="maxValue" column="max_value" ormtype="string">
	<cfproperty name="productId" fieldtype="many-to-one" cfc="product"> 
</cfcomponent>
