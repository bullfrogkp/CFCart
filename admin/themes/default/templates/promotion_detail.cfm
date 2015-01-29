<cfoutput>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(document).ready(function() {
		$('##from_date').datepicker();
		$('##to_date').datepicker();
	});
</script>
<section class="content-header">
	<h1>
		Promotion Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Promotion Detail</li>
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
							<label>Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						<div class="form-group">
							<label>Description</label>
							<textarea class="form-control" rows="5" placeholder="Enter ..."></textarea>
						</div>
						<div class="form-group">
							<label>Status</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Pending</option>
								<option value="">Approved</option>
							</select>
						</div>
						<div class="form-group">
							<label>Customer Groups</label>
							<select multiple class="form-control" name="parent_category_id">
								<option value="0">Retailer</option>
								<option value="">Wholeseller</option>
							</select>
						</div>
						 <div class="form-group">
							<label>From Date</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right" id="from_date"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						 <div class="form-group">
							<label>To Date</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right" id="to_date"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>