<cfcomponent persistent="true"> 
    <cfproperty name="filterGroupId" column="filter_group_id" fieldtype="id" generator="native"> 
    <cfproperty name="filterGroupName" column="filter_group_name" ormtype="string"> 
    <cfproperty name="filterGroupDisplayName" column="filter_group_display_name" ormtype="string"> 
    <cfproperty name="categoryIsEnabled" column="category_is_enabled" ormtype="boolean"> 
    <cfproperty name="categoryIsDeleted" column="category_is_deleted" ormtype="boolean"> 
    <cfproperty name="createdDatetime" column="created_datetime" ormtype="date"> 
    <cfproperty name="createdUser" column="create_user" ormtype="string"> 
    <cfproperty name="updatedDatetime" column="updated_datetime" ormtype="date"> 
    <cfproperty name="updatedUser" column="update_user" ormtype="string"> 
	<cfproperty name="filters" fieldtype="many-to-many" cfc="filter" linktable="filter_group_filter_rela" fkcolumn="filter_group_id" inversejoincolumn="filter_id" orderby="filterId">
</cfcomponent>