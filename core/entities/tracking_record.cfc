<cfcomponent persistent="true"> 
    <cfproperty name="trackingRecordId" column="tracking_record_id" fieldtype="id" generator="native"> 
	<cfproperty name="count" column="count" ormtype="integer">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="trackingEntity" fieldtype="many-to-one" cfc="tracking_entity" fkcolumn="tracking_entity_id">
	<cfproperty name="trackingRecordType" fieldtype="many-to-one" cfc="tracking_record_type" fkcolumn="tracking_record_type_id">
	<cfproperty name="customerGroupName" type="string" persistent="false">
	<cfproperty name="currencyId" type="integer" persistent="false">
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="string">		
		<cfreturn getProduct().getDetailPageURLMV()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageURL" access="public" output="false" returnType="string">		
		<cfreturn getProduct().getDefaultImageLinkMV(type='small') />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDisplayName" access="public" output="false" returnType="string">		
		<cfreturn getProduct().getDisplayName() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPrice" access="public" output="false" returnType="string">
		<cfset LOCAL.currency = EntityLoadByPK("currency",getCurrencyId()) />
		<cfreturn LSCurrencyFormat(getProduct().getPrice(customerGroupName = getCustomerGroupName(), currencyId = getCurrencyId()),"local",LOCAL.currency.getLocale()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getSubTotal" access="public" output="false" returnType="string">
		<cfset LOCAL.currency = EntityLoadByPK("currency",getCurrencyId()) />
		<cfreturn LSCurrencyFormat(getProduct().getPrice(customerGroupName = getCustomerGroupName(), currencyId = getCurrencyId()) * getCount(),"local",LOCAL.currency.getLocale()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getAttributes" access="public" output="false" returnType="array">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retArray = [] />
		
		<cfloop array="#getProduct().getProductAttributeRelas()#" index="LOCAL.rela">
			<cfset ArrayAppend(LOCAL.retArray,LOCAL.rela.getAttribute()) />
		</cfloop>
		
		<cfreturn LOCAL.retArray />
	</cffunction>
	<!------------------------------------------------------------------------------->	
</cfcomponent>
