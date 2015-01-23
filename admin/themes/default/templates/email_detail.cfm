<section class="content-header">
	<h1>
		Email Detail
		<small>email information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Email Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-6">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Contact Information</h3>
				</div><!-- /.box-header -->
				<!-- form start -->
				<form role="form">
					<div class="box-body">
						<div class="form-group">
							<label>Category Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.category_name#"/>
						</div>
						 <div class="form-group">
							<label>Company Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.company_name#"/>
						</div>
						 <div class="form-group">
							<label>Company Address</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.company_address#"/>
						</div>
						 <div class="form-group">
							<label>Phone</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.phone#"/>
						</div>
						 <div class="form-group">
							<label>Email</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.email#"/>
						</div>
						 <div class="form-group">
							<label>QQ</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.qq#"/>
						</div>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->

			<!-- Form Element sizes -->
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">Beneficiary Information</h3>
				</div>
				<div class="box-body">
					<form role="form">
						<!-- text input -->
						<div class="form-group">
							<label>Beneficiary Account</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.beneficiary_account#"/>
						</div>
						<div class="form-group">
							<label>Beneficiary Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.beneficiary_name#"/>
						</div>
						<div class="form-group">
							<label>Beneficiary Bank</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.beneficiary_bank#"/>
						</div>
						<div class="form-group">
							<label>Beneficiary Bank Address</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.beneficiary_bank_address#"/>
						</div>
						<div class="form-group">
							<label>SWIFT Code</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.beneficiary_swift_code#"/>
						</div>
					</form>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
		<!-- right column -->
		<div class="col-md-6">
			<!-- general form elements disabled -->
			<div class="box box-warning">
				<div class="box-header">
					<h3 class="box-title">Product Information</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<form role="form">
						<!-- text input -->
						<div class="form-group">
							<label>Product Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.product_name#"/>
						</div>
						<div class="form-group">
							<label>Product Description</label>
							<textarea class="form-control" rows="3" placeholder="Enter ...">#REQUEST.product_description#</textarea>
						</div>
						 <div class="form-group">
							<label>Production Time</label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.production_time#"/>
						</div>
						 <div class="form-group">
							<label>Dimensions </label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.dimensions#"/>
						</div>
						 <div class="form-group">
							<label>Weight </label>
							<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.weight#"/>
						</div>
						<table class="table table-bordered" style="margin-top:30px;">
							<tr>
								<th style="width: 10px">##</th>
								<th>Piece</th>
								<th>Color</th>
								<th>Side</th>
								<th>Logo</th>
								<th>Price</th>
							</tr>
							
								<tr>
									<td>#REQUEST.products.currentRow#</td>
									<td>#REQUEST.products.piece#</td>
									<td>#REQUEST.products.color#</td>
									<td>#REQUEST.products.side#</td>
									<td>#REQUEST.products.logo#</td>
									<td>#REQUEST.products.price#</td>
								</tr>
							
						</table>
						
						<div class="row" style="margin-top:30px;">
							
								<div class="col-lg-3 col-md-4 col-xs-6 thumb">
									<a class="thumbnail" href="#APPLICATION.absolute_url_image_uploads##REQUEST.images.name#" target="_blank">
										<img class="img-responsive" src="#APPLICATION.absolute_url_image_uploads##REQUEST.images.name#" alt="">
									</a>
								</div>
						</div>
					</form>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (right) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->