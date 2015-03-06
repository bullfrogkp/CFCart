<cfcomponent persistent="true"> 
    <cfproperty name="couponStatusId" column="coupon_id" fieldtype="id" generator="native"> 
    <cfproperty name="displayName" column="code" ormtype="string"> 
</cfcomponent>