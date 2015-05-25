<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_count")>
			<cfloop collection="#FORM#" item="LOCAL.field">
				<cfif FindNoCase("product_count_", LOCAL.field) AND NOT IsNumeric(FORM["#LOCAL.field#"])>
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid value for the number of products in the order.") />
					<cfbreak />
				</cfif>
			</cfloop>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Shopping Cart | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = "shopping cart"},true) />
		<cfset LOCAL.pageData.trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken},true) />
		<cfset LOCAL.pageData.trackingRecords = EntityLoad("tracking_record", {trackingRecordType = LOCAL.trackingRecordType, trackingEntity = LOCAL.pageData.trackingEntity}) />
		
		<cfset LOCAL.pageData.subTotal = 0 />
		<cfset LOCAL.pageData.tax = 0 />
		
		<cfloop array="#LOCAL.pageData.trackingRecords#" index="LOCAL.record">
			<cfset LOCAL.product = LOCAL.record.getProduct() />
			<cfset LOCAL.pageData.subTotal += LOCAL.product.getPrice(customerGroupName = SESSION.user.customerGroupName) * LOCAL.record.getCount() />
			<cfset LOCAL.pageData.tax += LOCAL.product.getPrice(customerGroupName = SESSION.user.customerGroupName) * (1 + LOCAL.product.getTaxCategory().getRate()) * LOCAL.record.getCount() />
		</cfloop>
		
		<cfset LOCAL.pageData.total = LOCAL.pageData.subTotal + LOCAL.pageData.tax />
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"submit_cart")>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/step1.cfm" />
		<cfelseif StructKeyExists(FORM,"update_count")>
			<cfset LOCAL.trackingRecord = EntityLoadByPK("tracking_record",FORM.tracking_record_id) />
			<cfset LOCAL.trackingRecord.setCount(FORM["product_count_#FORM.tracking_record_id#"]) />
			<cfset EntitySave(LOCAL.trackingRecord) />
		<cfelseif StructKeyExists(FORM,"remove_product")>
			<cfset LOCAL.trackingRecord = EntityLoadByPK("tracking_record",FORM.remove_product) />
			<cfset EntityDelete(LOCAL.trackingRecord) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>