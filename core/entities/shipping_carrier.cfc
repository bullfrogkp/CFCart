<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="shippingCarrierId" column="shipping_carrier_id" fieldtype="id" generator="native"> 
	<cfproperty name="imageName" column="image_name" ormtype="string"> 
	<cfproperty name="component" column="component" ormtype="string"> 
</cfcomponent>
