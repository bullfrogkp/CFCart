<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="addressId" column="address_id" fieldtype="id" generator="native"> 
    <cfproperty name="firstName" column="first_name" ormtype="string"> 
    <cfproperty name="middleName" column="middle_name" ormtype="integer"> 
    <cfproperty name="lastName" column="last_name" ormtype="integer"> 
    <cfproperty name="phone" column="phone" ormtype="string"> 
    <cfproperty name="street" column="street" ormtype="string"> 
    <cfproperty name="city" column="city" ormtype="string"> 
    <cfproperty name="postalCode" column="postal_code" ormtype="string"> 
	
	<cfproperty name="country" fieldtype="many-to-one" cfc="country" fkcolumn="country_id">
	<cfproperty name="province" fieldtype="many-to-one" cfc="province" fkcolumn="province_id">
	<cfproperty name="type" fieldtype="many-to-one" cfc="address_type" fkcolumn="address_type_id">
</cfcomponent>