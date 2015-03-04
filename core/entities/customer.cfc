<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="customerId" column="customer_id" fieldtype="id" generator="native"> 
    <cfproperty name="lastLoginDatetime" column="last_login_datetime" ormtype="date"> 
    <cfproperty name="lastLoginIP" column="last_login_ip" ormtype="string"> 
	
	<cfproperty name="prefix" column="last_login_ip" ormtype="string"> 
	<cfproperty name="firstName" column="last_login_ip" ormtype="string"> 
	<cfproperty name="middleName" column="last_login_ip" ormtype="string"> 
	<cfproperty name="lastName" column="last_login_ip" ormtype="string"> 
	<cfproperty name="suffix " column="last_login_ip" ormtype="string"> 
	<cfproperty name="DateofBirth " column="last_login_ip" ormtype="string"> 
	<cfproperty name="gender" column="last_login_ip" ormtype="string"> 
	<cfproperty name="email" column="last_login_ip" ormtype="string"> 
	<cfproperty name="website" column="last_login_ip" ormtype="string"> 
	<cfproperty name="subscribed" column="last_login_ip" ormtype="string"> 
	<cfproperty name="status" column="last_login_ip" ormtype="string"> 
	<cfproperty name="comments" column="last_login_ip" ormtype="string"> 
	
	
	<cfproperty name="customerGroup" column="last_login_ip" ormtype="string"> 
	 
 
	
	
    <cfproperty name="rank" column="rank" ormtype="float"> 
	
	<cfproperty name="shoppingCartProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="customer_id" singularname="shoppingCartProduct">
	<cfproperty name="buyLaterProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="customer_id" singularname="buyLaterProduct">
	<cfproperty name="wishListProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="customer_id" singularname="wishListProduct">
	<cfproperty name="orders" type="array" fieldtype="one-to-many" cfc="order" fkcolumn="customer_id" singularname="order">
	<cfproperty name="addresses" type="array" fieldtype="one-to-many" cfc="address" fkcolumn="customer_id" singularname="address">
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="customer_id" singularname="review">
	
	
	<cfproperty name="products" fieldtype="many-to-many" cfc="product" linktable="category_product_rela" fkcolumn="category_id" inversejoincolumn="product_id">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	<cfproperty name="subCategories" type="array" persistent="false"> 
</cfcomponent>