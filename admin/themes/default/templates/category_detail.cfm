<cfoutput>

<script>
	$(document).ready(function() {
	
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
	
		CKEDITOR.replace('custom_design');
		$("##products_table").dataTable();
		
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlWeb#admin/ajax/upload_category_images.cfm",

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
		
		var filtergroups = new Object();
		var filtergroup, filter, key;
		
		<cfloop array="#REQUEST.pageData.filterGroups#" index="fg">
			
			key = 'filter_group_' + '#fg.getFilterGroupId()#';
			
			filters = new Array();
			
			<cfloop array="#fg.getFilters()#" index="f">
				filter = new Object();
				filter.name = '#f.getDisplayName()#';
				filters.push(filter);
			</cfloop>
			
			filtergroups[key] = filters;
		</cfloop>
		
		$( "##filter_group" ).change(function() {
		
			$('##filter').empty();
		
			$("##filter_group option:selected").each(function() {
				current_key = 'filter_group_' + $(this).val();
				
				for(var i=0;i<filtergroups[current_key].length;i++)
				{
					$('##filter').append($('<option></option>').html(filtergroups[current_key][i].name)); 
				}
			});
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
<input type="hidden" name="category_id" id="category_id" value="#REQUEST.pageData.category.getCategoryId()#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.activeTabId#" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message")>
				<div class="alert #REQUEST.pageData.message_type# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					#REQUEST.pageData.message#
				</div>
			</cfif>
		</div>
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Meta Data</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Filters</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Custom Design</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_5']#" tabid="tab_5"><a href="##tab_5" data-toggle="tab">Thumbnail Image</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_6']#" tabid="tab_6"><a href="##tab_6" data-toggle="tab">Products</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						<div class="form-group">
							<label>Category Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="display_name" value="#REQUEST.pageData.formData.display_name#"/>
						</div>
						<div class="form-group">
							<label>Parent Category</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Root</option>
								<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
									<option value="#cat.getCategoryId()#"
									<cfif REQUEST.pageData.formData.parent_category_id EQ cat.getCategoryId()>
									selected
									</cfif>
									>#RepeatString("&nbsp;",10)##cat.getDisplayName()#</option>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<option value="#subCat.getCategoryId()#"
										<cfif REQUEST.pageData.formData.parent_category_id EQ subCat.getCategoryId()>
										selected
										</cfif>
										>#RepeatString("&nbsp;",20)##subCat.getDisplayName()#</option>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<option value="#thirdCat.getCategoryId()#"
											<cfif REQUEST.pageData.formData.parent_category_id EQ thirdCat.getCategoryId()>
											selected
											</cfif>
											>#RepeatString("&nbsp;",30)##thirdCat.getDisplayName()#</option>
										</cfloop>
										</li>
									</cfloop>
									</li>
								</cfloop>
							</select>
						</div>
						 <div class="form-group">
							<label>Rank</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="rank" value="#REQUEST.pageData.formData.rank#" />
						</div>
						 <div class="form-group">
							<label>Status</label>
							 <select class="form-control" name="is_enabled">
								<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ TRUE>selected</cfif>>Enabled</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ FALSE>selected</cfif>>Disabled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Show on Navigation</label>
							 <select class="form-control" name="show_category_on_navigation">
								<option value="1" <cfif REQUEST.pageData.formData.show_category_on_navigation EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.show_category_on_navigation EQ FALSE>selected</cfif>>No</option>
							</select>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
						<div class="form-group">
							<label>Title</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="title" value="#REQUEST.pageData.formData.title#"/>
						</div>
						<div class="form-group">
							<label>Keywords</label>
							<textarea name="keywords" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.keywords#</textarea>
						</div>
						<div class="form-group">
							<label>Description</label>
							<textarea name="description" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
					
						<div class="row">
							<div class="col-md-4">
								<select class="form-control" name="filter_group_id" id="filter_group" multiple>
									<cfloop array="#REQUEST.pageData.filterGroups#" index="fg">
										<option value="#fg.getFilterGroupId()#"
										<cfif fg.getFilterGroupId() EQ REQUEST.pageData.formData.filter_group_id>
										selected
										</cfif>
										>#fg.getDisplayName()#</option>
									</cfloop>
								</select>
							</div>
							<div class="col-md-8">
								<select class="form-control" name="filter" id="filter" multiple>
									<cfif IsDefined("REQUEST.pageData.filterGroup")>
										<cfloop array="#REQUEST.pageData.filterGroup.getFilters()#" index="f">
											<option value="#f.getFilterId()#">#f.getDisplayName()#</option>
										</cfloop>
									</cfif>
								</select>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="form-group">
							<label>HTML Code</label>
							<textarea name="custom_design" id="custom_design" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.custom_design#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_5']#" id="tab_5">
						<div class="row">
							<cfif NOT IsNULL(REQUEST.pageData.category.getImages())>
								<cfloop array="#REQUEST.pageData.category.getImages()#" index="img">
									<div class="col-lg-3 col-md-4 col-xs-6 thumb">
										<a class="thumbnail" href="#APPLICATION.absoluteUrlWeb#admin/uploads/category/#REQUEST.pageData.category.getCategoryId()#/#img.getName()#" target="_blank">
											<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#admin/uploads/category/#REQUEST.pageData.category.getCategoryId()#/#img.getName()#" />
										</a>
									</div>
								</cfloop>
							</cfif>
						</div>
						<div class="form-group">
							<div id="uploader">
								<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_6']#" id="tab_6">
						<div class="row">
							<div class="col-xs-12">
								<div class="box">
									<div class="box-body table-responsive">
										<table id="products_table" class="table table-bordered table-striped">
											<thead>
												<tr>
													<th>Name</th>
													<th>Price</th>
													<th>Create Datetime</th>
													<th>SKU</th>
													<th>Status</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<cfif NOT IsNull(REQUEST.pageData.category.getProducts())>
													<cfloop array="#REQUEST.pageData.category.getProducts()#" index="product">
														<tr>
															<td>#product.getDisplayName()#</td>
															<td>#product.getPrice()#</td>
															<td>#DateFormat(product.getCreatedDatetime(),"mmm dd,yyyy")#</td>
															<td>#product.getSku()#</td>
															<td>#product.getIsEnabled()#</td>
															<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
														</tr>
													</cfloop>
												</cfif>
											</tbody>
											<tfoot>
												<tr>
													<th>Name</th>
													<th>Price</th>
													<th>Create Datetime</th>
													<th>SKU</th>
													<th>Status</th>
													<th>Action</th>
												</tr>
											</tfoot>
										</table>
									</div><!-- /.box-body -->
								</div><!-- /.box -->
							</div>
						</div>
					</div><!-- /.tab-pane -->
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		
			<div class="form-group">
				<button name="save_category" type="submit" class="btn btn-primary top-nav-button">Save Category</button>
				<button name="delete_category" type="submit" class="btn btn-danger top-nav-button #REQUEST.pageData.deleteButtonClass#">Delete Category</button>
			</div>
		</div><!-- /.col -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>