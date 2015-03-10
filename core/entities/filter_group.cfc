<cfcomponent persistent="true"> 
    <cfproperty name="filterGroupId" column="filter_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="filterGroupFilterRelas" type="array" fieldtype="one-to-many" cfc="filter_group_filter_rela" fkcolumn="filter_group_id" singularname="filterGroupFilterRela">
</cfcomponent>