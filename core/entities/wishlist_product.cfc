<cfcomponent persistent="true"> 
    <cfproperty name="wishlistProductId" column="wishlist_product_id" fieldtype="id" generator="native"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>
