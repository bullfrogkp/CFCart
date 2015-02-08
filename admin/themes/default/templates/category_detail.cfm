<cfoutput>

<script>
	$(document).ready(function() {
		CKEDITOR.replace('category_custom_design');
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
				filter.name = '#f.getFilterDisplayName()#';
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
<input type="hidden" name="category_id" value="#REQUEST.pageData.category.getCategoryId()#" />
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
							<input type="text" class="form-control" placeholder="Enter ..." name="category_display_name" value="#REQUEST.pageData.category.getCategoryDisplayName()#"/>
						</div>
						<div class="form-group">
							<label>Parent Category</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Root</option>
								<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
									<option value="#cat.getCategoryId()#">#RepeatString("&nbsp;",10)##cat.getCategoryDisplayName()#</option>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<option value="#subCat.getCategoryId()#">#RepeatString("&nbsp;",20)##subCat.getCategoryDisplayName()#</option>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<option value="#thirdCat.getCategoryId()#">#RepeatString("&nbsp;",30)##thirdCat.getCategoryDisplayName()#</option>
										</cfloop>
										</li>
									</cfloop>
									</li>
								</cfloop>
							</select>
						</div>
						 <div class="form-group">
							<label>Rank</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="rank" value="#REQUEST.pageData.category.getRank()#" />
						</div>
						 <div class="form-group">
							<label>Status</label>
							 <select class="form-control" name="category_is_enabled">
								<option value="1" <cfif REQUEST.pageData.category.getCategoryIsEnabled() EQ TRUE>selected</cfif>>Enabled</option>
								<option value="0" <cfif REQUEST.pageData.category.getCategoryIsEnabled() EQ FALSE>selected</cfif>>Disabled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Show on Navigation</label>
							 <select class="form-control" name="show_category_on_nav">
								<option value="1" <cfif REQUEST.pageData.category.getShowCategoryOnNav() EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.category.getShowCategoryOnNav() EQ FALSE>selected</cfif>>No</option>
							</select>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
						<div class="form-group">
							<label>Title</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="category_title" value="#REQUEST.pageData.category.getCategoryTitle()#"/>
						</div>
						<div class="form-group">
							<label>Keywords</label>
							<textarea name="category_keywords" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.category.getCategoryKeywords()#</textarea>
						</div>
						<div class="form-group">
							<label>Description</label>
							<textarea name="category_description" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.category.getCategoryDescription()#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
					
						<div class="row">
							<div class="col-md-4">
								<select class="form-control" name="filter_group_id" id="filter_group" multiple>
									<cfloop array="#REQUEST.pageData.filterGroups#" index="fg">
										<option value="#fg.getFilterGroupId()#"
										<cfif fg.getFilterGroupId() EQ REQUEST.pageData.category.getFilterGroupId()>
										selected
										</cfif>
										>#fg.getFilterGroupDisplayName()#</option>
									</cfloop>
								</select>
							</div>
							<div class="col-md-8">
								<select class="form-control" name="filter" id="filter" multiple>
								</select>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_4">
						<div class="form-group">
							<label>Preview</label>
						</div>
						<div class="form-group">
							<label>HTML Code</label>
							<textarea name="category_custom_design" id="category_custom_design" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.category.getCategoryCustomDesign()#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_5">
						<div class="row">
							<cfloop array="#REQUEST.pageData.category.getCategoryImages()#" index="img">
								<div class="col-lg-3 col-md-4 col-xs-6 thumb">
									<a class="thumbnail" href="#APPLICATION.absoluteUrlWeb#admin/uploads/category/#REQUEST.pageData.category.getCategoryId()#/#img.getImageName()#" target="_blank">
										<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#admin/uploads/category/#img.getImageName()#" />
									</a>
								</div>
							</cfloop>
						</div>
						<div class="form-group">
							<div id="uploader">
								<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_6">
						<div class="row">
							<div class="col-xs-12">
								<div class="box">
							<div class="box-body table-responsive">
								<table id="products_table" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th>Rendering engine</th>
											<th>Browser</th>
											<th>Platform(s)</th>
											<th>Engine version</th>
											<th>CSS grade</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>Trident</td>
											<td>Internet
												Explorer 4.0</td>
											<td>Win 95+</td>
											<td> 4</td>
											<td>X</td>
										</tr>
										<tr>
											<td>Trident</td>
											<td>Internet
												Explorer 5.0</td>
											<td>Win 95+</td>
											<td>5</td>
											<td>C</td>
										</tr>
										<tr>
											<td>Trident</td>
											<td>Internet
												Explorer 5.5</td>
											<td>Win 95+</td>
											<td>5.5</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Trident</td>
											<td>Internet
												Explorer 6</td>
											<td>Win 98+</td>
											<td>6</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Trident</td>
											<td>Internet Explorer 7</td>
											<td>Win XP SP2+</td>
											<td>7</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Trident</td>
											<td>AOL browser (AOL desktop)</td>
											<td>Win XP</td>
											<td>6</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Firefox 1.0</td>
											<td>Win 98+ / OSX.2+</td>
											<td>1.7</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Firefox 1.5</td>
											<td>Win 98+ / OSX.2+</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Firefox 2.0</td>
											<td>Win 98+ / OSX.2+</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Firefox 3.0</td>
											<td>Win 2k+ / OSX.3+</td>
											<td>1.9</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Camino 1.0</td>
											<td>OSX.2+</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Camino 1.5</td>
											<td>OSX.3+</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Netscape 7.2</td>
											<td>Win 95+ / Mac OS 8.6-9.2</td>
											<td>1.7</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Netscape Browser 8</td>
											<td>Win 98SE+</td>
											<td>1.7</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Netscape Navigator 9</td>
											<td>Win 98+ / OSX.2+</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.0</td>
											<td>Win 95+ / OSX.1+</td>
											<td>1</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.1</td>
											<td>Win 95+ / OSX.1+</td>
											<td>1.1</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.2</td>
											<td>Win 95+ / OSX.1+</td>
											<td>1.2</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.3</td>
											<td>Win 95+ / OSX.1+</td>
											<td>1.3</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.4</td>
											<td>Win 95+ / OSX.1+</td>
											<td>1.4</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.5</td>
											<td>Win 95+ / OSX.1+</td>
											<td>1.5</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.6</td>
											<td>Win 95+ / OSX.1+</td>
											<td>1.6</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.7</td>
											<td>Win 98+ / OSX.1+</td>
											<td>1.7</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Mozilla 1.8</td>
											<td>Win 98+ / OSX.1+</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Seamonkey 1.1</td>
											<td>Win 98+ / OSX.2+</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Gecko</td>
											<td>Epiphany 2.20</td>
											<td>Gnome</td>
											<td>1.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Webkit</td>
											<td>Safari 1.2</td>
											<td>OSX.3</td>
											<td>125.5</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Webkit</td>
											<td>Safari 1.3</td>
											<td>OSX.3</td>
											<td>312.8</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Webkit</td>
											<td>Safari 2.0</td>
											<td>OSX.4+</td>
											<td>419.3</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Webkit</td>
											<td>Safari 3.0</td>
											<td>OSX.4+</td>
											<td>522.1</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Webkit</td>
											<td>OmniWeb 5.5</td>
											<td>OSX.4+</td>
											<td>420</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Webkit</td>
											<td>iPod Touch / iPhone</td>
											<td>iPod</td>
											<td>420.1</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Webkit</td>
											<td>S60</td>
											<td>S60</td>
											<td>413</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera 7.0</td>
											<td>Win 95+ / OSX.1+</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera 7.5</td>
											<td>Win 95+ / OSX.2+</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera 8.0</td>
											<td>Win 95+ / OSX.2+</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera 8.5</td>
											<td>Win 95+ / OSX.2+</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera 9.0</td>
											<td>Win 95+ / OSX.3+</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera 9.2</td>
											<td>Win 88+ / OSX.3+</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera 9.5</td>
											<td>Win 88+ / OSX.3+</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Opera for Wii</td>
											<td>Wii</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Nokia N800</td>
											<td>N800</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Presto</td>
											<td>Nintendo DS browser</td>
											<td>Nintendo DS</td>
											<td>8.5</td>
											<td>C/A<sup>1</sup></td>
										</tr>
										<tr>
											<td>KHTML</td>
											<td>Konqureror 3.1</td>
											<td>KDE 3.1</td>
											<td>3.1</td>
											<td>C</td>
										</tr>
										<tr>
											<td>KHTML</td>
											<td>Konqureror 3.3</td>
											<td>KDE 3.3</td>
											<td>3.3</td>
											<td>A</td>
										</tr>
										<tr>
											<td>KHTML</td>
											<td>Konqureror 3.5</td>
											<td>KDE 3.5</td>
											<td>3.5</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Tasman</td>
											<td>Internet Explorer 4.5</td>
											<td>Mac OS 8-9</td>
											<td>-</td>
											<td>X</td>
										</tr>
										<tr>
											<td>Tasman</td>
											<td>Internet Explorer 5.1</td>
											<td>Mac OS 7.6-9</td>
											<td>1</td>
											<td>C</td>
										</tr>
										<tr>
											<td>Tasman</td>
											<td>Internet Explorer 5.2</td>
											<td>Mac OS 8-X</td>
											<td>1</td>
											<td>C</td>
										</tr>
										<tr>
											<td>Misc</td>
											<td>NetFront 3.1</td>
											<td>Embedded devices</td>
											<td>-</td>
											<td>C</td>
										</tr>
										<tr>
											<td>Misc</td>
											<td>NetFront 3.4</td>
											<td>Embedded devices</td>
											<td>-</td>
											<td>A</td>
										</tr>
										<tr>
											<td>Misc</td>
											<td>Dillo 0.8</td>
											<td>Embedded devices</td>
											<td>-</td>
											<td>X</td>
										</tr>
										<tr>
											<td>Misc</td>
											<td>Links</td>
											<td>Text only</td>
											<td>-</td>
											<td>X</td>
										</tr>
										<tr>
											<td>Misc</td>
											<td>Lynx</td>
											<td>Text only</td>
											<td>-</td>
											<td>X</td>
										</tr>
										<tr>
											<td>Misc</td>
											<td>IE Mobile</td>
											<td>Windows Mobile 6</td>
											<td>-</td>
											<td>C</td>
										</tr>
										<tr>
											<td>Misc</td>
											<td>PSP browser</td>
											<td>PSP</td>
											<td>-</td>
											<td>C</td>
										</tr>
										<tr>
											<td>Other browsers</td>
											<td>All others</td>
											<td>-</td>
											<td>-</td>
											<td>U</td>
										</tr>
									</tbody>
									<tfoot>
										<tr>
											<th>Rendering engine</th>
											<th>Browser</th>
											<th>Platform(s)</th>
											<th>Engine version</th>
											<th>CSS grade</th>
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
				<button name="delete_category" type="submit" class="btn btn-danger top-nav-button">Delete Category</button>
			</div>
		</div><!-- /.col -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>