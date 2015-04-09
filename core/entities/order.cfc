<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderId" column="order_id" fieldtype="id" generator="native">
	<cfproperty name="prefix" column="prefix" ormtype="string"> 
	<cfproperty name="suffix" column="suffix" ormtype="string"> 
	<cfproperty name="firstName" column="shipping_first_name" ormtype="string"> 
	<cfproperty name="middleName" column="shipping_middle_name" ormtype="string"> 
	<cfproperty name="lastName" column="shipping_last_name" ormtype="string">
	<cfproperty name="comments" column="comments" ormtype="string">
	<cfproperty name="orderTrackingNumber" column="order_tracking_number" ormtype="string">
	<cfproperty name="shippingTrackingNumber" column="shipping_tracking_number" ormtype="string">
	<cfproperty name="phone" column="phone" ormtype="string"> 
	<cfproperty name="email" column="email" ormtype="string"> 
	
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">	
	
    <cfproperty name="shippingCompany" column="shipping_company" ormtype="string"> 
    <cfproperty name="shippingUnit" column="shipping_unit" ormtype="string"> 
    <cfproperty name="shippingStreet" column="shipping_street" ormtype="string"> 
    <cfproperty name="shippingCity" column="shipping_city" ormtype="string"> 
    <cfproperty name="shippingPostalCode" column="shipping_postal_code" ormtype="string"> 
	<cfproperty name="shippingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="shipping_country_id">
	<cfproperty name="shippingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="shipping_province_id">	
	
    <cfproperty name="billingCompany" column="billing_company" ormtype="string"> 
    <cfproperty name="billingUnit" column="billing_unit" ormtype="string"> 
    <cfproperty name="billingStreet" column="billing_street" ormtype="string"> 
    <cfproperty name="billingCity" column="billing_city" ormtype="string"> 
    <cfproperty name="billingPostalCode" column="billing_postal_code" ormtype="string"> 
	<cfproperty name="billingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="billing_country_id">
	<cfproperty name="billingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="billing_province_id">	
	 
	<cfproperty name="coupon" fieldtype="one-to-one" cfc="coupon">	
	<cfproperty name="paymentMethod" fieldtype="many-to-one" cfc="payment_method" fkcolumn="payment_method_id">	
	
	<cfproperty name="orderStatus" type="array" fieldtype="one-to-many" cfc="order_status" fkcolumn="order_id" singularname="orderStatus">
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="order_product" fkcolumn="order_id" singularname="product">

	<cffunction name="getCustomerFullName" access="public" output="false" returnType="string">
		
		<cfset var firstName = isNull(getFirstName())?"":getFirstName() />
		<cfset var middleName = isNull(getMiddleName())?"":getMiddleName() />
		<cfset var lastName = isNull(getLastName())?"":getLastName() />
		
		<cfif middleName EQ "">
			<cfset var fullName = firstName & " " & lastName />
		<cfelse>
			<cfset var fullName = firstName & " " & middleName & " " & lastName />
		</cfif>
		
		<cfreturn fullName />
	</cffunction>
</cfcomponent>
