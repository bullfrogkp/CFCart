<cfoutput>
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
					<li class="active"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li><a href="##tab_2" data-toggle="tab">Addresses</a></li>
					<li><a href="##tab_3" data-toggle="tab">Reset Password</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_1">
						<form role="form">
							 <div class="form-group">
								<label>Name</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="Kevin Pan"/>
							</div>
							 <div class="form-group">
								<label>Email</label>
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
								<textarea class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;"></textarea>
							</div>
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
						<label>Current Billing Address:</label>
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
						<label>Current Shipping Address:</label>
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
						Inactive Addresses:
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
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
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
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>