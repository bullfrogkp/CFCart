<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Order Tracking</span> 
</div>
<div id="login-wrapper">
	<div id="login-form">
		<form method="post">
			<h2>Track your order</h2>
			<table>
				<tr>
					<td colspan="2">
						<input type="text" name="order_number" placeholder="Order Number">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="email" name="email" placeholder="Email Address">
					</td>
				</tr>
				<tr>
					<td style="padding-top:10px;">
						<button type="submit" class="btn-signup" name="check_order">Submit</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div style="clear:both;"></div>
</div>
</cfoutput>