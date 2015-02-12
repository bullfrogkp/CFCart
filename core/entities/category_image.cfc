<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="categoryImageId" column="category_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="category" fieldtype="many-to-one" cfc="category">
</cfcomponent>