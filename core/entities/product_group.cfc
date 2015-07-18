<cfcomponent persistent="true"> 
    <cfproperty name="productGroupId" column="product_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="isDeleted" column="is_deleted" ormtype="boolean"> 
	<cfproperty name="products" fieldtype="many-to-many" cfc="product" linktable="product_group_product_rela" fkcolumn="product_group_id" inversejoincolumn="product_id">
</cfcomponent>