<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="categoryId" column="category_id" fieldtype="id" generator="native"> 
    <cfproperty name="parentCategoryId" column="parent_category_id" ormtype="integer" default="-1"> 
    <cfproperty name="categoryName" column="category_name" ormtype="string" default=""> 
    <cfproperty name="categoryDisplayName" column="category_display_name" ormtype="string" default=""> 
    <cfproperty name="rank" column="rank" ormtype="float" default="0"> 
    <cfproperty name="categoryIsEnabled" column="category_is_enabled" ormtype="boolean" default="true"> 
    <cfproperty name="categoryIsDeleted" column="category_is_deleted" ormtype="boolean" default="false"> 
    <cfproperty name="showCategoryOnNav" column="show_category_on_nav" ormtype="boolean" default="true"> 
	<cfproperty name="categoryTitle" column="category_title" ormtype="string" default=""> 
	<cfproperty name="categoryKeywords" column="category_keywords" ormtype="string" default=""> 
	<cfproperty name="categoryDescription" column="category_description" ormtype="string" default=""> 
	<cfproperty name="categoryCustomDesign" column="category_custom_design" ormtype="text" default=""> 
	<cfproperty name="filterGroupId" column="filter_group_id" ormtype="integer" default="-1"> 
	<cfproperty name="categoryImage" type="array" fieldtype="one-to-many" cfc="category_image" fkcolumn="categoryId">
	<cfproperty name="categorySearchKeyword" type="string" persistent="false"> 
	<cfproperty name="subCategories" type="array" persistent="false"> 
</cfcomponent>