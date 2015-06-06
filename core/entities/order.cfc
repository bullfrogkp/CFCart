<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderId" column="order_id" fieldtype="id" generator="native">
	<cfproperty name="prefix" column="prefix" ormtype="string"> 
	<cfproperty name="suffix" column="suffix" ormtype="string"> 
	<cfproperty name="comments" column="comments" ormtype="string">
	<cfproperty name="orderTrackingNumber" column="order_tracking_number" ormtype="string">
	<cfproperty name="shippingTrackingNumber" column="shipping_tracking_number" ormtype="string">
	<cfproperty name="phone" column="phone" ormtype="string"> 
	<cfproperty name="email" column="email" ormtype="string"> 
	
	<cfproperty name="token" column="token" ormtype="string"> 
	<cfproperty name="payerId" column="payerId" ormtype="string"> 
	
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">	
	
	
	<cfproperty name="shippingFirstName" column="shipping_first_name" ormtype="string"> 
	<cfproperty name="shippingMiddleName" column="shipping_middle_name" ormtype="string"> 
	<cfproperty name="shippingLastName" column="shipping_last_name" ormtype="string">
    <cfproperty name="shippingCompany" column="shipping_company" ormtype="string"> 
    <cfproperty name="shippingUnit" column="shipping_unit" ormtype="string"> 
    <cfproperty name="shippingStreet" column="shipping_street" ormtype="string"> 
    <cfproperty name="shippingCity" column="shipping_city" ormtype="string"> 
    <cfproperty name="shippingPostalCode" column="shipping_postal_code" ormtype="string"> 
	<cfproperty name="shippingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="shipping_country_id">
	<cfproperty name="shippingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="shipping_province_id">	
	
	
	<cfproperty name="billingFirstName" column="billing_first_name" ormtype="string"> 
	<cfproperty name="billingMiddleName" column="billing_middle_name" ormtype="string"> 
	<cfproperty name="billingLastName" column="billing_last_name" ormtype="string">
    <cfproperty name="billingCompany" column="billing_company" ormtype="string"> 
    <cfproperty name="billingUnit" column="billing_unit" ormtype="string"> 
    <cfproperty name="billingStreet" column="billing_street" ormtype="string"> 
    <cfproperty name="billingCity" column="billing_city" ormtype="string"> 
    <cfproperty name="billingPostalCode" column="billing_postal_code" ormtype="string"> 
	<cfproperty name="billingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="billing_country_id">
	<cfproperty name="billingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="billing_province_id">	
	 
	<cfproperty name="coupons" type="array" fieldtype="one-to-many" cfc="coupon" fkcolumn="order_id" singularname="coupon">
	<cfproperty name="paymentMethod" fieldtype="many-to-one" cfc="payment_method" fkcolumn="payment_method_id">	
	
	<cfproperty name="orderStatus" type="array" fieldtype="one-to-many" cfc="order_status" fkcolumn="order_id" singularname="orderStatus">
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="order_product" fkcolumn="order_id" singularname="product">

	<cffunction name="getCustomerFullName" access="public" output="false" returnType="string">
		
		<cfset var firstName = isNull(getCustomer().getFirstName())?"":getCustomer().getFirstName() />
		<cfset var middleName = isNull(getCustomer().getMiddleName())?"":getCustomer().getMiddleName() />
		<cfset var lastName = isNull(getCustomer().getLastName())?"":getCustomer().getLastName() />
		
		<cfif middleName EQ "">
			<cfset var fullName = firstName & " " & lastName />
		<cfelse>
			<cfset var fullName = firstName & " " & middleName & " " & lastName />
		</cfif>
		
		<cfreturn fullName />
	</cffunction>
	
	<cffunction name="getTotalPrice" access="public" output="false" returnType="numeric">
		<cfset var LOCAL = {} />
		<cfset LOCAL.totalPrice = 0 />
		<cfloop array="#getOrderProducts()#" index="LOCAL.orderProduct">
			<cfset LOCAL.totalPrice += LOCAL.orderProduct.getTotalAmount() />
		</cfloop>
		<cfreturn LOCAL.totalPrice />
	</cffunction>
	
	<cffunction name="getCurrentOrderStatus" access="public" output="false" returnType="any">
		<cfreturn EntityLoad("order_status",{isCurrent=true},true) />
	</cffunction>
</cfcomponent>
