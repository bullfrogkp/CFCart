<cfcomponent persistent="true"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" fieldtype="id" generator="native">
	<cfproperty name="name" column="name" ormtype="string">
	<cfproperty name="displayName" column="display_name" ormtype="string">
    <cfproperty name="thumbnailLabel" column="thumbnail" ormtype="string">
    <cfproperty name="thumbnailImageName" column="thumbnail_image_name" ormtype="string">
    <cfproperty name="imageName" column="image_name" ormtype="string">
    <cfproperty name="value" column="value" ormtype="string">
	<cfproperty name="productAttributeRela" fieldtype="many-to-one" cfc="product_attribute_rela" fkcolumn="product_attribute_rela_id">
</cfcomponent>
