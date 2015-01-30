<cfoutput>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		Dashboard
		<small>Control panel</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Dashboard</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">

	<!-- Small boxes (Stat box) -->
	<div class="row">
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-aqua">
				<div class="inner">
					<h3>
						150
					</h3>
					<p>
						New Orders
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-bag"></i>
				</div>
				<a href="##" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-green">
				<div class="inner">
					<h3>
						53
					</h3>
					<p>
						New Reviews
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-stats-bars"></i>
				</div>
				<a href="##" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-yellow">
				<div class="inner">
					<h3>
						44
					</h3>
					<p>
						User Registrations
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-person-add"></i>
				</div>
				<a href="##" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-red">
				<div class="inner">
					<h3>
						65
					</h3>
					<p>
						Unique Visitors
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-pie-graph"></i>
				</div>
				<a href="##" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
	</div><!-- /.row -->

	<!-- Main row -->
	<div class="row">
		<section class="col-lg-12">
			<!-- Custom tabs (Charts with tabs)-->
			<div class="nav-tabs-custom">
				<!-- Tabs within a box -->
				<ul class="nav nav-tabs pull-right">
					<li class="active"><a href="##revenue-chart" data-toggle="tab">Visitors</a></li>
					<li><a href="##revenue-chart" data-toggle="tab">Sales</a></li>
					<li class="pull-left header">Trends</li>
				</ul>
				<div class="tab-content no-padding">
					<!-- Morris chart - Sales -->
					<div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 300px;"></div>
					<div class="chart tab-pane" id="sales-chart" style="position: relative; height: 300px;"></div>
				</div>
			</div><!-- /.nav-tabs-custom -->
		</section>
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-danger">
				<div class="box-header">
					<h3 class="box-title">Last 5 Orders</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Customer</th>
							<th>Items</th>
							<th>Grand Total</th>
							<th></th>
						</tr>
						<tr>
							<td>Kevin</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/order_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Kevin</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/order_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Kevin</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/order_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Kevin</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/order_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Kevin</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/order_detail.cfm">Detail</a></td>
						</tr>
					</table>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">Last 5 Reviews</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Product</th>
							<th>Review</th>
							<th></th>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/review_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/review_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/review_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/review_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/review_detail.cfm">Detail</a></td>
						</tr>
					</table>
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
					<h3 class="box-title">Bestsellers</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Product</th>
							<th>Information</th>
							<th>Sold</th>
							<th></th>
						</tr>
						<tr>
							<td>Box</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Box</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Box</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Box</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>Box</td>
							<td>Red,Blue,White,Black</td>
							<td>$1000.00</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
					</table>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-warning">
				<div class="box-header">
					<h3 class="box-title">Most Viewed Products</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Product</th>
							<th>Viewed</th>
							<th></th>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
						<tr>
							<td>New Product</td>
							<td>Red,Blue,White,Black</td>
							<td><a href="#APPLICATION.absolute_url_web#admin/product_detail.cfm">Detail</a></td>
						</tr>
					</table>
				</div>
			</div>
			<!-- /.box -->

		</section><!-- right col -->
	</div><!-- /.row (main row) -->
</section><!-- /.content -->
</cfoutput>
