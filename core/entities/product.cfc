<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="specialPrice" column="special_price" ormtype="float"> 
	<cfproperty name="specialPriceFromDate" column="special_price_from_date" ormtype="date"> 
	<cfproperty name="specialPriceToDate" column="special_price_to_date" ormtype="date"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="productId">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category">
	<cfproperty name="productType" fieldtype="many-to-one" cfc="product_type">
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set">
	<cfproperty name="attributeValues" type="array" fieldtype="one-to-many" cfc="attribute_value" fkcolumn="productId">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="productId">
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" orderby="productId">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
</cfcomponent>
