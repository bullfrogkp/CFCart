<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" fieldtype="id" generator="native">
    <cfproperty name="imageName" column="image_name" ormtype="string">
    <cfproperty name="value" column="value" ormtype="string">
    <cfproperty name="minValue" column="min_value" ormtype="string">
    <cfproperty name="maxValue" column="max_value" ormtype="string">
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set" fkcolumn="attribute_set_id">
	<cfproperty name="attribute" fieldtype="many-to-one" cfc="attribute" fkcolumn="attribute_id">
</cfcomponent>
