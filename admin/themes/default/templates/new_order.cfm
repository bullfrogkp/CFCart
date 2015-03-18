<cfoutput>
<section class="content-header">
	<h1>
		New Order
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">New Order</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Customer Information</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>First Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="display_name" value=""/>
					</div>
					<div class="form-group">
						<label>Middle Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="display_name" value=""/>
					</div>
					<div class="form-group">
						<label>Last Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="display_name" value=""/>
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="display_name" value=""/>
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
						<label>Same As Shipping Address</label>
					</div>
				</div><!-- /.box-header -->
				<div class="box-body">
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
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Products</h3>
					<a href="" class="add-filter-value" data-toggle="modal" data-target="##add-product-modal" style="line-height:40px;"><span class="label label-primary">Add Product</span></a>
				</div><!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered table-striped">
						<thead>
							<th>Product</th>
							<th>Price</th>
							<th>Qty</th>
							<th>Shipping</th>
							<th>Subtotal</th>
						</thead>
						<tbody>
							<tr>
								<td>Box</td>
								<td>$1000.00</td>
								<td>1</td>
								<td>1</td>
								<td>$1000.00</td>
							</tr>
							<tr>
								<td>Box</td>
								<td>$1000.00</td>
								<td>1</td>
								<td>1</td>
								<td>$1000.00</td>
							</tr>
							<tr>
								<td>Box</td>
								<td>$1000.00</td>
								<td>1</td>
								<td>1</td>
								<td>$1000.00</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th>Total Product</th>
								<th></th>
								<th>Total Quantity</th>
								<th>Total Shipping</th>
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
		<!-- Left col -->
		<section class="col-lg-12"> 
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
		</section>
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
						<textarea class="form-control" rows="8" placeholder="Enter ..." style="height:170px;"></textarea>
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
					<div class="table-responsive">
						<table class="table">
							<tr>
								<th style="width:50%">Subtotal:</th>
								<td>$250.30</td>
							</tr>
							<tr>
								<th>Shipping & Handling</th>
								<td>$10.34</td>
							</tr>
							<tr>
								<th>Tax (9.3%)</th>
								<td>$10.34</td>
							</tr>
							<tr>
								<th>Shipping:</th>
								<td>$5.80</td>
							</tr>
							<tr>
								<th>Total:</th>
								<td>$265.24</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<button type="submit" class="btn btn-primary">Submit Order</button>
					
</section><!-- /.content -->
<!-- ADD PRODUCT MODAL -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Option</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_filter_value" name="new_filter_value" type="text" class="form-control" placeholder="Option value">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_filter_value" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</cfoutput>