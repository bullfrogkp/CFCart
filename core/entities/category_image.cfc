<cfcomponent persistent="true"> 
    <cfproperty name="categoryImageId" column="category_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="imagePathName" column="image_path_name" ormtype="string"> 
    <cfproperty name="categoryId" column="category_id" ormtype="integer"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
    <cfproperty name="categoryImageIsEnabled" column="category_is_enabled" ormtype="boolean"> 
    <cfproperty name="categoryImageIsDeleted" column="category_is_deleted" ormtype="boolean"> 
	<cfproperty name="categoryImageDescription" column="category_description" ormtype="string"> 
    <cfproperty name="createdDatetime" column="created_datetime" ormtype="date"> 
    <cfproperty name="createdUser" column="create_user" ormtype="string"> 
    <cfproperty name="updatedDatetime" column="updated_datetime" ormtype="date"> 
    <cfproperty name="updatedUser" column="update_user" ormtype="string"> 
</cfcomponent>