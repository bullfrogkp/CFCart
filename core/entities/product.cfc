<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="category_id" fieldtype="id" generator="native"> 
	<cfproperty name="title" column="title" ormtype="string" default=""> 
	<cfproperty name="keywords" column="keywords" ormtype="string" default=""> 
	<cfproperty name="detail" column="description" ormtype="string" default=""> 
	<cfproperty name="attributeGroupId" column="attribute_group_id" ormtype="integer" default="-1"> 
	<cfproperty name="taxCategoryId" column="tax_category_id" ormtype="integer" default="-1"> 
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="productId">
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" orderby="productId">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
</cfcomponent>