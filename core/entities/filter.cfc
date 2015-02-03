<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="filterId" column="filter_id" fieldtype="id" generator="native"> 
    <cfproperty name="filterName" column="filter_name" ormtype="string"> 
    <cfproperty name="filterDisplayName" column="filter_display_name" ormtype="string"> 
    <cfproperty name="filterValue" column="filter_value" ormtype="string"> 
    <cfproperty name="filterMinValue" column="filter_min_value" ormtype="string"> 
    <cfproperty name="filterMaxValue" column="filter_max_value" ormtype="string"> 
    <cfproperty name="filterIsEnabled" column="category_is_enabled" ormtype="boolean"> 
    <cfproperty name="filterIsDeleted" column="category_is_deleted" ormtype="boolean">
	<cfproperty name="filterGroups" fieldtype="many-to-many" cfc="filter_group" linktable="filter_group_filter_rela" fkcolumn="filter_id" inversejoincolumn="filter_group_id" orderby="filterGroupId">
</cfcomponent>