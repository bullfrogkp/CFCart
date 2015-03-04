<cfcomponent persistent="true"> 
    <cfproperty name="orderStatusId" column="order_status_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string"> 
</cfcomponent>