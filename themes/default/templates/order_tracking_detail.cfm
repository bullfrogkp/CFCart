﻿<cfoutput>
<div class="info-section">
	<div id="breadcrumb">
		<div class="breadcrumb-home-icon"></div>
		<div class="breadcrumb-arrow-icon"></div>
		<span style="vertical-align:middle">Order Tracking</span> 
	</div>
	<div class="info-detail">
	<h2>Order Detail</h2>
	<div style="margin-top:20px;">
		<p><strong>Tracking Number:</strong> #REQUEST.pageData.order.getOrderTrackingNumber()#</p>
		<p><strong>Phone:</strong> #REQUEST.pageData.order.getPhone()#</p>
		<p><strong>Billing Address:</strong></p>
		<p><strong>#REQUEST.pageData.order.getBillingFirstName()# #REQUEST.pageData.order.getBillingMiddleName()# #REQUEST.pageData.order.getBillingLastName()#</strong></p>
		<p>
			#REQUEST.pageData.order.getBillingUnit()# #REQUEST.pageData.order.getBillingStreet()#, #REQUEST.pageData.order.getBillingCity()#, #REQUEST.pageData.order.getBillingProvince().getDisplayName()#<br/> 
			#REQUEST.pageData.order.getBillingPostalCode()#, #REQUEST.pageData.order.getBillingCountry().getDisplayName()#
		</p>
		<p><strong>Shipping Address:</strong></p>
		<p><strong> #REQUEST.pageData.order.getShippingFirstName()# #REQUEST.pageData.order.getShippingMiddleName()# #REQUEST.pageData.order.getShippingLastName()#</strong></p>
		<p>
			#REQUEST.pageData.order.getShippingUnit()# #REQUEST.pageData.order.getShippingStreet()#, #REQUEST.pageData.order.getShippingCity()#, #REQUEST.pageData.order.getShippingProvince().getDisplayName()#<br/> 
			#REQUEST.pageData.order.getShippingPostalCode()#, #REQUEST.pageData.order.getShippingCountry().getDisplayName()#
		</p>
		<div class="myaccount-table" >
			<table class="wp-list-table widefat fixed bookmarks" cellspacing="0">
				<tr>
					<td scope="col" id="categories" class="manage-column column-categories">Status</th>
					<td scope="col" id="categories" class="manage-column column-categories">Create Datetime</th>
					<td scope="col" id="categories" class="manage-column column-categories">End Datetime</th>
					<td scope="col" id="categories" class="manage-column column-categories">Comment</th>
				</tr>
				<cfloop array="#REQUEST.pageData.order.getOrderStatus()#" index="status">
					<tr id="link-1" valign="middle" class="alternate">
						<td class="column-categories">#status.getOrderStatusType().getDisplayName()#</td>
						<td class="column-categories">#DateFormat(status.getStartDatetime(),"mmm dd, yyyy")# #TimeFormat(status.getStartDatetime(),"hh:mm:ss")#</td>
						<td class="column-categories">#DateFormat(status.getEndDatetime(),"mmm dd, yyyy")# #TimeFormat(status.getEndDatetime(),"hh:mm:ss")#</td>
						<td class="column-categories">#status.getComments()#</td>
					</tr>
				</cfloop>
			</table>
		</div>
		
		<div style="clear:both;"></div>
	</div>
	</div>
</div>		
<cfinclude template="info_sidebar.cfm" />
</cfoutput>