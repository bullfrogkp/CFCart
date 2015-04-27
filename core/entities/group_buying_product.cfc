<cfcomponent persistent="true"> 
    <cfproperty name="groupBuyingProductId" column="group_buying_product_id" fieldtype="id" generator="native"> 	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>