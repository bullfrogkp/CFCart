<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="advertisementId" column="advertisement_id" fieldtype="id" generator="native"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="page" fieldtype="many-to-one" cfc="page" fkcolumn="page_id">
</cfcomponent>