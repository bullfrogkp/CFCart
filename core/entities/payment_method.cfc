<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="paymentMethodId" column="payment_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="cfc" column="cfc" ormtype="string"> 
</cfcomponent>
