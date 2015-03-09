<cfcomponent persistent="true"> 
    <cfproperty name="paymentMethodId" column="payment_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="component" column="component" ormtype="string"> 
</cfcomponent>
