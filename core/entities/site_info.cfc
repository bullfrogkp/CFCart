<cfcomponent persistent="true"> 
    <cfproperty name="siteInfoId" column="site_info_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
	<cfproperty name="unit" column="unit" ormtype="string"> 
	<cfproperty name="street" column="street" ormtype="string"> 
	<cfproperty name="city" column="city" ormtype="string"> 
	<cfproperty name="province" column="province" ormtype="string"> 
	<cfproperty name="country" column="country" ormtype="string"> 
	<cfproperty name="postalCode" column="postal_code" ormtype="string"> 
	<cfproperty name="phone" column="phone" ormtype="string"> 
	<cfproperty name="email" column="email" ormtype="string"> 
</cfcomponent>
