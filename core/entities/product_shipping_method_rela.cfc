<cfcomponent persistent="true"> 
    <cfproperty name="productShippingMethodRelaId" column="product_shipping_method_rela_id" fieldtype="id" generator="native">
	<cfproperty name="defaultPrice" column="default_price" ormtype="float"> 
	<cfproperty name="calculatedPrice" column="calculated_price" ormtype="float"> 
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="shippingMethod" fieldtype="many-to-one" cfc="shipping_method" fkcolumn="shipping_method_id">
</cfcomponent>
