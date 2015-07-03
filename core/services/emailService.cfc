<cfcomponent output="false">
	<cffunction name="sendEmail" access="public" returntype="void">
	    <cfargument name="from_email" type="string" required="true" />
	    <cfargument name="to_email" type="string" required="true" />
		<cfargument name="email_content_name" type="string" required="true" />
		<cfargument name="replace_struct" type="struct" required="true" />
		
	    <cfset var LOCAL = StructNew() />
		
		<cfinvoke component="#APPLICATION.db_cfc_path#db.email_contents" method="getEmailContents" returnvariable="LOCAL.email_content">
			<cfinvokeargument name="email_content_name" value="#ARGUMENTS.email_content_name#">
		</cfinvoke>

		<cfset LOCAL.email_content_replaced = replaceEmailVariables(replace_content = LOCAL.email_content.email_content,
																	replace_struct = ARGUMENTS.replace_struct) />
			
		<cfset sendDirectEmail(	from_email = "#ARGUMENTS.from_email#", 
								to_email = "#ARGUMENTS.to_email#", 
								email_type = "#LOCAL.email_content.email_content_type#",
								email_subject = "#LOCAL.email_content.email_content_subject#",
								email_content = "#LOCAL.email_content_replaced#") />
		
	</cffunction>
	
	<cffunction name="sendDirectEmail" access="public" returntype="void">
	    <cfargument name="from_email" type="string" required="true" />
	    <cfargument name="to_email" type="string" required="true" />
		<cfargument name="email_subject" type="string" required="true" />
		<cfargument name="email_content" type="string" required="true" />
		<cfargument name="email_type" type="string" required="true" />
		
	    <cfset var LOCAL = StructNew() />
		
		<cfset LOCAL.logFile = "emails_sent_" & DateFormat(now(), 'yyyymmdd') & ".log" />
		
		<cfinvoke component="#APPLICATION.db_cfc_path#cfc.logger" method="init" returnvariable="LOCAL.logger">
			<cfinvokeargument name="logFile" value="#APPLICATION.log_path & LOCAL.logFile#">
		</cfinvoke>
		
		<cfset LOCAL.function = "send email" />
		
		<cfset LOCAL.logger.addlog(LOCAL.function, "from:#ARGUMENTS.from_email#") />
		<cfset LOCAL.logger.addlog(LOCAL.function, "to:#ARGUMENTS.to_email#") />
		<cfset LOCAL.logger.addlog(LOCAL.function, "type:#ARGUMENTS.email_type#") />
		<cfset LOCAL.logger.addlog(LOCAL.function, "subject:#ARGUMENTS.email_subject#") />
		<cfset LOCAL.logger.addlog(LOCAL.function, "content:#ARGUMENTS.email_content#") />
		<cfset LOCAL.logger.addlog(LOCAL.function, "user:#SESSION.user#") />
		
		<cfmail from="#Trim(ARGUMENTS.from_email)#" 
				to="#Trim(ARGUMENTS.to_email)#" 
				type="#ARGUMENTS.email_type#"
				subject="#Trim(ARGUMENTS.email_subject)#">#Trim(ARGUMENTS.email_content)#</cfmail>
		
		
	</cffunction>
	
	<cffunction name="replaceEmailVariables" access="public" output="false" returnType="string">
		<cfargument name="replace_struct" type="struct" required="true">
		<cfargument name="replace_content" type="string" required="true">
		
		<cfset var LOCAL = StructNew() />
	
		<cfset LOCAL.ret_content = ARGUMENTS.replace_content />
		
		<cfloop collection="#ARGUMENTS.replace_struct#" item="i">
		
			<cfif NOT FindNoCase("${#i#}",LOCAL.ret_content)>
				<cfthrow message="cannot find match variable '#i#' in the email content" />
			</cfif>
		
			<cfset LOCAL.ret_content = ReplaceNoCase(LOCAL.ret_content,"${#i#}",StructFind(replace_struct,i),"all") />
		</cfloop>
		
		<cfreturn LOCAL.ret_content />
	</cffunction>
	
</cfcomponent>