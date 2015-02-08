<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="categoryImageId" column="category_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="imageName" column="image_name" ormtype="string"> 
    <cfproperty name="rank" column="rank" ormtype="float" default="1"> 
    <cfproperty name="imageIsEnabled" column="category_is_enabled" ormtype="boolean" default="true"> 
    <cfproperty name="imageIsDeleted" column="category_is_deleted" ormtype="boolean" default="false"> 
	<cfproperty name="imageDescription" column="category_description" ormtype="string" default=""> 
	<cfproperty name="category" fieldtype="many-to-one" cfc="category">
</cfcomponent>