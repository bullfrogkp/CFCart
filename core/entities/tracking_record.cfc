<cfcomponent persistent="true"> 
    <cfproperty name="trackingRecordId" column="tracking_record_id" fieldtype="id" generator="native"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="trackingEntity" fieldtype="many-to-one" cfc="tracking_entity" fkcolumn="tracking_entity_id">
	<cfproperty name="trackingEntityType" fieldtype="many-to-one" cfc="tracking_entity_type" fkcolumn="tracking_entity_type_id">
</cfcomponent>
