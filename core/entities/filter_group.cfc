<cfcomponent persistent="true"> 
    <cfproperty name="filterGroupId" column="filter_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="categoryFilterRelas" type="array" fieldtype="one-to-many" cfc="category_filter_rela" fkcolumn="filter_group_id" singularname="categoryFilterRela">
</cfcomponent>