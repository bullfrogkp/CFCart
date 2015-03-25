<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="stock" column="stock" ormtype="integer"> 
	<cfproperty name="specialPrice" column="special_price" ormtype="float"> 
	<cfproperty name="specialPriceFromDate" column="special_price_from_date" ormtype="date"> 
	<cfproperty name="specialPriceToDate" column="special_price_to_date" ormtype="date"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	
	<cfproperty name="length" column="length" ormtype="float"> 
	<cfproperty name="width" column="width" ormtype="float"> 
	<cfproperty name="height" column="height" ormtype="float"> 
	<cfproperty name="weight" column="weight" ormtype="float"> 
	
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set" fkcolumn="attribute_set_id">
	<cfproperty name="parentProduct" fieldtype="many-to-one" cfc="product" fkcolumn="parent_product_id">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category" fkcolumn="tax_category_id">
	
	<cfproperty name="attributeValues" type="array" fieldtype="one-to-many" cfc="attribute_value" fkcolumn="product_id" singularname="attributeValue" cascade="delete-orphan">
	<cfproperty name="subProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="product_id" singularname="subProduct" cascade="delete-orphan">
	<cfproperty name="relatedProducts" type="array" fieldtype="one-to-many" cfc="related_product" fkcolumn="product_id" singularname="relatedProduct" cascade="delete-orphan">
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="product_id" singularname="review" cascade="delete-orphan">
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="product_id" singularname="image" cascade="delete-orphan">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="product_id" singularname="productCustomerGroupRela" cascade="delete-orphan">
	
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" singularname="category">
	<cfproperty name="shippingMethods" fieldtype="many-to-many" cfc="shipping_method" linktable="product_shipping_method_rela" fkcolumn="product_id" inversejoincolumn="shipping_method_id" singularname="shippingMethod">
	
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	
	<cffunction name="removeAllCategories" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategories())>
			<cfset ArrayClear(getCategories()) />
		</cfif>
	</cffunction>
	
	<cffunction name="removeAttributeValues" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getAttributeValues())>
			<cfset ArrayClear(getAttributeValues()) />
		</cfif>
	</cffunction>
	
	<cffunction name="removeShippingMethods" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getShippingMethods())>
			<cfset ArrayClear(getShippingMethods()) />
		</cfif>
	</cffunction>
</cfcomponent>
