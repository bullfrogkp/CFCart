<cfoutput>
<section class="content-header">
	<h1>
		Order Detail
		<small>order information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Order Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="active"><a href="##tab_1" data-toggle="tab">Address</a></li>
					<li><a href="##tab_2" data-toggle="tab">Status</a></li>
					<li><a href="##tab_3" data-toggle="tab">Products</a></li>
					<li><a href="##tab_4" data-toggle="tab">Transactions</a></li>
					<li><a href="##tab_5" data-toggle="tab">Tracking No.</a></li>
					<li><a href="##tab_6" data-toggle="tab">Refund</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_1">
						<label>Billing Address:</label>
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
								</tr>
							</tbody>
						</table>
						<label>Shipping Address:</label>
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
								</tr>
							</tbody>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Status</th>
									<th>Create Datetime</th>
									<th>End Datetime</th>
									<th>Comment</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Order Placed</td>
									<td>2014 Dec 27 02:15:27</td>
									<td>2014 Dec 27 02:15:27</td>
									<td></td>
								</tr>
								<tr>
									<td>Pending Shipment</td>
									<td>2014 Dec 27 02:15:27</td>
									<td>2015 Jan 02 08:25:02</td>
									<td></td>
								</tr>
								<tr>
									<td>Shipped</td>
									<td>2015 Jan 02 08:25:02</td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
						<div class="form-group">
							<label>Status</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Shipped</option>
								<option value="">Preparing</option>
							</select>
						</div>
						<div class="form-group">
							<label>Comments</label>
							<textarea class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;"></textarea>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
						<form role="form">
							<!-- text input -->
							<div class="form-group">
								<label>Attribute Groups</label>
								 <select class="form-control" name="active">
									<option value="1">Group 1</option>
									<option value="2">Group 2</option>
									<option value="3">Group 3</option>
									<option value="4">Group 4</option>
								</select>
							</div>
							<table class="table table-bordered" style="margin-top:30px;">
								<tr>
									<th>Attribute Name</th>
									<th>Attribute Values</th>
								</tr>
								<tr>
									<td>Color</td>
									<td>Red,Blue,White,Black</td>
								</tr>
								<tr>
									<td>Size</td>
									<td>Large,Medium,Small</td>
								</tr>
							</table>
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>