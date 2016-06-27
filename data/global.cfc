<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	<cfproperty name="formData" type="struct" required="true"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="validateGlobalAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
				
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadGlobalPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken}, true) />
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name="shopping cart"},true) />
		<cfset LOCAL.pageData.shoppingCartItems = EntityLoad("tracking_record",{trackingEntity = LOCAL.trackingEntity, trackingRecordType = LOCAL.trackingRecordType}) />
		
		<cfset LOCAL.pageData.shoppingCartItemTotalCount = 0 />
		<cfset LOCAL.pageData.shoppingCartItemTotalAmount = 0 />
		<cfloop array="#LOCAL.pageData.shoppingCartItems#" index="LOCAL.shoppingCartItem">
			<cfset LOCAL.pageData.shoppingCartItemTotalCount += LOCAL.shoppingCartItem.getCount() />
			<cfset LOCAL.pageData.shoppingCartItemTotalAmount += LOCAL.shoppingCartItem.getCount() * LOCAL.shoppingCartItem.getProduct().getPrice() />
		</cfloop>
		
		<cfset LOCAL.pageData.categories = EntityLoad("category",{isSpecial = false, isEnabled = true, isDeleted = false},"rank Asc") />
		<cfset LOCAL.pageData.currencies =  EntityLoad("currency", {isEnabled=true}) />
		<cfset LOCAL.pageData.currencyNow =  EntityLoad("currency", {currencyId=SESSION.currency.id},true) />
		<cfset LOCAL.pageData.slogan =  "FREE SHIPPING ON ALL US ORDERS this week!" />
		
		<cfif 	ListLen(CGI.PATH_INFO,"/") EQ 6 
				AND
				(
					Trim(ListGetAt(CGI.PATH_INFO,6,"/")) NEQ "-"
					OR
					Trim(ListGetAt(CGI.PATH_INFO,2,"/")) NEQ "-"
				)>
				
			<cfif Trim(ListGetAt(CGI.PATH_INFO,6,"/")) EQ "-">
				<cfset LOCAL.pageData.searchText = "" />
			<cfelse>
				<cfset LOCAL.pageData.searchText = Trim(ListGetAt(CGI.PATH_INFO,6,"/")) />
			</cfif>
			
			<cfif Trim(ListGetAt(CGI.PATH_INFO,2,"/")) EQ "-">
				<cfset LOCAL.pageData.categoryId = 0 />
			<cfelse>
				<cfset LOCAL.pageData.categoryId = ListGetAt(CGI.PATH_INFO,2,"/") />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.searchText = "" />
			<cfset LOCAL.pageData.categoryId = 0 />
		</cfif>
				
		<cfreturn LOCAL.pageData />
	</cffunction>
	
	<cffunction name="processGlobalFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.formdata = Duplicate(FORM) />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateGlobalFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processGlobalFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
	
		<cfif (StructKeyExists(FORM,"search_product") OR StructKeyExists(FORM,"search_product.x")) AND (Trim(getFormaData().search_text) NEQ "" OR getFormaData().search_category_id NEQ 0)>
		
			<cfif Trim(getFormaData().search_text) EQ "">
				<cfset LOCAL.searchText = "-" />
			<cfelse>
				<cfset LOCAL.searchText = URLEncodedFormat(Trim(getFormaData().search_text)) />
			</cfif>
			
			<cfif getFormaData().search_category_id EQ 0>
				<cfset LOCAL.searchCategoryId = "-" />
				<cfset LOCAL.searchCategoryName = "-" />
			<cfelse>
				<cfset LOCAL.category = EntityLoadByPK("category",getFormaData().search_category_id) />
				<cfset LOCAL.searchCategoryId = getFormaData().search_category_id />
				<cfset LOCAL.searchCategoryName = URLEncodedFormat(LOCAL.category.getName()) />
			</cfif>
		
			<cfset LOCAL.pathInfo = "/#LOCAL.searchCategoryName#/#LOCAL.searchCategoryId#/1/1/-/#LOCAL.searchText#/" />
				
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#products.cfm#LOCAL.pathInfo#" />
			
		<cfelseif StructKeyExists(FORM,"currency_id")>
		
			<cfset LOCAL.newCurrency = EntityLoadByPK("currency",getFormaData().currency_id) />
			<cfset SESSION.currency.id = LOCAL.newCurrency.getCurrencyId() />
			<cfset SESSION.currency.code = LOCAL.newCurrency.getCode() />
			<cfset SESSION.currency.locale = LOCAL.newCurrency.getLocale() />
			
			<cfif StructKeyExists(SESSION,"cart")>
				<cfset SESSION.cart.setCurrencyId(SESSION.currency.id) />
				<cfset SESSION.cart.calculate() />
			</cfif>
		
		<cfelseif StructKeyExists(FORM,"subscribe_customer")>
		
			<cfif IsValid("email",Trim(getFormaData().subscribe_email))>
				<!--- get the enabled customer with the same email --->
				<cfset LOCAL.existingActiveCustomer = EntityLoad("customer",{email = Trim(getFormaData().subscribe_email), isEnabled = true, isDeleted = false}, true) />
				<cfif NOT IsNull(LOCAL.existingActiveCustomer)>
					<cfset LOCAL.existingActiveCustomer.setSubscribed(true) />
					<cfset EntitySave(LOCAL.existingActiveCustomer) />
				<cfelse>
					<!--- get the latest disable customer with the same email --->
					<cfset LOCAL.existingInActiveCustomerArray = EntityLoad("customer",{email = Trim(getFormaData().subscribe_email), isEnabled = false, isDeleted = false}, "createdDatetime Desc") />
					<cfif NOT ArrayIsEmpty(LOCAL.existingInActiveCustomerArray)>
						<cfset LOCAL.existingInActiveCustomer = LOCAL.existingInActiveCustomerArray[1] />
						<cfset LOCAL.existingInActiveCustomer.setSubscribed(true) />
						<cfset EntitySave(LOCAL.existingInActiveCustomer) />
					<cfelse>
						<cfset LOCAL.customer = EntityNew("customer") />
						<cfset LOCAL.customer.setCreatedUser(SESSION.user.userName) />
						<cfset LOCAL.customer.setCreatedDatetime(Now()) />
						<cfset LOCAL.customer.setIsDeleted(false) />
						<cfset LOCAL.customer.setIsNew(true) />
						<cfset LOCAL.customer.setIsEnabled(false) />
						<cfset LOCAL.customer.setEmail(Trim(getFormaData().subscribe_email)) />
						<cfset LOCAL.customer.setSubscribed(true) />
						
						<cfset LOCAL.defaultCustomerGroup = EntityLoad("customer_group",{isDefault=true},true) />
						<cfset LOCAL.customer.setCustomerGroup(LOCAL.defaultCustomerGroup) />
						
						<cfset EntitySave(LOCAL.customer) />
					</cfif>
				</cfif>
				
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#subscription_done.cfm" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="processGlobalURLDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(URL,"logout")>
			<cfset SESSION.user.customerId = "" />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#index.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="processGlobalURLDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>