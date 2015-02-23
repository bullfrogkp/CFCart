<cfcomponent persistent="true"> 
    <cfproperty name="relatedProductId" column="related_product_id" fieldtype="id" generator="native"> 
	<cfproperty name="otherProductId" column="other_product_id" ormtype="integer"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product">
</cfcomponent>
