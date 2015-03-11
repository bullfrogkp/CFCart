<cfcomponent persistent="true"> 
    <cfproperty name="filterId" column="filter_id" fieldtype="id" generator="native"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="categoryFilterRelas" type="array" fieldtype="one-to-many" cfc="category_filter_rela" fkcolumn="filter_id" singularname="categoryFilterRela">
</cfcomponent>