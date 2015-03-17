<cfoutput>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(document).ready(function() {
		$('##reservation').datepicker();
		
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		Customer Detail
		<small>customer information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Customer Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.customer.getCustomerId()#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">Activities</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Account Information</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Orders</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Addresses</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_5']#" tabid="tab_5"><a href="##tab_5" data-toggle="tab">Reviews</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_6']#" tabid="tab_6"><a href="##tab_6" data-toggle="tab">Change Password</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						 <div class="form-group">
							<label>Last Logged In Time</label>
							<input disabled type="text" class="form-control" value="#REQUEST.pageData.formData.last_login_datetime#"/>
						</div>
						 <div class="form-group">
							<label>Last Logged In IP Address</label>
							<input disabled type="text" class="form-control" value="#REQUEST.pageData.formData.last_login_ip#"/>
						</div>
						 <div class="form-group">
							<label>Account Created Time</label>
							<input disabled type="text" class="form-control" value="#REQUEST.pageData.formData.created_datetime#"/>
						</div>
						 <div class="form-group">
							<label>Account Created IP Address</label>
							<input disabled type="text" class="form-control" value="#REQUEST.pageData.formData.created_user#"/>
						</div>
						<div class="form-group">
							<label>Shopping Cart</label>
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Product</th>
										<th>Description</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<cfif NOT IsNull(REQUEST.pageData.customer.getShoppingCartProducts()) AND ArrayLen(REQUEST.pageData.customer.getShoppingCartProducts()) NEQ 0>
										<cfloop array="#REQUEST.pageData.customer.getShoppingCartProducts()#" index="product">
										<tr>
											<td>#product.getDisplayName()#</td>
											<td>#product.getDescription()#</td>
											<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
										</tr>
										</cfloop>
									<cfelse>
										<tr>
											<td colspan="3">No result found</td>
										</tr>
									</cfif>
								</tbody>
							</table>
						</div>
						<div class="form-group">
							<label>Buy Later</label>
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Product</th>
										<th>Description</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<cfif NOT IsNull(REQUEST.pageData.customer.getBuyLaterProducts()) AND ArrayLen(REQUEST.pageData.customer.getBuyLaterProducts()) NEQ 0>
										<cfloop array="#REQUEST.pageData.customer.getBuyLaterProducts()#" index="product">
											<tr>
												<td>#product.getDisplayName()#</td>
												<td>#product.getDescription()#</td>
												<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
											</tr>
										</cfloop>
									<cfelse>
										<tr>
											<td colspan="3">No result found</td>
										</tr>
									</cfif>
								</tbody>
							</table>
						</div>
						
						<div class="form-group">
							<label>Wishlist</label>
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Product</th>
										<th>Description</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<cfif NOT IsNull(REQUEST.pageData.customer.getWishListProducts()) AND ArrayLen(REQUEST.pageData.customer.getWishListProducts()) NEQ 0>
										<cfloop array="#REQUEST.pageData.customer.getWishListProducts()#" index="product">
											<tr>
												<td>#product.getDisplayName()#</td>
												<td>#product.getDescription()#</td>
												<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
											</tr>
										</cfloop>
									<cfelse>
										<tr>
											<td colspan="3">No result found</td>
										</tr>
									</cfif>
								</tbody>
							</table>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
					
						<div class="form-group">
							<label>Prefix</label>
							<input type="text" name="prefix" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.prefix#"/>
						</div>
						 <div class="form-group">
							<label>First Name</label>
							<input type="text" name="first_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.first_name#"/>
						</div>
						<div class="form-group">
							<label>Middle Name</label>
							<input type="text" name="middle_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.middle_name#"/>
						</div>
						<div class="form-group">
							<label>Last Name</label>
							<input type="text" name="last_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.last_name#"/>
						</div>
						<div class="form-group">
							<label>Suffix</label>
							<input type="text" name="suffix" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.suffix#"/>
						</div>
						 <div class="form-group">
							<label>Date of Birth</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" name="date_of_birth" class="form-control pull-right" id="reservation" value="#REQUEST.pageData.formData.date_of_birth#"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<div class="form-group">
							<label>Gender</label>
							<select class="form-control" name="gender">
								<option value="">Please Select...</option>
								<option value="Male" <cfif REQUEST.pageData.formData.gender EQ "Male">selected</cfif>>Male</option>
								<option value="Female" <cfif REQUEST.pageData.formData.gender EQ "Female">selected</cfif>>Female</option>
							</select>
						</div>
						 <div class="form-group">
							<label>Email</label>
							<input type="text" name="email" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.email#"/>
						</div>
						<div class="form-group">
							<label>Website</label>
							<input type="text" name="website" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.website#"/>
						</div>
						 <div class="form-group">
							<label>Customer Group</label>
							<select class="form-control" name="customer_group_id">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
								<option value="#group.getCustomerGroupId()#">#group.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						 <div class="form-group">
							<label>Subscribed</label>
							<select class="form-control" name="subscribed">
								<option value="1" <cfif REQUEST.pageData.formData.subscribed EQ 1>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.subscribed NEQ 1>selected</cfif>>No</option>
							</select>
						</div>
						 <div class="form-group">
							<label>Status</label>
							<select class="form-control" name="is_enabled">
								<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ 1>selected</cfif>>Enabled</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ 0>selected</cfif>>Disabled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Comments</label>
							<textarea class="form-control" rows="5" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Order No.</th>
									<th>Purchase On</th>
									<th>Bill To</th>
									<th>Ship To</th>
									<th>Total</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.customer.getOrders()) AND ArrayLen(REQUEST.pageData.customer.getOrders()) NEQ 0>
									<cfloop array="#REQUEST.pageData.customer.getOrders()#" index="order">
										<tr>
											<td>#order.getTrackingNumber()#</td>
											<td>#order.getCreatedDatetime()#</td>
											<td>#order.getBillingFirstName()# #order.getBillingMiddleName()# #order.getBillingLastName()#</td>
											<td>#order.getShippingFirstName()# #order.getShippingMiddleName()# #order.getShippingLastName()#</td>
											<td>#order.getTotal()#</td>
											<td><a href="#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?id=#order.getOrderId()#">View Detail</a></td>
										</tr>
									</cfloop>
								<cfelse>
									<tr>
										<td colspan="6">No result found</td>
									</tr>
								</cfif>
							</tbody>
							<tfoot>
								<tr>
									<th>Order No.</th>
									<th>Purchase On</th>
									<th>Bill To</th>
									<th>Ship To</th>
									<th>Total</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<label>Current Billing Address</label>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Name</th>
									<th>Phone</th>
									<th>Street</th>
									<th>City</th>
									<th>Province</th>
									<th>Postal Code</th>
									<th>Country</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.currentBillingAddress)>
									<tr>
									<td>#REQUEST.pageData.currentBillingAddress.getFirstName()# #REQUEST.pageData.currentBillingAddress.getMiddleName()# #REQUEST.pageData.currentBillingAddress.getLastName()#</td>
									<td>#REQUEST.pageData.currentBillingAddress.getPhone()#</td>
									<td>#REQUEST.pageData.currentBillingAddress.getStreet()#</td>
									<td>#REQUEST.pageData.currentBillingAddress.getCity()#</td>
									<td>#REQUEST.pageData.currentBillingAddress.getProvince().getDisplayName()#</td>
									<td>#REQUEST.pageData.currentBillingAddress.getPostalCode()#</td>
									<td>#REQUEST.pageData.currentBillingAddress.getCountry().getDisplayName()#</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?id=#REQUEST.pageData.currentBillingAddress.getAddressId()#">View Detail</a></td>
								</tr>
								<cfelse>
									<tr>
										<td colspan="8">No result found</td>
									</tr>
								</cfif>
							</tbody>
						</table>
						<label>Current Shipping Address</label>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Name</th>
									<th>Phone</th>
									<th>Street</th>
									<th>City</th>
									<th>Province</th>
									<th>Postal Code</th>
									<th>Country</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.currentShippingAddress)>
									<tr>
										<td>#REQUEST.pageData.currentShippingAddress.getFirstName()# #REQUEST.pageData.currentShippingAddress.getMiddleName()# #REQUEST.pageData.currentShippingAddress.getLastName()#</td>
										<td>#REQUEST.pageData.currentShippingAddress.getPhone()#</td>
										<td>#REQUEST.pageData.currentShippingAddress.getStreet()#</td>
										<td>#REQUEST.pageData.currentShippingAddress.getCity()#</td>
										<td>#REQUEST.pageData.currentShippingAddress.getProvince().getDisplayName()#</td>
										<td>#REQUEST.pageData.currentShippingAddress.getPostalCode()#</td>
										<td>#REQUEST.pageData.currentShippingAddress.getCountry().getDisplayName()#</td>
										<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?id=#REQUEST.pageData.currentShippingAddress.getAddressId()#">View Detail</a></td>
									</tr>
								<cfelse>
									<tr>
										<td colspan="8">No result found</td>
									</tr>
								</cfif>
							</tbody>
						</table>
						<label>Inactive Addresses</label>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Name</th>
									<th>Phone</th>
									<th>Street</th>
									<th>City</th>
									<th>Province</th>
									<th>Postal Code</th>
									<th>Country</th>
									<th>Type</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.inactiveAddresses) AND ArrayLen(REQUEST.pageData.inactiveAddresses) NEQ 0>
									<cfloop array="#REQUEST.pageData.inactiveAddresses#" index="address">
										<tr>
											<td>#address.getFirstName()# #address.getMiddleName()# #address.getLastName()#</td>
											<td>#address.getPhone()#</td>
											<td>#address.getStreet()#</td>
											<td>#address.getCity()#</td>
											<td>#address.getProvince().getDisplayName()#</td>
											<td>#address.getPostalCode()#</td>
											<td>#address.getCountry().getDisplayName()#</td>
											<td>#address.getAddressType()#</td>
											<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?id=#address.getAddressId()#">View Detail</a></td>
										</tr>
									</cfloop>
								<cfelse>
									<tr>
										<td colspan="9">No result found</td>
									</tr>
								</cfif>
							</tbody>
							<tfoot>
								<tr>
									<th>Name</th>
									<th>Phone</th>
									<th>Street</th>
									<th>City</th>
									<th>Province</th>
									<th>Postal Code</th>
									<th>Country</th>
									<th>Type</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_5']#" id="tab_5">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Subject</th>
									<th>Message</th>
									<th>Rating</th>
									<th>Create Datetime</th>
									<th>Create User</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.customer.getReviews()) AND ArrayLen(REQUEST.pageData.customer.getReviews()) NEQ 0>
									<cfloop array="#REQUEST.pageData.customer.getReviews()#" index="review">
										<tr>
											<td>#review.getSubject()#</td>
											<td>#review.getMessage()#</td>
											<td>#review.getRating()#</td>
											<td>#review.getCreatedDatetime()#</td>
											<td>#review.getCreatedUser()#</td>
											<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?id=#review.getReviewId()#">View Detail</a></td>
										</tr>
									</cfloop>
								<cfelse>
									<tr>
										<td colspan="6">No result found</td>
									</tr>
								</cfif>
							</tbody>
							<tfoot>
								<tr>
									<th>Subject</th>
									<th>Message</th>
									<th>Rating</th>
									<th>Create Datetime</th>
									<th>Create User</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_6']#" id="tab_6">
						 <div class="form-group">
							<label>Current Password</label>
							<input type="password" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>New Password</label>
							<input type="password" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						  <div class="form-group">
							<label>Confirm New Password</label>
							<input type="password" class="form-control" placeholder="Enter ..." value=""/>
						</div>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Customer</button>
				<button name="add_order" type="submit" class="btn btn-primary top-nav-button">Add Order</button>
				<button name="delete_item" type="submit" class="btn btn-danger pull-right top-nav-button #REQUEST.pageData.deleteButtonClass#">Delete Customer</button>
			</div>
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>