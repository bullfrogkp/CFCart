<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT StructIsEmpty(FORM)>
			<cfset SESSION.temp.formdata = Duplicate(FORM) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="_setRedirectURL" access="private" output="false" returnType="string">
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>	
			<cfif StructKeyExists(URL,"active_tab_id")>	
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#URL.id#&active_tab_id=#URL.active_tab_id#" />
			<cfelse>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#URL.id#" />
			</cfif>
		<cfelse>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm" />
		</cfif>
		
		<cfreturn LOCAL.redirectUrl />	
	</cffunction>
	
	<cffunction name="_setActiveTab" access="private" output="false" returnType="struct">
		<cfargument name="defaultActiveTabId" type="string" required="false">
		
		<cfset var LOCAL = {} />
	
		<cfset LOCAL.tabs = {} />
		<cfset LOCAL.tabs["tab_1"] = "" />
		<cfset LOCAL.tabs["tab_2"] = "" />
		<cfset LOCAL.tabs["tab_3"] = "" />
		<cfset LOCAL.tabs["tab_4"] = "" />
		<cfset LOCAL.tabs["tab_5"] = "" />
		<cfset LOCAL.tabs["tab_6"] = "" />
		<cfset LOCAL.tabs["tab_7"] = "" />
		<cfset LOCAL.tabs["tab_8"] = "" />
		<cfset LOCAL.tabs["tab_9"] = "" />
		<cfset LOCAL.tabs["tab_10"] = "" />
				
		<cfif StructKeyExists(URL,"active_tab_id")>	
			<cfset LOCAL.tabs["activeTabId"] = URL.active_tab_id />
			<cfset LOCAL.tabs["#URL.active_tab_id#"] = "active" />
		<cfelse>
			<cfset LOCAL.tabs["activeTabId"] = "tab_1" />
			<cfif StructKeyExists(ARGUMENTS,"defaultActiveTabId")>
				<cfset LOCAL.tabs["#ARGUMENTS.defaultActiveTabId#"] = "active" />
			<cfelse>
				<cfset LOCAL.tabs["tab_1"] = "active" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL.tabs /> 
	</cffunction>
	
	<cffunction name="_setTempMessage" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.message = {} />
	
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.message.messageArray = SESSION.temp.message.messageArray />
			<cfset LOCAL.message.messageType = SESSION.temp.message.messageType />
		</cfif>
		
		<cfreturn LOCAL.message /> 
	</cffunction>
	
	<cffunction name="_getPaginationInfo" access="private" output="false" returnType="struct">
		<cfargument name="recordStruct" type="struct" required="true"> 
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.records = ARGUMENTS.recordStruct.records />
		<cfset LOCAL.totalCount = ARGUMENTS.recordStruct.totalCount />
		<cfset LOCAL.totalPages = ARGUMENTS.recordStruct.totalPages />
		
		<cfset LOCAL.currentQueryString = "" />
		<cfloop collection="#URL#" item="LOCAL.key">
			<cfif LOCAL.key NEQ "page" AND LOCAL.key NEQ "active_tab_id">
				<cfset LOCAL.currentQueryString &= LOCAL.key & "=" & URL["#LOCAL.key#"] & "&" />
			</cfif>
		</cfloop>
		
		<cfif NOT IsNull(URL.page) AND IsNumeric(URL.page)>
			<cfset LOCAL.currentPage = URL.page />
		<cfelse>
			<cfset LOCAL.currentPage = 1 />
		</cfif>
		
		<cfreturn LOCAL /> 
	</cffunction>
	
	<cffunction name="_createImages" access="private" output="false" returnType="void">
		<cfargument name="imagePath" type="string" required="true">
		<cfargument name="imageNameWithExtension" type="string" required="true">
		<cfargument name="sizeArray" type="array" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.imageUtils = new "#APPLICATION.componentPathRoot#core.utils.imageUtils"() />
		<cfset LOCAL.image = ImageRead(ARGUMENTS.imagePath & ARGUMENTS.imageNameWithExtension)>
		
		<cfloop array="#ARGUMENTS.sizeArray#" index="LOCAL.size">
			<cfset LOCAL.newImage = ImageNew(LOCAL.image)>
				
			<cfif LOCAL.size.crop EQ true>
				<cfset LOCAL.newImage = LOCAL.imageUtils.aspectCrop(LOCAL.newImage, LOCAL.size.width, LOCAL.size.height, LOCAL.size.position)>
			<cfelseif  IsNumeric(LOCAL.size.width) AND IsNumeric(LOCAL.size.height)>
				<cfset ImageResize(LOCAL.newImage, LOCAL.size.width, LOCAL.size.height) />
			<cfelseif  IsNumeric(LOCAL.size.width)>
				<cfset ImageResize(LOCAL.newImage, LOCAL.size.width, "") />
			<cfelseif  IsNumeric(LOCAL.size.height)>
				<cfset ImageResize(LOCAL.newImage, "", LOCAL.size.height) />
			</cfif>
						
			<cfset ImageWrite(LOCAL.newImage,"#ARGUMENTS.imagePath##LOCAL.size.name#_#ARGUMENTS.imageNameWithExtension#")> 
		</cfloop>
		
	</cffunction>
</cfcomponent>