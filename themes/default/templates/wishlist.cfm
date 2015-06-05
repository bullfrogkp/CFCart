<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Wishlist</span> 
</div>
			
<cfinclude template="myaccount_sidenav.cfm" />
<div id="myaccount-content">
	<strong>My Wishlist</strong>
	<div style="margin-top:20px;">
		<div class="myaccount-table" >
			<table >
				<tr>
					<td>Product</td>
					<td>Description</td>
					<td>Price</td>
					<td></td>
				</tr>
				<cfif ArrayLen(REQUEST.pageData.customer.getWishlistProducts()) GT 0>
					<cfloop array="#REQUEST.pageData.customer.getWishlistProducts()#" index="wp">
						<tr>
							<td><img src="#wp.getProduct().getDefaultImageLink(type="small")#" style="width:100px;" /></td>
							<td>#wp.getProduct().getDescription()#</td>
							<td>#wp.getProduct().getPrice(customerGroupName = SESSION.user.customerGroupName)#</td>
							<td><a href="#wp.getProduct().getDetailPageURL()#">Detail</a></td>
						</tr>
					</cfloop>
				<cfelse>
				<tr>
					<td colspan="4">No product found.</td>
				</tr>
				</cfif>
			</table>
		</div>
		
		<div style="clear:both;"></div>
	</div>
</div>
</cfoutput>