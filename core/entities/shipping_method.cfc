<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="shippingMethodId" column="shipping_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="function" column="function" ormtype="string"> 
</cfcomponent>
