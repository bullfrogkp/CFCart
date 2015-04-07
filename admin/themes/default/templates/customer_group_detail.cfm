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
							<label>Default</label>
							 <select class="form-control" name="is_default">
								<option value="1" <cfif REQUEST.pageData.formData.is_default EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_default EQ FALSE>selected</cfif>>No</option>
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