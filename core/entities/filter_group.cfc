<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="filterGroupId" column="filter_group_id" fieldtype="id" generator="native">
	<cfproperty name="filters" fieldtype="many-to-many" cfc="filter" linktable="filter_group_filter_rela" fkcolumn="filter_group_id" inversejoincolumn="filter_id" singularname="filter">
	
	<cffunction name="removeFilters" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getFilters())>
			<cfset ArrayClear(getFilters()) />
		</cfif>
	</cffunction>
</cfcomponent>