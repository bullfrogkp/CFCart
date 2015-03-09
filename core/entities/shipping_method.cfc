<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="shippingMethodId" column="shipping_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="component" column="component" ormtype="string"> 
</cfcomponent>
