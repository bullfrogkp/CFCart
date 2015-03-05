<cfoutput>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(document).ready(function() {
		$('##reservation').datepicker();
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
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="active"><a href="##tab_1" data-toggle="tab">Activities</a></li>
					<li><a href="##tab_2" data-toggle="tab">Account Information</a></li>
					<li><a href="##tab_3" data-toggle="tab">Orders</a></li>
					<li><a href="##tab_4" data-toggle="tab">Addresses</a></li>
					<li><a href="##tab_5" data-toggle="tab">Reviews</a></li>
					<li><a href="##tab_6" data-toggle="tab">Change Password</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_1">
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
									<cfloop array="#REQUEST.pageData.customer.getShoppingCartProducts()#" index="product">
									<tr>
										<td>#product.getDisplayName()#</td>
										<td>#product.getDescription()#</td>
										<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
									</tr>
									</cfloop>
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
									<cfloop array="#REQUEST.pageData.customer.getBuyLaterProducts()#" index="product">
									<tr>
										<td>#product.getDisplayName()#</td>
										<td>#product.getDescription()#</td>
										<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
									</tr>
									</cfloop>
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
									<cfloop array="#REQUEST.pageData.customer.getWishListProducts()#" index="product">
									<tr>
										<td>#product.getDisplayName()#</td>
										<td>#product.getDescription()#</td>
										<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
									</tr>
									</cfloop>
								</tbody>
							</table>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
						<form role="form">
							<div class="form-group">
								<label>Prefix</label>
								<input type="text" name="prefix" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.prefix#"/>
							</div>
							 <div class="form-group">
								<label>First Name</label>
								<input type="text" name="first_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.firstName#"/>
							</div>
							<div class="form-group">
								<label>Middle Name</label>
								<input type="text" name="middle_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.middleName#"/>
							</div>
							<div class="form-group">
								<label>Last Name</label>
								<input type="text" name="last_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.lastName#"/>
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
									<input type="text" name="date_of_birth" class="form-control pull-right" id="reservation" value="#REQUEST.pageData.formData.dateOfBirth#"/>
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
								<select class="form-control" name="parent_category_id">
									<option value="0">Yes</option>
									<option value="">No</option>
								</select>
							</div>
							 <div class="form-group">
								<label>Status</label>
								<select class="form-control" name="parent_category_id">
									<option value="0">Enabled</option>
									<option value="">Disabled</option>
								</select>
							</div>
							<div class="form-group">
								<label>Comments</label>
								<textarea class="form-control" rows="5" placeholder="Enter ..."></textarea>
							</div>
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
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
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td>123 street</td>
									<td>Toronto</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
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
					<div class="tab-pane" id="tab_4">
						<label>Current Billing Address</label>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>First Name</th>
									<th>Last Name</th>
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
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td>123 street</td>
									<td>Toronto</td>
									<td>Ontario</td>
									<td>L4L 4L4</td>
									<td>Canada</td>
									<td>Billing</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
						</table>
						<label>Current Shipping Address</label>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>First Name</th>
									<th>Last Name</th>
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
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td>123 street</td>
									<td>Toronto</td>
									<td>Ontario</td>
									<td>L4L 4L4</td>
									<td>Canada</td>
									<td>Shipping</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
						</table>
						<label>Inactive Addresses</label>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>First Name</th>
									<th>Last Name</th>
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
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td>123 street</td>
									<td>Toronto</td>
									<td>Ontario</td>
									<td>L4L 4L4</td>
									<td>Canada</td>
									<td>Shipping</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td>123 street</td>
									<td>Toronto</td>
									<td>Ontario</td>
									<td>L4L 4L4</td>
									<td>Canada</td>
									<td>Shipping</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td>123 street</td>
									<td>Toronto</td>
									<td>Ontario</td>
									<td>L4L 4L4</td>
									<td>Canada</td>
									<td>Shipping</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>First Name</th>
									<th>Last Name</th>
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
					<div class="tab-pane" id="tab_5">
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
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
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
					<div class="tab-pane" id="tab_6">
						<form role="form">
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
							<button type="submit" class="btn btn-primary">Change Password</button>
						</form>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Customer</button>
				<button name="delete_item" type="submit" class="btn btn-danger top-nav-button #REQUEST.pageData.deleteButtonClass#">Delete Customer</button>
			</div>
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>