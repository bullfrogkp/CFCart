<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="filterId" column="filter_id" fieldtype="id" generator="native"> 
    <cfproperty name="value" column="value" ormtype="string"> 
	<cfproperty name="filterGroups" fieldtype="many-to-many" cfc="filter_group" linktable="filter_group_filter_rela" fkcolumn="filter_id" inversejoincolumn="filter_group_id" orderby="filterGroupId">
</cfcomponent>