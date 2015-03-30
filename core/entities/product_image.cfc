<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productImageId" column="product_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="isDefault" column="is_default" ormtype="boolean"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
</cfcomponent>