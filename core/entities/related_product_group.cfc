<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="relatedProductGroupId" column="related_product_group_id" fieldtype="id" generator="native"> 
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="relatedProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="related_product_id" singularname="relatedProduct">
</cfcomponent>