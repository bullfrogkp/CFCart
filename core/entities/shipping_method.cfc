<cfcomponent persistent="true"> 
    <cfproperty name="shippingMethodId" column="shipping_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="function" column="function" ormtype="string"> 
	<cfproperty name="products" fieldtype="many-to-many" cfc="product" linktable="product_shipping_method_rela" fkcolumn="shipping_method_id" inversejoincolumn="product_id" singularname="product">
</cfcomponent>
