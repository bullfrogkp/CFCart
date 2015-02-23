<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="shippingMethodId" column="shipping_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="cfc" column="cfc" ormtype="string"> 
</cfcomponent>
