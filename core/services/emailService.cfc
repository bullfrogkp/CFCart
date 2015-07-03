<cfcomponent output="false" accessors="true">
	cfproperty name="fromEmail" type="string"> 
	cfproperty name="toEmail" type="string"> 
	cfproperty name="contentName" type="string"> 
	cfproperty name="replaceStruct" type="struct"> 
	
	<cffunction name="sendEmail" access="public" returntype="void">		
	    <cfset var LOCAL = StructNew() />
		
		<cfset LOCAL.emailContent = EntityLoad("emailContent",{name=getContentName()},true) />

		<cfset LOCAL.emailContentSent = replaceEmailVariables(	content = LOCAL.emailContent.getContent(),
																replaceStruct = ARGUMENTS.replaceStruct) />
			
		<cfset sendDirectEmail(	fromEmail = getFromEmail(), 
								toEmail = getToEmail(), 
								emailType = LOCAL.emailContent.getContentType(),
								emailSubject = LOCAL.emailContent.getSubject(),
								emailContent = LOCAL.emailContentSent) />
		
	</cffunction>
	
	<cffunction name="sendDirectEmail" access="public" returntype="void">
	    <cfargument name="fromEmail" type="string" required="true" />
	    <cfargument name="toEmail" type="string" required="true" />
		<cfargument name="emailSubject" type="string" required="true" />
		<cfargument name="emailContent" type="string" required="true" />
		<cfargument name="emailType" type="string" required="true" />
		
	    <cfset var LOCAL = StructNew() />
		
		<cfmail from="#Trim(ARGUMENTS.fromEmail)#" 
				to="#Trim(ARGUMENTS.toEmail)#" 
				type="#ARGUMENTS.emailType#"
				subject="#Trim(ARGUMENTS.emailSubject)#">#Trim(ARGUMENTS.emailContent)#</cfmail>
		
	</cffunction>
	
	<cffunction name="replaceEmailVariables" access="public" output="false" returnType="string">
		<cfargument name="replaceStruct" type="struct" required="true">
		<cfargument name="replaceContent" type="string" required="true">
		
		<cfset var LOCAL = StructNew() />
	
		<cfset LOCAL.retContent = ARGUMENTS.replaceContent />
		
		<cfloop collection="#ARGUMENTS.replaceStruct#" item="LOCAL.i">		
			<cfset LOCAL.retContent = ReplaceNoCase(LOCAL.retContent,"${#LOCAL.i#}",StructFind(replaceStruct,i),"all") />
		</cfloop>
		
		<cfreturn LOCAL.retContent />
	</cffunction>
	
</cfcomponent>