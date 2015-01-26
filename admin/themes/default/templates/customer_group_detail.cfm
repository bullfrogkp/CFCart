<cfoutput>
<section class="content-header">
	<h1>
		Customer Group Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Customer Group Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<form role="form">
					<div class="box-body">
						<div class="form-group">
							<label>Group Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						<div class="form-group">
							<label>Tax Class</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Retailer</option>
								<option value="">Wholesaler</option>
							</select>
						</div>
						<div class="form-group">
							<label>Discount Type</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Type 1</option>
								<option value="">Type 2</option>
							</select>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>