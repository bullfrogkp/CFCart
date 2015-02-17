<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="categoryId" column="category_id" fieldtype="id" generator="native"> 
    <cfproperty name="parentCategoryId" column="parent_category_id" ormtype="integer"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
    <cfproperty name="showCategoryOnNavigation" column="show_category_on_navigation" ormtype="boolean"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="customDesign" column="custom_design" ormtype="text"> 
	<cfproperty name="filterGroupId" column="filter_group_id" ormtype="integer"> 
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="category_image" fkcolumn="categoryId">
	<cfproperty name="products" fieldtype="many-to-many" cfc="product" linktable="category_product_rela" fkcolumn="category_id" inversejoincolumn="product_id" orderby="productId">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	<cfproperty name="subCategories" type="array" persistent="false"> 
</cfcomponent>