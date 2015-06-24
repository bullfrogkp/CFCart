<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="contentId" column="content_id" fieldtype="id" generator="native"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="content" column="content" ormtype="text"> 
</cfcomponent>
