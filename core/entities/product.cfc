<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="productId">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category">
	<cfproperty name="productType" fieldtype="many-to-one" cfc="product_type">
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set">
	<cfproperty name="attributeValues" type="array" fieldtype="one-to-many" cfc="attribute_value" fkcolumn="productId">
	<cfproperty name="specialPrices" type="array" fieldtype="one-to-many" cfc="special_price" fkcolumn="productId">
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" orderby="productId">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
</cfcomponent>
