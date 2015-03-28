<cfcomponent persistent="true"> 
    <cfproperty name="filterValueId" column="filter_value_id" fieldtype="id" generator="native"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
    <cfproperty name="value" column="value" ormtype="string"> 
	<cfproperty name="categoryFilterRela" fieldtype="many-to-one" cfc="category_filter_rela" fkcolumn="category_filter_rela_id">
</cfcomponent>