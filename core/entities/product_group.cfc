<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productGroupId" column="product_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="product_group_id">
</cfcomponent>
