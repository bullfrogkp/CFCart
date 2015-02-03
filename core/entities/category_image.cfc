<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="categoryImageId" column="category_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="imagePathName" column="image_path_name" ormtype="string"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
    <cfproperty name="imageIsEnabled" column="category_is_enabled" ormtype="boolean"> 
    <cfproperty name="imageIsDeleted" column="category_is_deleted" ormtype="boolean"> 
	<cfproperty name="imageDescription" column="category_description" ormtype="string"> 
	<cfproperty name="category" fieldtype="many-to-one" cfc="category">
</cfcomponent>