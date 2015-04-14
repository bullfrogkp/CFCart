<cfcomponent extends="service" output="false" accessors="true">
    <cfproperty name="attributeSetId" type="numeric"> 
    <cfproperty name="parentProductId" type="numeric"> 
    <cfproperty name="categoryId" type="numeric"> 

   <cffunction name="getProducts" output="false" access="public" returntype="struct">
		<cfset var LOCAL = {} />
	   
		<cfset LOCAL.qry = "from product p " />
	   
		<cfif NOT IsNull(getCategoryId())>
			<cfset LOCAL.qry = LOCAL.qry & "join p.categories c where c.category_id = #getCategoryId()# " />
		</cfif>
	   
		<cfif getSearchKeywords() NEQ "">	
			<cfset LOCAL.qry = "from product p where (display_name like '%#getSearchKeywords()#%' or keywords like '%#getSearchKeywords()#%' or description like '%#getSearchKeywords()#%' )" /> 
		<cfelse>
			<cfset LOCAL.qry = "from product p where 1=1 " /> 
		</cfif>
		
		<cfif NOT IsNull(getId())>
			<cfset LOCAL.qry = LOCAL.qry & "and product_id = '#getId()#' " />
		</cfif>
		<cfif NOT IsNull(getIsEnabled())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_enabled = '#getIsEnabled()#' " />
		</cfif>
		<cfif NOT IsNull(getIsDeleted())>
			<cfset LOCAL.qry = LOCAL.qry & "and is_deleted = '#getIsDeleted()#' " />
		</cfif>
	   
	    <cfset LOCAL.records = ORMExecuteQuery(LOCAL.qry, false, getPaginationStruct()) /> 
		<cfset LOCAL.totalCount = ORMExecuteQuery( "select count(product_id) as count " & LOCAL.qry, true) /> 
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / APPLICATION.recordsPerPage) /> 
		
		<cfreturn LOCAL />
    </cffunction>
		
	<cffunction name="getCustomerGroupPrices" output="false" access="public" returntype="query">
		<cfset var LOCAL = {} />
			   
	    <cfquery name="LOCAL.getProductGroupPrices">
			SELECT	cg.customer_group_id AS customerGroupId
			,		cg.display_name AS groupDisplayName
			,		(	SELECT	pcgr.product_customer_group_rela_id
						FROM	product_customer_group_rela pcgr
						WHERE 	pcgr.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
						AND 	cg.customer_group_id = pcgr.customer_group_id) AS productCustomerGroupRelaId
			FROM	customer_group cg 
			ORDER BY cg.is_default DESC, cg.display_name
		</cfquery>
 
		<cfreturn LOCAL.getProductGroupPrices />
    </cffunction>
	
	<cffunction name="getProductAttributeAndValues" output="false" access="public" returntype="array">
		<cfset var LOCAL = {} />
	   
		<cfquery name="LOCAL.getAttributes">
			SELECT	attr.attribute_id
			,		attr.display_name
			,		asar.required
			FROM	attribute attr
			JOIN	attribute_set_attribute_rela asar ON asar.attribute_id = attr.attribute_id
			WHERE	asar.attribute_set_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getAttributeSetId()#" /> 
		</cfquery>
		
		<cfset LOCAL.attributeArray = [] />
		<cfloop query="LOCAL.getAttributes">
			<cfset LOCAL.attributeStruct = {} />
			<cfset LOCAL.attributeStruct.name = LOCAL.getAttributes.display_name />
			<cfset LOCAL.attributeStruct.required = LOCAL.getAttributes.required />
			<cfset LOCAL.attributeStruct.attributeId = LOCAL.getAttributes.attribute_id />
			<cfset LOCAL.attributeStruct.attributeName = LOCAL.getAttributes.display_name />
			
			<cfset LOCAL.attributeStruct.attributeValueArray = [] />
			
			 <cfquery name="LOCAL.getAttributeValues">
				SELECT	av.attribute_value_id, av.value, av.image_name, av.display_name
				FROM	attribute_value av
				WHERE	av.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
				AND		av.attribute_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#LOCAL.getAttributes.attribute_id#" />
			</cfquery>
			
			<cfloop query="LOCAL.getAttributeValues">
				<cfset LOCAL.attributeValueStruct = {} />
				<cfset LOCAL.attributeValueStruct.attributeValueId = LOCAL.getAttributeValues.attribute_value_id />
				<cfset LOCAL.attributeValueStruct.imageName = LOCAL.getAttributeValues.image_name />
				<cfset LOCAL.attributeValueStruct.value = LOCAL.getAttributeValues.value />
				<cfset LOCAL.attributeValueStruct.name = LOCAL.getAttributeValues.display_name />
				<cfset ArrayAppend(LOCAL.attributeStruct.attributeValueArray, LOCAL.attributeValueStruct) />
			</cfloop>
			
			<cfset ArrayAppend(LOCAL.attributeArray, LOCAL.attributeStruct) />
		</cfloop>
 
		<cfreturn LOCAL.attributeArray />
    </cffunction>
	
	<cffunction name="getAttributeSetAttributes" output="false" access="public" returntype="query">
		<cfset var LOCAL = {} />
	   
		<cfquery name="LOCAL.getAttributes">
			SELECT	attr.attribute_id
			,		attr.display_name
			,		asar.required
			FROM	attribute attr
			JOIN	attribute_set_attribute_rela asar ON asar.attribute_id = attr.attribute_id
			WHERE	asar.attribute_set_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getAttributeSetId()#" /> 
		</cfquery>
		 
		<cfreturn LOCAL.getAttributes />
    </cffunction>
	
	<cffunction name="isProductAttributeComplete" output="false" access="public" returntype="boolean">
		<cfset var LOCAL = {} />
	   
		<cfquery name="LOCAL.getAttributes">
			SELECT	attr.attribute_id
			FROM	attribute attr
			JOIN	attribute_set_attribute_rela asar ON asar.attribute_id = attr.attribute_id
			WHERE	asar.attribute_set_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getAttributeSetId()#" /> 
			AND		asar.required = <cfqueryparam cfsqltype="cf_sql_bit" value="1" />
		</cfquery>
		
		<cfquery name="LOCAL.getAttributeValues">
			SELECT	DISTINCT attribute_id
			FROM	attribute_value
			WHERE	product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
		</cfquery>

		<cfif Find(ListSort(ValueList(LOCAL.getAttributes.attribute_id),"numeric"),ListSort(ValueList(LOCAL.getAttributeValues.attribute_id),"numeric"))>
			<cfset LOCAL.retValue = true />
		<cfelse>
			<cfset LOCAL.retValue = false />
		</cfif>
 
		<cfreturn LOCAL.retValue />
    </cffunction>
	
	<cffunction name="getProductShippingMethods" output="false" access="public" returntype="query">
		<cfset var LOCAL = {} />
	   
		<cfquery name="LOCAL.getProductShippingMethods">
			SELECT		sc.display_name AS shipping_carrier_name
			,			sc.image_name
			,			sm.display_name AS shipping_method_name
			,			sm.shipping_method_id
			,			(
							SELECT	product_shipping_method_rela_id 
							FROM 	product_shipping_method_rela psmr
							WHERE 	psmr.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />	
							AND		psmr.shipping_method_id = sm.shipping_method_id
						) AS product_shipping_method_rela_id
			FROM		shipping_carrier sc
			JOIN		shipping_method sm ON sc.shipping_carrier_id = sm.shipping_carrier_id
			ORDER BY	sc.shipping_carrier_id
		</cfquery>
		 
		<cfreturn LOCAL.getProductShippingMethods />
    </cffunction>
	
</cfcomponent>