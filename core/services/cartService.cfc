<cfcomponent extends="service" output="false" accessors="true">
	<cffunction name="addTrackingRecord" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="productId" type="numeric" required="true">
		<cfargument name="count" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		<cfset var retStruct = {} />
		
		<cfset LOCAL.product = EntityLoadByPK("product",ARGUMENTS.productId) />
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_entity_type",{name = "shipping cart"},true) />
		
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken},true) />
		
		<cfif IsNull(LOCAL.trackingEntity)>
			<cfset LOCAL.trackingEntity = EntityNew("tracking_entity") />
			<cfset LOCAL.trackingEntity.setCfid(COOKIE.cfid) />
			<cfset LOCAL.trackingEntity.setCftoken(COOKIE.cftoken) />
			<cfset LOCAL.trackingEntity.setLastAccessDatetime(Now()) />
			<cfset EntitySave(LOCAL.trackingEntity) />
		</cfif>
		
		<cfset LOCAL.trackingRecord = EntityNew("tracking_record") />
		<cfset LOCAL.trackingRecord.setTrackingRecordType(LOCAL.trackingRecordType) />
		<cfset LOCAL.trackingRecord.setTrackingEntity(LOCAL.trackingEntity) />
		<cfset LOCAL.trackingRecord.setProduct(LOCAL.product) />
		<cfset LOCAL.trackingRecord.setCount(ARGUMENTS.count) />
		<cfset EntitySave(LOCAL.trackingRecord) />
		
		<cfset retStruct.trackingRecordId = LOCAL.trackingRecord.getTrackingRecordId() />
		
		<cfreturn retStruct />
	</cffunction>
</cfcomponent>