<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="couponId" column="coupon_id" fieldtype="id" generator="native"> 
    <cfproperty name="code" column="code" ormtype="string"> 
    <cfproperty name="startDate" column="start_date" ormtype="date"> 
    <cfproperty name="endDate" column="end_date" ormtype="date"> 
	
	<cfproperty name="discountType" fieldtype="many-to-one" cfc="discount_type" fkcolumn="discount_type_id">
</cfcomponent>