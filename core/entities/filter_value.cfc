<cfcomponent persistent="true"> 
    <cfproperty name="filterValueId" column="filter_value_id" fieldtype="id" generator="native"> 
    <cfproperty name="value" column="value" ormtype="string"> 
</cfcomponent>