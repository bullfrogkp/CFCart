<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="couponId" column="coupon_id" fieldtype="id" generator="native"> 
    <cfproperty name="coupon" column="code" ormtype="string"> 
    <cfproperty name="startDate" column="start_date" ormtype="date"> 
    <cfproperty name="endDate" column="end_date" ormtype="date"> 
	
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
	<cfproperty name="discountType" fieldtype="many-to-one" cfc="discount_type" fkcolumn="discount_type_id">
	<cfproperty name="status" fieldtype="many-to-one" cfc="coupon_status" fkcolumn="coupon_status_id">
</cfcomponent>