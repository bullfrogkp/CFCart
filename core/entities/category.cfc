<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="categoryId" column="category_id" fieldtype="id" generator="native"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
    <cfproperty name="showCategoryOnNavigation" column="show_category_on_navigation" ormtype="boolean"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="customDesign" column="custom_design" ormtype="text"> 
	
	<cfproperty name="filterGroup" fieldtype="one-to-one" cfc="filter_group" fkcolumn="filter_group_id">
	<cfproperty name="parentCategory" fieldtype="many-to-one" cfc="category" fkcolumn="parent_category_id">
	
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="category_image" fkcolumn="category_id" singularname="image" orderby="rank">
	<cfproperty name="categoryFilterRelas" type="array" fieldtype="one-to-many" cfc="category_filter_rela" fkcolumn="category_id">
	<cfproperty name="products" fieldtype="many-to-many" cfc="product" linktable="category_product_rela" fkcolumn="category_id" inversejoincolumn="product_id">
	
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	<cfproperty name="subCategories" type="array" persistent="false"> 
	
	<cffunction name="removeAllCategoryFilterRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategoryFilterRelas())>
			<cfset ArrayClear(getCategoryFilterRelas()) />
		</cfif>
	</cffunction>
</cfcomponent>