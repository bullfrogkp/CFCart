<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productGroupId" column="product_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="products" fieldtype="many-to-many" cfc="product" linktable="product_group_product_rela" fkcolumn="product_group_id" inversejoincolumn="product_id">
</cfcomponent>