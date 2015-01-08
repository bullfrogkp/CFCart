<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Dashboard</span> 
</div>
<cfinclude template="myaccount_sidenav.cfm" />
<div id="myaccount-content">
	<h1>Order Detail</h1>
	<div style="margin-top:20px;">
		<p><strong>Tracking Number: OR20141227227</strong></p>
		<p><strong>Address</strong></p>
		<p>Billing Address: 403-327-2809</p>
		<p>Michelle samek, 9 York Place W Lethbridge, Alberta, T1k 3W4, Canada </p>
		<p>Shipping Address: 403-327-2809</p>
		<p>Michelle Samek, ##13 495 W.T. Hill Blvd. S. Lethbridge, Alberta, T1j 1Y6, Canada</p>
		<div class="myaccount-table" >
		<table class="wp-list-table widefat fixed bookmarks" cellspacing="0">
				<tr>
					<td scope="col" id="categories" class="manage-column column-categories">Status</th>
					<td scope="col" id="categories" class="manage-column column-categories">Create Datetime</th>
					<td scope="col" id="categories" class="manage-column column-categories">End Datetime</th>
					<td scope="col" id="categories" class="manage-column column-categories">Comment</th>
				</tr>
				<tr id="link-1" valign="middle" class="alternate">
					<td class="column-categories">Order Placed</td>
					<td class="column-categories">2014 Dec 27 02:15:27</td>
					<td class="column-categories">2014 Dec 27 02:15:27</td>
					<td class="column-categories"></td>
				</tr>
			
				<tr id="link-1" valign="middle" class="alternate">
					<td class="column-categories">Pending Shipment</td>
					<td class="column-categories">2014 Dec 27 02:15:27</td>
					<td class="column-categories">2015 Jan 02 08:25:02</td>
					<td class="column-categories"></td>
				</tr>
			
				<tr id="link-1" valign="middle" class="alternate">
					<td class="column-categories">Shipped</td>
					<td class="column-categories">2015 Jan 02 08:25:02</td>
					<td class="column-categories"> </td>
					<td class="column-categories"></td>
				</tr>
			
		</table>
		</div>
		
		<div style="clear:both;"></div>
	</div>
</div>
</cfoutput>