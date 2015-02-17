<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="customerGroupId" column="customer_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="specialPrices" type="array" fieldtype="one-to-many" cfc="special_price" fkcolumn="customerGroupId">
</cfcomponent>