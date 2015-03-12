<cfcomponent persistent="true"> 
    <cfproperty name="filterId" column="filter_id" fieldtype="id" generator="native"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="filterGroups" fieldtype="many-to-many" cfc="filter_group" linktable="filter_group_filter_rela" fkcolumn="filter_id" inversejoincolumn="filter_group_id" singularname="filterGroup">
</cfcomponent>