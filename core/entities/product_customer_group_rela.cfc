<cfcomponent persistent="true"> 
    <cfproperty name="productCustomerGroupRelaId" column="product_customer_group_rela_id" fieldtype="id" generator="native">
	<cfproperty name="price" column="price" ormtype="float"> 
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="customerGroup" fieldtype="many-to-one" cfc="customer_group" fkcolumn="customer_group_id">
</cfcomponent>
