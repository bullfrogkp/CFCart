<section class="content-header">
	<h1>
		Category Detail
		<small>category information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Category Detail</li>
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
					<h3 class="box-title">Category Information</h3>
				</div><!-- /.box-header -->
				
				<!-- form start -->
				<form role="form" method="post">
					<input type="hidden" name="category_id"  value="#REQUEST.category_id#"/>
					<div class="box-body">
						<div class="form-group">
							<label>Category Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="display_name"  value="Computers / Networking"/>
							
						</div>
						<div class="form-group">
							<label>Parent Category</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Root</option>
								<option value="#REQUEST.categories.category_id#">Computers / Networking</option>
							</select>
						</div>
						 <div class="form-group">
							<label>Rank</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="rank" value="1" />
						</div>
						 <div class="form-group">
							<label>Active</label>
							 <select class="form-control" name="active">
								<option value="1">Yes</option>
								<option value="0">No</option>
							</select>
						</div>
					</div><!-- /.box-body -->
					 <div class="box-footer">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
		<div class="col-md-6">
			<!-- general form elements disabled -->
			<div class="box box-warning">
				<div class="box-header">
					<h3 class="box-title">Filters</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<form role="form">
						<!-- text input -->
						<div class="form-group">
							<label>Filter Groups</label>
							 <select class="form-control" name="active">
								<option value="1">Group 1</option>
								<option value="2">Group 2</option>
								<option value="3">Group 3</option>
								<option value="4">Group 4</option>
							</select>
						</div>
						<table class="table table-bordered" style="margin-top:30px;">
							<tr>
								<th>Filter Name</th>
								<th>Filter Values</th>
							</tr>
							<tr>
								<td>Color</td>
								<td>Red,Blue,White,Black</td>
							</tr>
							<tr>
								<td>Size</td>
								<td>Large,Medium,Small</td>
							</tr>
						</table>
					</form>
				</div><!-- /.box-body -->
				 <div class="box-footer">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
			</div><!-- /.box -->
		</div><!--/.col (right) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
