<cfset LOCAL.user = EntityNew("user") />
<cfset LOCAL.user.setUsername("kevin") />
<cfset LOCAL.user.setPassword(Hash("kevin")) />
<cfset LOCAL.user.setIsDeleted(false) />
<cfset EntitySave(LOCAL.user) />