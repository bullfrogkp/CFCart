<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productImageId" column="product_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="isDefault" column="is_default" ormtype="boolean"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	
	<cffunction name="getImageLink" access="public" output="false" returnType="string">
		<cfreturn "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProduct().getProductId()#/#getName()#" />
	</cffunction>
</cfcomponent>