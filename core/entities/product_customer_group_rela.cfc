<cfcomponent persistent="true"> 
    <cfproperty name="productCustomerGroupRelaId" column="product_customer_group_rela_id" fieldtype="id" generator="native">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product">
	<cfproperty name="customerGroup" fieldtype="many-to-one" cfc="customer_group">
	<cfproperty name="price" column="price" ormtype="float"> 
</cfcomponent>
