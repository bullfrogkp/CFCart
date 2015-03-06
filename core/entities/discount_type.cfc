<cfcomponent persistent="true"> 
    <cfproperty name="discountTypeId" column="discount_type_id" fieldtype="id" generator="native"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
    <cfproperty name="amount" column="amount" ormtype="integer"> 
	<cfproperty name="calculationType" fieldtype="many-to-one" cfc="calculation_type" fkcolumn="calculation_type_id">
</cfcomponent>