<cfcomponent persistent="true"> 
    <cfproperty name="trackingRecordId" column="tracking_record_id" fieldtype="id" generator="native"> 
	<cfproperty name="count" column="count" ormtype="integer">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="trackingEntity" fieldtype="many-to-one" cfc="tracking_entity" fkcolumn="tracking_entity_id">
	<cfproperty name="trackingRecordType" fieldtype="many-to-one" cfc="tracking_record_type" fkcolumn="tracking_record_type_id">
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeCartItem" access="public" output="false" returnType="any">
		<cfargument name="trackingRecordId" type="integer" required="true" />
		
		<cfset EntityDelete(EntityLoadById("tracking_record",ARGUMENTS.trackingRecordId)) />
	</cffunction>
</cfcomponent>
