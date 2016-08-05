<!----code starts---->
<cfhttp url="http://127.0.0.1:8500/rest/IIT/student/2" method="get">
<cfoutput>#cfhttp.filecontent#</cfoutput>
<!----code ends----->