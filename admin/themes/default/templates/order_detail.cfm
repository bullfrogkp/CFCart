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
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Product Name</th>
									<th>Attriubtes</th>
									<th>Price</th>
									<th>Quantity</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Product 1</td>
									<td>Red</td>
									<td>22.22</td>
									<td>2</td>
								</tr>
								<tr>
									<td>Product 1</td>
									<td>Red</td>
									<td>22.22</td>
									<td>2</td>
								</tr>
								<tr>
									<td>Product 1</td>
									<td>Red</td>
									<td>22.22</td>
									<td>2</td>
								</tr>
								<tr>
									<td>Product 1</td>
									<td>Red</td>
									<td>22.22</td>
									<td>2</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="tab-pane" id="tab_4">
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Transaction Type</th>
									<th>Transaction ID</th>
									<th>Create Datetime</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>purchase</td>
									<td>3VE01719SL0474839</td>
									<td>2014 Dec 27 02:15:27</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="tab-pane" id="tab_5">
						<form role="form">
							 <div class="form-group">
								<label>Tracking Number</label>
								<input type="text" class="form-control" placeholder="Enter ..." value=""/>
							</div>
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>
					<div class="tab-pane" id="tab_6">
						<form role="form">
							 <div class="form-group">
								<label>Transaction ID</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="3VE01719SL0474839" disabled/>
							</div>
							<div class="form-group">
								<label>Refund Type</label>
								<select class="form-control" name="parent_category_id">
									<option value="0">Full</option>
									<option value="">Partial</option>
								</select>
							</div>
							<div class="form-group">
								<label>Amount</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="22.22" />
							</div>
							<div class="form-group">
								<label>Memo</label>
								<textarea class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;"></textarea>
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