<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderProductId" column="order_product_id" fieldtype="id" generator="native">
	<cfproperty name="regularPrice" column="regular_price" ormtype="float"> 
	<cfproperty name="orderPrice" column="order_price" ormtype="float"> 
	<cfproperty name="quantity" column="quantity" ormtype="integer"> 
	<cfproperty name="subtotalAmount" column="subtotal_amount" ormtype="float"> 
	<cfproperty name="taxAmount" column="tax_amount" ormtype="float"> 
	<cfproperty name="shippingAmount" column="shipping_amount" ormtype="float"> 
	<cfproperty name="totalAmount" column="total_amount" ormtype="float"> 
	<cfproperty name="comments" column="comments" ormtype="string">
	<cfproperty name="sku" column="sku" ormtype="string">
	
	<cfproperty name="status" type="array" fieldtype="one-to-many" cfc="order_product_status" fkcolumn="order_product_id" singularname="status">
	
	<cfproperty name="shippingMethod" fieldtype="many-to-one" cfc="shipping_method" fkcolumn="shipping_method_id">	
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category" fkcolumn="tax_category_id">	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">	
</cfcomponent>
