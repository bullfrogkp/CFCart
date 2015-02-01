<cfoutput>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(document).ready(function() {
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "upload.cfm",

			// Maximum file size
			max_file_size: '1000mb',

			// User can upload no more then 20 files in one go (sets multiple_queues to false)
			max_file_count: 20,
			
			chunk_size: '1mb',

			// Resize images on clientside if we can
			resize : {
				width: 200, 
				height: 200, 
				quality: 90,
				crop: true // crop to exact dimensions
			},

			// Specify what files to browse for
			filters: [
				{ title: "Image files", extensions: "jpg,gif,png" }
			],

			// Rename files by clicking on their titles
			rename: true,
			
			// Sort files
			sortable: true,

			// Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)
			dragdrop: true,

			// Views to activate
			views: {
				thumbs: true,
				list: false,
				active: 'thumbs'
			},

			// Flash settings
			flash_swf_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/flash/Moxie.cdn.swf',

			// Silverlight settings
			silverlight_xap_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/silverlight/Moxie.cdn.xap'
		});
	});
</script>
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
<form method="post">
<input type="hidden" name="category_id" value="1" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="active"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li><a href="##tab_2" data-toggle="tab">Meta Data</a></li>
					<li><a href="##tab_3" data-toggle="tab">Filters</a></li>
					<li><a href="##tab_4" data-toggle="tab">Custom Design</a></li>
					<li><a href="##tab_5" data-toggle="tab">Thumbnail Image</a></li>
					<li><a href="##tab_6" data-toggle="tab">Products</a></li>
				</ul>
				<div class="tab-content">
					
					<div class="tab-pane active" id="tab_1">
						<div class="form-group">
							<label>Category Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="category_display_name"  value="Computers / Networking"/>
						</div>
						<div class="form-group">
							<label>Parent Category</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Root</option>
								<option value="1">Computers / Networking</option>
							</select>
						</div>
						 <div class="form-group">
							<label>Rank</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="rank" value="1" />
						</div>
						 <div class="form-group">
							<label>Status</label>
							 <select class="form-control" name="category_is_enabled">
								<option value="1">Enabled</option>
								<option value="0">Disabled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Show on Navigation</label>
							 <select class="form-control" name="show_category_on_nav">
								<option value="1">Yes</option>
								<option value="0">No</option>
							</select>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
						<div class="form-group">
							<label>Title</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="category_title"  value="Computers / Networking"/>
						</div>
						<div class="form-group">
							<label>Keywords</label>
							<textarea name="category_keywords" class="form-control" rows="3" placeholder="Enter ..."></textarea>
						</div>
						<div class="form-group">
							<label>Description</label>
							<textarea name="category_description" class="form-control" rows="3" placeholder="Enter ..."></textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
						<!-- text input -->
						<div class="form-group">
							<label>Filter Groups</label>
							 <select class="form-control" name="filter_group_id">
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
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_4">
						<div class="form-group">
							<label>Preview</label>
						</div>
						<div class="form-group">
							<label>HTML Code</label>
							<textarea name="category_custom_design" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;"></textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_5">
						<div class="row">
							<div class="col-lg-3 col-md-4 col-xs-6 thumb">
								<a class="thumbnail" href="" target="_blank">
									<img class="img-responsive" src="data:image/jpeg;base64,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" alt="">
								</a>
							</div>
						</div>
						<div class="form-group">
							<div id="uploader">
								<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_6">
						<table id="example2" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Name</th>
									<th>SKU</th>
									<th>Price</th>
									<th>Status</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Computers / Networking</td>
									<td>1</td>
									<td>$100.00</td>
									<td>Enabled</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Computers / Networking</td>
									<td>1</td>
									<td>$100.00</td>
									<td>Enabled</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Computers / Networking</td>
									<td>1</td>
									<td>$100.00</td>
									<td>Enabled</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Computers / Networking</td>
									<td>1</td>
									<td>$100.00</td>
									<td>Enabled</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Computers / Networking</td>
									<td>1</td>
									<td>$100.00</td>
									<td>Enabled</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Computers / Networking</td>
									<td>1</td>
									<td>$100.00</td>
									<td>Enabled</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?category_id=1">View Detail</a></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>Name</th>
									<th>SKU</th>
									<th>Price</th>
									<th>Status</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		
			<div class="form-group">
				<button type="submit" class="btn btn-primary top-nav-button">Save Category</button>
				<button type="submit" class="btn btn-danger top-nav-button">Delete Category</button>
			</div>
		</div><!-- /.col -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>