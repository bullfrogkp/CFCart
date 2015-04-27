<cfcomponent persistent="true"> 
    <cfproperty name="topSellingProductId" column="top_selling_product_id" fieldtype="id" generator="native"> 	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>