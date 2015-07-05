<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Password Assistance</span> 
</div>
			
<div id="login-wrapper">
	<form method="post">
		<input type="hidden" name="customer_id" value="#REQUEST.pageData.customerId#" />
		<h2>Password has been reset</h2>
		<p>
			Your password has been reset, please <a href="login.cfm">login</a> again.
		</p>
	</form>
</div>
</cfoutput>