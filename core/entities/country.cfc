<cfcomponent persistent="true"> 
    <cfproperty name="countryId" column="country_id" fieldtype="id" generator="native"> 
    <cfproperty name="code" column="code" ormtype="string"> 
    <cfproperty name="name" column="name" ormtype="string"> 
</cfcomponent>