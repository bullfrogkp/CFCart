<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" fieldtype="id" generator="native">
    <cfproperty name="productId" column="product_id" ormtype="integer">
    <cfproperty name="attributeSetId" column="attribute_set_id" ormtype="integer">
    <cfproperty name="attributeId" column="attribute_id" ormtype="integer">
    <cfproperty name="imagePath" column="image_path" ormtype="string">
    <cfproperty name="value" column="value" ormtype="string">
    <cfproperty name="minValue" column="min_value" ormtype="string">
    <cfproperty name="maxValue" column="max_value" ormtype="string">
</cfcomponent>
