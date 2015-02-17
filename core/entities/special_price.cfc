<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="specialPriceId" column="special_price_id" fieldtype="id" generator="native"> 
    <cfproperty name="productId" column="product_id" ormtype="integer"> 
    <cfproperty name="customer_group_id" column="customer_group_id" ormtype="integer"> 
    <cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="products" fieldtype="many-to-one" cfc="product">
	<cfproperty name="customerGroups" fieldtype="many-to-one" cfc="customer_group">
</cfcomponent>