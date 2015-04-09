<cfcomponent persistent="true"> 
    <cfproperty name="taxId" column="tax_id" fieldtype="id" generator="native"> 
	<cfproperty name="rate" column="rate" ormtype="float"> 
	<cfproperty name="province" fieldtype="many-to-one" cfc="province" fkcolumn="province_id">
</cfcomponent>