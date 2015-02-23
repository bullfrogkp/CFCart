<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="specialPrice" column="special_price" ormtype="float"> 
	<cfproperty name="taxCategoryId" column="tax_category_id" ormtype="integer"> 
	<cfproperty name="productTypeId" column="product_type_id" ormtype="integer"> 
	<cfproperty name="attributeSetId" column="attribute_set_id" ormtype="integer"> 
	<cfproperty name="specialPriceFromDate" column="special_price_from_date" ormtype="date"> 
	<cfproperty name="specialPriceToDate" column="special_price_to_date" ormtype="date"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	<cfproperty name="attributeValues" type="array" fieldtype="one-to-many" cfc="attribute_value" fkcolumn="product_id">
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="product_id">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="product_id">
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" singularname="category">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
</cfcomponent>
