<cfcomponent persistent="true"> 
    <cfproperty name="filterId" column="filter_id" fieldtype="id" generator="native"> 
    <cfproperty name="filterName" column="filter_name" ormtype="string"> 
    <cfproperty name="filterDisplayName" column="filter_display_name" ormtype="string"> 
    <cfproperty name="filterValue" column="filter_display_name" ormtype="string"> 
    <cfproperty name="filterMinValue" column="filter_display_name" ormtype="string"> 
    <cfproperty name="filterMaxValue" column="filter_display_name" ormtype="string"> 
    <cfproperty name="filterIsEnabled" column="category_is_enabled" ormtype="boolean"> 
    <cfproperty name="filterIsDeleted" column="category_is_deleted" ormtype="boolean"> 
    <cfproperty name="createdDatetime" column="created_datetime" ormtype="date"> 
    <cfproperty name="createdUser" column="create_user" ormtype="string"> 
    <cfproperty name="updatedDatetime" column="updated_datetime" ormtype="date"> 
    <cfproperty name="updatedUser" column="update_user" ormtype="string"> 
	<cfproperty name="filterGroups" fieldtype="many-to-many" cfc="filter_group" linktable="filter_group_filer_rela" fkcolumn="filter_id" inversejoincolumn="filter_group_id" orderby="filterGroupId">
</cfcomponent>