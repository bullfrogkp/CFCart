<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="filterId" column="filter_id" fieldtype="id" generator="native"> 
	<cfproperty name="attribute" fieldtype="many-to-one" cfc="attribute" fkcolumn="attribute_id">
	<cfproperty name="filterGroups" fieldtype="many-to-many" cfc="filter_group" linktable="filter_group_filter_rela" fkcolumn="filter_id" inversejoincolumn="filter_group_id" singularname="filterGroup">
</cfcomponent>