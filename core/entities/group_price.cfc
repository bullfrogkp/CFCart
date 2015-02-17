<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="groupPriceId" column="special_price_id" fieldtype="id" generator="native"> 
    <cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="products" fieldtype="many-to-one" cfc="product">
	<cfproperty name="customerGroups" fieldtype="many-to-many" cfc="customer_group" linktable="group_price_customer_group_rela" fkcolumn="group_price_id" inversejoincolumn="customer_group_id" orderby="customerGroupId">
</cfcomponent>