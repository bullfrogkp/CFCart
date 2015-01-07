<cfset str = "12/21/2014 11:40:02 pm" />

<cfset time = CreateDateTime(Year(str),month(str),day(str),hour(str),minute(str),second(str)) />


<cfdump var="#time#">