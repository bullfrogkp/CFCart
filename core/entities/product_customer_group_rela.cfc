<cfcomponent persistent="true"> 
    <cfproperty name="productCustomerGroupRelaId" column="product_customer_group_rela_id" fieldtype="id" generator="native">
	<cfproperty name="productId" column="product_id" ormtype="integer"> 
	<cfproperty name="customerGroupId" column="customer_group_id" ormtype="integer"> 
	<cfproperty name="price" column="price" ormtype="float"> 
</cfcomponent>
