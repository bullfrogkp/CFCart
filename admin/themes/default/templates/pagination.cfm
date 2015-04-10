<cfoutput>
	<ul class="pagination pagination-sm no-margin pull-right">
		<cfif REQUEST.pageData.currentPage NEQ 1>
			<li><a href="#APPLICATION.absoluteUrlWeb#admin/#REQUEST.pageData.currentPageName#.cfm?#REQUEST.pageData.currentQueryString#page=1">&laquo;</a></li>
		</cfif>
		<cfloop from="1" to="#REQUEST.pageData.totalPages#" index="i">
			<li><a href="#APPLICATION.absoluteUrlWeb#admin/#REQUEST.pageData.currentPageName#.cfm?#REQUEST.pageData.currentQueryString#page=#i#">#i#</a></li>
		</cfloop>
		<cfif REQUEST.pageData.currentPage NEQ REQUEST.pageData.totalPages>
			<li><a href="#APPLICATION.absoluteUrlWeb#admin/#REQUEST.pageData.currentPageName#.cfm?#REQUEST.pageData.currentQueryString#page=#REQUEST.pageData.totalPages#">&raquo;</a></li>
		</cfif>
	</ul>
</cfoutput>