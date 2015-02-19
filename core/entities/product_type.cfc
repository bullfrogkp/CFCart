<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productTypeId" column="product_type_id" fieldtype="id" generator="native"> 
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="productTypeId">
</cfcomponent>
