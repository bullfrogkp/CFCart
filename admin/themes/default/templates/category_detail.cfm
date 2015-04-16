﻿<cfoutput>

<script>
	$(document).ready(function() {
	
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
		
		CKEDITOR.replace( 'custom_design',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins//ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins//ckeditor/filemanager/index.html'}
		 );
		
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
		
		$( "##filter_group_id" ).change(function() {
			<cfif REQUEST.pageData.formData.filter_group_id NEQ "">	
			if($( "##filter_group_id" ).val() != #REQUEST.pageData.formData.filter_group_id#)
			{
				$('##filters').hide();
				$('##new-filters').empty();
			
				current_key = 'filter_group_' + $( "##filter_group_id" ).val();
			
				for(var i=0;i<filtergroups[current_key].length;i++)
				{
					$('##new-filters').append('<div class="col-xs-3"><div class="box box-warning"><div class="box-body table-responsive no-padding"><table class="table table-hover"><tr><th>'+filtergroups[current_key][i].name+'</th></tr></table></div></div></div>'); 
				}
			}
			else
			{
				$('##filters').show();
				$('##new-filters').empty();
			}
			<cfelse>
			$('##filters').hide();
			$('##new-filters').empty();
		
			current_key = 'filter_group_' + $( "##filter_group_id" ).val();
		
			for(var i=0;i<filtergroups[current_key].length;i++)
			{
				$('##new-filters').append('<div class="col-xs-3"><div class="box box-warning"><div class="box-body table-responsive no-padding"><table class="table table-hover"><tr><th>'+filtergroups[current_key][i].name+'</th></tr></table></div></div></div>'); 
			}	
			</cfif>
		});
		
		$( ".add-filter-value" ).click(function() {
			$("##new_filter_value_category_filter_rela_id").val($(this).attr('categoryfilterrelaid'));
			
			if($(this).attr('filtername') == 'color')
			{
				$('##new_filter_value').colorpicker();
			}
			else
			{
				$('##new_filter_value').unbind();
			}
		});
		
		$( ".delete-filter-value" ).click(function() {
			$("##deleted_filter_value_id").val($(this).attr('filtervalueid'));
		});
		
		$( ".delete-image" ).click(function() {
			$("##deleted_image_id").val($(this).attr('imageid'));
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
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<input type="hidden" name="new_filter_value_category_filter_rela_id" id="new_filter_value_category_filter_rela_id" value="" />
<input type="hidden" name="deleted_filter_value_id" id="deleted_filter_value_id" value="" />
<input type="hidden" name="deleted_image_id" id="deleted_image_id" value="" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div class="alert #REQUEST.pageData.message.messageType# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					#msg#<br/>
					</cfloop>
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
								<option value="">Root</option>
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
					
						<div class="form-group">
							<label>Filter Group</label>
							 <select class="form-control" name="filter_group_id" id="filter_group_id">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.filterGroups#" index="fg">
									<option value="#fg.getFilterGroupId()#"
									<cfif fg.getFilterGroupId() EQ REQUEST.pageData.formData.filter_group_id>
									selected
									</cfif>
									>#fg.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
					
						<cfif NOT IsNULL(REQUEST.pageData.category.getCategoryFilterRelas())>
							<label>Filter(s)</label>
							<div id="filters" class="row" style="margin-top:10px;">
							
								<cfloop array="#REQUEST.pageData.category.getCategoryFilterRelas()#" index="categoryFilterRela">		
									<cfset filter = categoryFilterRela.getFilter() />
									<div class="col-xs-3">
										<div class="box box-warning">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr class="warning">
														<th>#filter.getDisplayName()#</th>
														<th></th>
														<th><a categoryfilterrelaid="#categoryFilterRela.getCategoryFilterRelaId()#" filtername="#LCase(filter.getDisplayName())#" href="" class="add-filter-value pull-right" data-toggle="modal" data-target="##compose-modal"><span class="label label-primary">Add Option</span></a></th>
													</tr>
													
													<cfif NOT IsNull(categoryFilterRela.getFilterValues())>
														<cfloop array="#categoryFilterRela.getFilterValues()#" index="filterValue">
															<tr>
																<td>#filterValue.getDisplayName()#</td>
																<td>
																<cfif filter.getDisplayName() EQ "color">
																	<div style="width:14px;height:14px;border:1px solid ##CCC;background-color:#filterValue.getValue()#;display:inline-block;vertical-align:middle"></div>
																<cfelse>
																	#filterValue.getValue()#
																</cfif>
																</td>
																<td>
																	<a filtervalueid="#filterValue.getFilterValueId()#" href="" class="delete-filter-value pull-right" data-toggle="modal" data-target="##delete-modal"><span class="label label-danger">Delete</span></a>
																</td>
															</tr>
														</cfloop>
													</cfif>
												</table>
											</div><!-- /.box-body -->
										</div><!-- /.box -->
									</div>
								</cfloop>
							
							</div>
							<div id="new-filters" class="row" style="margin-top:10px;">
							</div>
						</cfif>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="form-group">
							<textarea name="custom_design" id="custom_design" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.custom_design#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_5']#" id="tab_5">
						<cfif NOT IsNULL(REQUEST.pageData.category) AND NOT IsNULL(REQUEST.pageData.category.getImages())>
							<div class="row">
								<cfloop array="#REQUEST.pageData.category.getImages()#" index="img">						
									<div class="col-xs-2">
										<div class="box <cfif img.getIsDefault() EQ true>box-danger</cfif>">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr <cfif img.getIsDefault() EQ true>class="danger"<cfelse>class="default"</cfif>>
														<th style="font-size:11px;line-height:20px;">#img.getName()#</th>
														<th><a imageid="#img.getCategoryImageId()#" href="" class="delete-image pull-right" data-toggle="modal" data-target="##delete-image-modal"><span class="label label-danger">Delete</span></a></th>
													</tr>
													<tr>
														<td colspan="2">
															<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#images/uploads/category/#REQUEST.pageData.category.getCategoryId()#/#img.getName()#" />
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<table style="width:100%;">
																<tr>
																	<td>
																		<input class="form-control pull-left" type="radio" name="default_image_id" value="#img.getCategoryImageId()#" <cfif img.getIsDefault() EQ true>checked</cfif>/>
																	</td>
																	<td style="padding-left:5px;padding-top:1px;font-size:12px;">
																		Set as Default
																	</td>
																	<td style="text-align:right">
																		<input type="text" name="rank_#img.getCategoryImageId()#" value="#img.getRank()#" style="width:30px;text-align:center;" />
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div><!-- /.box-body -->
										</div><!-- /.box -->
									</div>
								</cfloop>
							</div>
						</cfif>
						
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
										<table class="table table-bordered table-hover">
											
											<tr class="default">
												<th>Name</th>
												<th>Price</th>
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Action</th>
											</tr>
										
											<cfif NOT IsNull(REQUEST.pageData.category.getProducts()) AND ArrayLen(REQUEST.pageData.category.getProducts()) GT 0>
												<cfloop array="#REQUEST.pageData.category.getProducts()#" index="product">
													<tr>
														<td>#product[1].getDisplayName()#</td>
														<td>#product[1].getPrice()#</td>
														<td>#DateFormat(product[1].getCreatedDatetime(),"mmm dd,yyyy")#</td>
														<td>#product[1].getSku()#</td>
														<td>#product[1].getIsEnabled()#</td>
														<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product[1].getProductId()#">View Detail</a></td>
													</tr>
												</cfloop>
											<cfelse>
												<tr>
													<td colspan="6">No data available</td>
												</tr>
											</cfif>
										
											<tr class="default">
												<th>Name</th>
												<th>Price</th>
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Action</th>
											</tr>
										</table>
									</div><!-- /.box-body -->
									<div class="box-footer clearfix">
										<ul class="pagination pagination-sm no-margin pull-right">
											<li><a href="##">&laquo;</a></li>
											<li><a href="##">1</a></li>
											<li><a href="##">2</a></li>
											<li><a href="##">3</a></li>
											<li><a href="##">&raquo;</a></li>
										</ul>
									</div>
								</div><!-- /.box -->
							</div>
						</div>
					</div><!-- /.tab-pane -->
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Category</button>
				<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Category</button>
			</div>
		</div><!-- /.col -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- ADD OPTION MODAL -->
<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Option</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<input id="new_filter_display_name" name="new_filter_display_name" type="text" class="form-control" placeholder="Name">
				</div>
				<div class="form-group">
					<input id="new_filter_value" name="new_filter_value" type="text" class="form-control" placeholder="Option value">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_filter_value" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE OPTION MODAL -->
<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this option?</h4>
			</div>
		
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_filter_value" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this category?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_item" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE IMAGE MODAL -->
<div class="modal fade" id="delete-image-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this image?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_image" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>