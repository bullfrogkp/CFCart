<cfoutput>
<section class="content-header">
	<h1>
		Site Information
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Site Info</li>
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
							<label>Street Address</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>City</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						<div class="form-group">
							<label>Province</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Ontario</option>
								<option value="">Alberta</option>
							</select>
						</div>
						<div class="form-group">
							<label>Postal Code</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						<div class="form-group">
							<label>Country</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Canada</option>
								<option value="">US</option>
							</select>
						</div>
						<div class="form-group">
							<label>Map</label>
							<textarea class="form-control" rows="6" placeholder="Enter ..."></textarea>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>