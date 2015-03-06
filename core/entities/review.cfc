<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="reviewId" column="review_id" fieldtype="id" generator="native"> 
    <cfproperty name="subject" column="subject" ormtype="string"> 
    <cfproperty name="rating" column="rating" ormtype="integer"> 
    <cfproperty name="message" column="message" ormtype="string"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
</cfcomponent>