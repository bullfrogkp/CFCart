<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"checkout_login")>
			<cfif Trim(FORM.username) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid username.") />
			</cfif>
			<cfif Trim(FORM.password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your password.") />
			</cfif>
			
			<cfif Trim(FORM.username) NEQ "" AND Trim(FORM.password) NEQ "">
				<cfset LOCAL.customerService = new "#APPLICATION.componentPathRoot#core.services.customerService"() />
				<cfset LOCAL.customerService.setUsername(Trim(FORM.username)) />
				<cfset LOCAL.customerService.setPassword(Trim(FORM.password)) />
				<cfif LOCAL.customerService.isUserValid() EQ false>
					<cfset ArrayAppend(LOCAL.messageArray,"Username or password is not correct.") />
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Sign In | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"checkout_login")>
			<cfset LOCAL.customer = EntityLoad("customer",{email=Trim(FORM.username),password=Hash(Trim(FORM.password)),isDeleted=false,isEnabled=true},true) />
			<cfset LOCAL.customer.setLastLoginDatetime(Now()) />
			<cfset EntitySave(LOCAL.customer) />
			
			<cfset SESSION.user.userName = LOCAL.customer.getFullName() />
			<cfset SESSION.user.customerId = LOCAL.customer.getCustomerId() />
			<cfset SESSION.user.customerGroupName = LOCAL.customer.getCustomerGroup().getName() />
			
			<cfset SESSION.cart.setCustomerGroup(LOCAL.customer.getCustomerGroup()) />
			<cfset SESSION.cart.calculate() />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_step1_customer.cfm" />
		<cfelseif StructKeyExists(FORM,"guest_checkout")>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_step1_guest.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>