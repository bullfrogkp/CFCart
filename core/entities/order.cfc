<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderId" column="order_id" fieldtype="id" generator="native">
	<cfproperty name="trackingNumber" column="tracking_number" ormtype="string">
	<cfproperty name="phone" column="phone" ormtype="string"> 
	<cfproperty name="total" column="total" ormtype="string"> 
	
	<cfproperty name="shippingFirstName" column="shipping_first_name" ormtype="string"> 
	<cfproperty name="shippingMiddleName" column="shipping_middle_name" ormtype="string"> 
	<cfproperty name="shippingLastName" column="shipping_last_name" ormtype="string">
    <cfproperty name="shippingStreet" column="shipping_street" ormtype="string"> 
    <cfproperty name="shippingCity" column="shipping_city" ormtype="string"> 
    <cfproperty name="shippingPostalCode" column="shipping_postal_code" ormtype="string"> 
	<cfproperty name="shippingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="shipping_country_id">
	<cfproperty name="shippingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="shipping_province_id">	
	
	<cfproperty name="billingFirstName" column="billing_first_name" ormtype="string"> 
	<cfproperty name="billingMiddleName" column="billing_middle_name" ormtype="string"> 
	<cfproperty name="billingLastName" column="billing_last_name" ormtype="string">
    <cfproperty name="billingStreet" column="billing_street" ormtype="string"> 
    <cfproperty name="billingCity" column="billing_city" ormtype="string"> 
    <cfproperty name="billingPostalCode" column="billing_postal_code" ormtype="string"> 
	<cfproperty name="billingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="billing_country_id">
	<cfproperty name="billingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="billing_province_id">	
	 
	<cfproperty name="coupon" fieldtype="many-to-one" cfc="coupon" fkcolumn="coupon_id">	
	<cfproperty name="paymentMethod" fieldtype="many-to-one" cfc="payment_method" fkcolumn="payment_method_id">	
	<cfproperty name="status" fieldtype="many-to-one" cfc="order_status" fkcolumn="order_status_id">	
	
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="order_product" fkcolumn="order_product_id" singularname="product">
</cfcomponent>
