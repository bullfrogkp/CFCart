<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"user_login")>
			<cfif Trim(FORM.username) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid username.") />
			</cfif>
			<cfif Trim(FORM.password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your password.") />
			</cfif>
			
			<cfif Trim(FORM.username) NEQ "" AND Trim(FORM.password) NEQ "">
				<cfset LOCAL.customerService = new "#APPLICATION.componentPathRoot#core.services.userService"() />
				<cfset LOCAL.customerService.setUsername(Trim(FORM.username)) />
				<cfset LOCAL.customerService.setPassword(Trim(FORM.password)) />
				<cfif LOCAL.customerService.isUserValid() EQ false>
					<cfset ArrayAppend(LOCAL.messageArray,"Username or password is not correct.") />
				</cfif>
			</cfif>
		<cfelseif StructKeyExists(FORM,"user_signup")>
			<cfif Trim(FORM.email_address) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email address.") />
			</cfif>
			<cfif Trim(FORM.new_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your password.") />
			</cfif>
			<cfif Trim(FORM.confirm_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please confirm your password.") />
			</cfif>
			<cfif Trim(FORM.new_password) NEQ Trim(FORM.confirm_password)>
				<cfset ArrayAppend(LOCAL.messageArray,"Passwords don't match.") />
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
		
		<cfset LOCAL.pageData.title = "Login | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"user_login")>
			<cfset LOCAL.customer = EntityLoad("customer",{username=getUsername(),password=Hash(getPassword()),isDeleted=false,isEnabled=true},true) />
			
			<cfset SESSION.user.userName = LOCAL.customer.getFullName() />
			<cfset SESSION.user.customerId = LOCAL.customer.getCustomerId() />
			<cfset SESSION.user.customerGroupName = LOCAL.customer.getCustomerGroup().getName() />
		<cfelseif StructKeyExists(FORM,"user_signup")>
			<cfset LOCAL.customer = EntityNew() />
		</cfif>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#myaccount/dashboard.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>