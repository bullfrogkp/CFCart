<cfcomponent extends="service" output="false" accessors="true">
	<cffunction name="addProduct" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="productId" type="numeric" required="true">
		<cfargument name="count" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		<cfset var retStruct = {} />
		<cfset retStruct.success = true />
		
		<cfset LOCAL.product = EntityLoadByPK("product",ARGUMENTS.productId) />
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_entity_type",{name = "shipping cart"},true) />
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{name = "shipping cart"},true) />
		<cfset LOCAL.trackingRecord = EntityNew("tracking_record") />
		<cfset LOCAL.trackingRecord.setTrackingRecordType(LOCAL.trackingRecordType) />
		<cfset LOCAL.trackingRecord.setProduct(LOCAL.product) />
		
		
		<cfreturn retStruct>
	</cffunction>
</cfcomponent>