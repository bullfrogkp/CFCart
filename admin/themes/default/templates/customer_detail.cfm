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
					<li><a href="##tab_5" data-toggle="tab">Shopping Cart</a></li>
					<li><a href="##tab_6" data-toggle="tab">Wishlist</a></li>
					<li><a href="##tab_7" data-toggle="tab">Reviews</a></li>
					<li><a href="##tab_8" data-toggle="tab">Newsletters</a></li>
					<li><a href="##tab_9" data-toggle="tab">Change Password</a></li>
					<li class="pull-right"><button type="submit" class="btn btn-danger pull-right" style="margin-top:2px;">Delete User</button></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_1">
						 <div class="form-group">
							<label>Last Logged In Time</label>
							<input disabled type="text" class="form-control" placeholder="Enter ..." value="27 Jan 2015 07:05:49"/>
						</div>
						 <div class="form-group">
							<label>Last Logged In IP Address</label>
							<input disabled type="text" class="form-control" placeholder="Enter ..." value="65.57.67.112"/>
						</div>
						 <div class="form-group">
							<label>Account Created Time</label>
							<input disabled type="text" class="form-control" placeholder="Enter ..." value="27 Jan 2015 07:05:49"/>
						</div>
						 <div class="form-group">
							<label>Account Created IP Address</label>
							<input disabled type="text" class="form-control" placeholder="Enter ..." value="65.57.67.112"/>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
						<form role="form">
							<div class="form-group">
								<label>Prefix</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="Kevin Pan"/>
							</div>
							 <div class="form-group">
								<label>First Name</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="Kevin Pan"/>
							</div>
							<div class="form-group">
								<label>Middle Name</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="Kevin Pan"/>
							</div>
							<div class="form-group">
								<label>Last Name</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="Kevin Pan"/>
							</div>
							<div class="form-group">
								<label>Suffix</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="Kevin Pan"/>
							</div>
							 <div class="form-group">
								<label>Date of Birth</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right" id="reservation"/>
								</div><!-- /.input group -->
							</div><!-- /.form group -->
							<div class="form-group">
								<label>Gender</label>
								<select class="form-control" name="parent_category_id">
									<option value="0">Male</option>
									<option value="">Female</option>
								</select>
							</div>
							 <div class="form-group">
								<label>Email</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="kp@kp.ca"/>
							</div>
							<div class="form-group">
								<label>Website</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="kp@kp.ca"/>
							</div>
							 <div class="form-group">
								<label>Customer Group</label>
								<select class="form-control" name="parent_category_id">
									<option value="0">Retailer</option>
									<option value="">Wholesaler</option>
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
							<button type="submit" class="btn btn-primary">Save</button>
						</form>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
						<table id="example2" class="table table-bordered table-striped">
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
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
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
						<table id="example2" class="table table-bordered table-striped">
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
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
						</table>
						<label>Current Shipping Address</label>
						<table id="example2" class="table table-bordered table-striped">
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
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
						</table>
						<label>Inactive Addresses</label>
						<table id="example2" class="table table-bordered table-striped">
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
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
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
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
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
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
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
						<label>Shopping Cart</label>
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Product</th>
									<th>Information</th>
									<th>Quantity</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>Product</th>
									<th>Information</th>
									<th>Quantity</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
						<label>Buy Later</label>
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Product</th>
									<th>Information</th>
									<th>Quantity</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>Product</th>
									<th>Information</th>
									<th>Quantity</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_6">
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Product</th>
									<th>Information</th>
									<th>Quantity</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>Product</th>
									<th>Information</th>
									<th>Quantity</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_7">
						<table id="example2" class="table table-bordered table-striped">
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
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
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
					<div class="tab-pane" id="tab_8">
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Name</th>
									<th>Subscribe Datetime</th>
									<th>Subscribe User</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Kevin</td>
									<td>Pan</td>
									<td>4166666666</td>
									<td><a href="#APPLICATION.absolute_url_web#admin/address_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>Name</th>
									<th>Subscribe Datetime</th>
									<th>Subscribe User</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_9">
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
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>