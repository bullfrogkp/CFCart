<cfcomponent persistent="true"> 
    <cfproperty name="relatedProductId" column="related_product_id" fieldtype="id" generator="native"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product">
	<cfproperty name="relatedProductId" column="related_product_id" ormtype="integer"> 
</cfcomponent>
