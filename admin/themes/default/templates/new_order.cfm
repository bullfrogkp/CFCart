<cfoutput>
<section class="content-header">
	<h1>
		Order Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Order Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Items Ordered</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered table-striped">
						<thead>
							<th>Product</th>
							<th>Price</th>
							<th>Qty</th>
							<th>Subtotal</th>
						</thead>
						<tbody>
							<tr>
								<td>Box</td>
								<td>$1000.00</td>
								<td>1</td>
								<td>$1000.00</td>
							</tr>
							<tr>
								<td>Box</td>
								<td>$1000.00</td>
								<td>1</td>
								<td>$1000.00</td>
							</tr>
							<tr>
								<td>Box</td>
								<td>$1000.00</td>
								<td>1</td>
								<td>$1000.00</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th>Total Product</th>
								<th></th>
								<th>Total Quantity</th>
								<th>Subtotal</th>
							</tr>
						</tfoot>
					</table>
				</div>
			</div><!-- /.box (chat box) -->   
		</section>
	</div><!-- /.row (main row) -->
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Coupon Code</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Enter ..." value="3VE01719SL0474839" />
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Account Information</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Group</label>
						<select class="form-control" name="parent_category_id">
							<option value="0">Shipped</option>
							<option value="">Preparing</option>
						</select>
					</div>
					<div class="form-group">
						<label>Email</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="3VE01719SL0474839" />
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section>
	</div><!-- /.row (main row) -->
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Billing Address</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Prefix</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>First Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Middle Name/Initial</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Last Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Suffix</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Company</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Street Address</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>City</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Country</label>
						<select class="form-control" name="parent_category_id">
							<option value="0">Canada</option>
							<option value="">US</option>
						</select>
					</div>
					<div class="form-group">
						<label>State/Province</label>
						<select class="form-control" name="parent_category_id">
							<option value="0">Ontario</option>
							<option value="">Alberta</option>
						</select>
					</div>
					<div class="form-group">
						<label>Zip/Postal Code</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Fax</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Shipping Address</h3>
					<div class="form-group pull-right" style="margin:10px 10px 0 0;">
						<input type="checkbox" class="form-control" checked />
						<label>Same As Billing Address</label>
					</div>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Prefix</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>First Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Middle Name/Initial</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Last Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Suffix</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Company</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Street Address</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>City</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Country</label>
						<select class="form-control" name="parent_category_id">
							<option value="0">Canada</option>
							<option value="">US</option>
						</select>
					</div>
					<div class="form-group">
						<label>State/Province</label>
						<select class="form-control" name="parent_category_id">
							<option value="0">Ontario</option>
							<option value="">Alberta</option>
						</select>
					</div>
					<div class="form-group">
						<label>Zip/Postal Code</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
					<div class="form-group">
						<label>Fax</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="" />
					</div>
				</div>
			</div>
			<!-- /.box -->

		</section><!-- right col -->
	</div><!-- /.row (main row) -->

	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Payment Method</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<select class="form-control" name="parent_category_id">
							<option value="0">Check / Money order</option>
							<option value=""> Credit Card (saved)</option>
						</select>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Shipping Method</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<select class="form-control" name="parent_category_id">
							<option value="0">Flat Rate</option>
							<option value="">Express</option>
						</select>
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Comments</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<textarea class="form-control" rows="8" placeholder="Enter ..."></textarea>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Order Totals</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Subtotal</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
					</div>
					<div class="form-group">
						<label>Grand Total</label>
						<input type="text" class="form-control" placeholder="Enter ..." value="$100.00" disabled />
					</div>
					<button type="submit" class="btn btn-primary">Submit Order</button>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
</section><!-- /.content -->
</cfoutput>