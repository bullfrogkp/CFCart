<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="filterGroupId" column="filter_group_id" fieldtype="id" generator="native"> 
    <cfproperty name="filterGroupName" column="filter_group_name" ormtype="string"> 
    <cfproperty name="filterGroupDisplayName" column="filter_group_display_name" ormtype="string"> 
    <cfproperty name="filterGroupIsEnabled" column="category_is_enabled" ormtype="boolean"> 
    <cfproperty name="filterGroupIsDeleted" column="category_is_deleted" ormtype="boolean"> 
	<cfproperty name="filters" fieldtype="many-to-many" cfc="filter" linktable="filter_group_filter_rela" fkcolumn="filter_group_id" inversejoincolumn="filter_id" orderby="filterId">
</cfcomponent>