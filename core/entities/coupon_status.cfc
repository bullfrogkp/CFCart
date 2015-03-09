<cfcomponent persistent="true"> 
    <cfproperty name="couponStatusId" column="coupon_id" fieldtype="id" generator="native"> 
    <cfproperty name="statusType" fieldtype="many-to-one" cfc="coupon_status_type" fkcolumn="coupon_status_type_id">
</cfcomponent>