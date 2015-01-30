<cfcomponent persistent="true"> 
    <cfproperty name="categoryId" column="category_id" fieldtype="id" generator="increment"> 
    <cfproperty name="parentCategoryId" column="parent_category_id" ormtype="integer"> 
    <cfproperty name="categoryName" column="category_name" ormtype="string"> 
    <cfproperty name="categoryDisplayName" column="category_display_name" ormtype="string"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
    <cfproperty name="categoryIsEnabled" column="category_is_enabled" ormtype="boolean"> 
    <cfproperty name="showCategoryOnNav" column="show_category_on_nav" ormtype="boolean"> 
	<cfproperty name="categoryTitle" column="category_title" ormtype="string"> 
	<cfproperty name="categoryKeywords" column="category_keywords" ormtype="string"> 
	<cfproperty name="categoryDescription" column="category_description" ormtype="string"> 
	<cfproperty name="categoryCustomDesign" column="category_custom_design" ormtype="text"> 
	<cfproperty name="filterGroupId" column="filter_group_id" ormtype="integer"> 
    <cfproperty name="createDatetime" column="create_datetime" ormtype="date"> 
    <cfproperty name="createUser" column="create_user" ormtype="string"> 
    <cfproperty name="updateDatetime" column="update_datetime" ormtype="date"> 
    <cfproperty name="updateUser" column="update_user" ormtype="string"> 
</cfcomponent>