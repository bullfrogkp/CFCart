<cfcomponent persistent="true"> 
    <cfproperty name="orderProductStatusId" column="order_product_status_id" fieldtype="id" generator="native"> 
    <cfproperty name="startDatetime" column="start_datetime" ormtype="string"> 
    <cfproperty name="endDatetime" column="end_datetime" ormtype="string"> 
    <cfproperty name="current" column="current" ormtype="boolean"> 
    <cfproperty name="comments" column="comments" ormtype="string"> 
	<cfproperty name="orderProduct" fieldtype="many-to-one" cfc="order_product" fkcolumn="order_product_id">
	<cfproperty name="orderProductStatusType" fieldtype="many-to-one" cfc="order_product_status_type" fkcolumn="order_product_status_type_id">
	<!------------------------------------------------------------------------------->	
	<cffunction name="setCurrentMV" access="public">
		<cfargument name="flag" type="boolean" required="true" />
		<cfset var LOCAL = {} />
		
		<cfif ARGUMENTS.flag EQ true>
			<cfset LOCAL.orderProductStatus = EntityLoad("order_product_status",{orderProduct = getOrderProduct()}) />
			<cfloop array="#LOCAL.orderProductStatus#" index="LOCAL.os">
				<cfif LOCAL.os.getCurrent() EQ true>
					<cfset LOCAL.os.setEndDatetime(Now()) />
				</cfif>
				<cfset LOCAL.os.setCurrent(false) />
			</cfloop>
		</cfif>
		
		<cfset setCurrent(ARGUMENTS.flag) />
	</cffunction>
</cfcomponent>