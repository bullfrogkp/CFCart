<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="pageId" column="page_id" fieldtype="id" generator="native"> 
    <cfproperty name="content" column="content" ormtype="text"> 
</cfcomponent>