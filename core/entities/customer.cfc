<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="customerId" column="customer_id" fieldtype="id" generator="native"> 
	<cfproperty name="email" column="email" ormtype="string"> 
	<cfproperty name="phone" column="phone" ormtype="string"> 
    <cfproperty name="password" column="password" ormtype="string"> 
    <cfproperty name="lastLoginDatetime" column="last_login_datetime" ormtype="date"> 
    <cfproperty name="lastLoginIP" column="last_login_ip" ormtype="string"> 
	<cfproperty name="prefix" column="prefix" ormtype="string"> 
	<cfproperty name="firstName" column="first_name" ormtype="string"> 
	<cfproperty name="middleName" column="middle_name" ormtype="string"> 
	<cfproperty name="lastName" column="last_name" ormtype="string"> 
	<cfproperty name="suffix" column="suffix" ormtype="string"> 
	<cfproperty name="dateOfBirth" column="date_of_birth" ormtype="string"> 
	<cfproperty name="gender" column="gender" ormtype="string"> 
	<cfproperty name="website" column="website" ormtype="string"> 
	<cfproperty name="subscribed" column="subscribed" ormtype="boolean">
	
	<cfproperty name="customerGroup" fieldtype="many-to-one" cfc="customer_group" fkcolumn="customer_group_id">
	
	<cfproperty name="addresses" type="array" fieldtype="one-to-many" cfc="address" fkcolumn="customer_id" singularname="address">
	<cfproperty name="orders" type="array" fieldtype="one-to-many" cfc="order" fkcolumn="order_id" singularname="order">
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="review_id" singularname="review">
	
	<cfproperty name="shoppingCartProducts" type="array" fieldtype="one-to-many" cfc="shopping_cart_product" fkcolumn="shopping_cart_product_id" singularname="shoppingCartProduct">
	<cfproperty name="buyLaterProducts" type="array" fieldtype="one-to-many" cfc="buy_later_product" fkcolumn="buy_later_product_id" singularname="buyLaterProduct">
	<cfproperty name="wishListProducts" type="array" fieldtype="one-to-many" cfc="wishlist_product" fkcolumn="wishlist_product_id" singularname="wishListProduct">
	
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
</cfcomponent>