<cfcomponent persistent="true"> 
    <cfproperty name="pageId" column="page_id" fieldtype="id" generator="native"> 
    <cfproperty name="homepage1" column="homepage1" ormtype="text"> 
    <cfproperty name="homepage2" column="homepage2" ormtype="text"> 
    <cfproperty name="homepage3" column="homepage3" ormtype="text"> 
</cfcomponent>