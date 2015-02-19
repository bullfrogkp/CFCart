<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="customerGroupId" column="customer_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="customerGroupId">
</cfcomponent>