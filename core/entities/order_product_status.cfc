<cfcomponent persistent="true"> 
    <cfproperty name="orderProductStatusId" column="order_product_status_id" fieldtype="id" generator="native"> 
    <cfproperty name="startDatetime" column="start_datetime" ormtype="string"> 
    <cfproperty name="endDatetime" column="end_datetime" ormtype="string"> 
    <cfproperty name="current" column="current" ormtype="boolean"> 
	<cfproperty name="statusType" fieldtype="many-to-one" cfc="order_product_status_type" fkcolumn="order_product_status_type_id">
</cfcomponent>