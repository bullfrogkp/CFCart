<cfcomponent persistent="true"> 
    <cfproperty name="trackingRecordId" column="tracking_record_id" fieldtype="id" generator="native"> 
	<cfproperty name="count" column="count" ormtype="integer">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="trackingEntity" fieldtype="many-to-one" cfc="tracking_entity" fkcolumn="tracking_entity_id">
	<cfproperty name="trackingRecordType" fieldtype="many-to-one" cfc="tracking_record_type" fkcolumn="tracking_record_type_id">
	<cfproperty name="customerGroupName" type="string" persistent="false">
	<cfproperty name="currencyId" type="integer" persistent="false">
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="any">		
		<cfreturn getProduct().getDetailPageURLMV()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageURL" access="public" output="false" returnType="any">		
		<cfreturn getProduct().getDefaultImageLinkMV(type='small') />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDisplayName" access="public" output="false" returnType="any">		
		<cfreturn getProduct().getDisplayName() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPrice" access="public" output="false" returnType="any">		
		<cfreturn LSCurrencyFormat(getProduct().getPrice(customerGroupName = SESSION.user.customerGroupName, currencyId = SESSION.currency.id),"local",SESSION.currency.locale) />
	</cffunction>
</cfcomponent>
