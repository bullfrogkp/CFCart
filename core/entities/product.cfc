<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native"> 
	<cfproperty name="sku" column="title" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	<cfproperty name="attributeSetId" column="attribute_set_id" ormtype="integer"> 
	<cfproperty name="attributeValueSetId" column="attribute_value_set_id" ormtype="integer"> 
	<cfproperty name="attributeValuePermutationSetId" column="attribute_value_permutation_set_id" ormtype="integer"> 
	<cfproperty name="taxCategoryId" column="tax_category_id" ormtype="integer"> 
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="productId">
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" orderby="productId">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
</cfcomponent>
