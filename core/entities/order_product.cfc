<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderProductId" column="order_product_id" fieldtype="id" generator="native">
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="originalPrice" column="original_price" ormtype="float"> 
	<cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="quantity" column="quantity" ormtype="integer"> 
	<cfproperty name="subtotal" column="subtotal" ormtype="float"> 
	<cfproperty name="taxAmount" column="tax_amount" ormtype="float"> 
	<cfproperty name="shippingAmount" column="shipping_amount" ormtype="float"> 
</cfcomponent>
