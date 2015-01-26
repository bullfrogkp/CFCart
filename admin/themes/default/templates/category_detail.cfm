<cfoutput>
<section class="content-header">
	<h1>
		Category Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Category Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="active"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li><a href="##tab_2" data-toggle="tab">Filters</a></li>
					<li><a href="##tab_3" data-toggle="tab">Custom Design</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_1">
						<form role="form" method="post">
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
								<label>Title</label>
								<input type="text" class="form-control" placeholder="Enter ..." name="display_name"  value="Computers / Networking"/>
							</div>
							<div class="form-group">
								<label>Keywords</label>
								<textarea class="form-control" rows="3" placeholder="Enter ..."></textarea>
							</div>
							<div class="form-group">
								<label>Description</label>
								<textarea class="form-control" rows="3" placeholder="Enter ..."></textarea>
							</div>
							 <div class="form-group">
								<label>Status</label>
								 <select class="form-control" name="active">
									<option value="1">Enabled</option>
									<option value="0">Disabled</option>
								</select>
							</div>
							<div class="form-group">
								<label>Show on Navigation</label>
								 <select class="form-control" name="active">
									<option value="1">Yes</option>
									<option value="0">No</option>
								</select>
							</div>
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
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
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
						<form role="form">
							<div class="form-group">
								<label>Preview</label>
							</div>
							<div class="form-group">
								<label>HTML Code</label>
								<textarea class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;"></textarea>
							</div>
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					
					</div><!-- /.tab-pane -->
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>