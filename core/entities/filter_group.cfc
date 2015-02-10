<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="filterGroupId" column="filter_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="filters" fieldtype="many-to-many" cfc="filter" linktable="filter_group_filter_rela" fkcolumn="filter_group_id" inversejoincolumn="filter_id" orderby="filterId">
</cfcomponent>