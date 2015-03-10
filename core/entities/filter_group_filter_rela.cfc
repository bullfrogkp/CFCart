<cfcomponent persistent="true"> 
    <cfproperty name="filterGroupFilterRelaId" column="filter_group_filter_rela_id" fieldtype="id" generator="native"> 
	<cfproperty name="filterValues" type="array" fieldtype="one-to-many" cfc="filter_value" fkcolumn="filter_group_filter_rela_id" singularname="filterValue">
	
	<cfproperty name="filterGroup" fieldtype="many-to-one" cfc="filter_group" fkcolumn="filter_group_id">
	<cfproperty name="filter" fieldtype="many-to-one" cfc="filter" fkcolumn="filter_id">
</cfcomponent>