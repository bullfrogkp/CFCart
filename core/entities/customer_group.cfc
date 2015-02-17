<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="customerGroupId" column="customer_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="specialPrices" fieldtype="many-to-many" cfc="special_price" linktable="special_price_customer_group_rela" fkcolumn="customer_group_id" inversejoincolumn="special_price_id" orderby="customerGroupId">
</cfcomponent>