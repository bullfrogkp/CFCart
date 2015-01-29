<cfoutput>
<section class="content-header">
	<h1>
		Review Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Review Detail</li>
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
							<label>Product <a href="" class="form-link">Computer</a></label>
						</div>
						<div class="form-group">
							<label>Post By <a href="" class="form-link">Kevin Pan (Customer)</a></label>
						</div>
						<div class="form-group">
							<label>Rating</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" checked /> 1 star&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" /> 2 stars&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" /> 3 stars&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" /> 4 stars&nbsp;&nbsp;&nbsp;
							<input type="radio" name="r1" class="minimal" /> 5 stars
						</div>
						<div class="form-group">
							<label>Subject</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea class="form-control" rows="5" placeholder="Enter ..."></textarea>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>