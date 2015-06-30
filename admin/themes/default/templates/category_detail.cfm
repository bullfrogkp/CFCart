<cfoutput>

<script>
	$(document).ready(function() {
	
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
		
		CKEDITOR.replace( 'custom_design',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html'}
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
		
		$("##ads_image").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlWeb#admin/ajax/upload_ads.cfm",

			// Maximum file size
			max_file_size: '1000mb',

			// User can upload no more then 20 files in one go (sets multiple_queues to false)
			max_file_count: 20,
			
			chunk_size: '1mb',

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
					
		$( ".delete-image" ).click(function() {
			$("##deleted_image_id").val($(this).attr('imageid'));
		});
		
		$( ".delete-ad" ).click(function() {
			$("##deleted_ad_id").val($(this).attr('adid'));
		});
		
		$( ".delete-best-seller-product" ).click(function() {
			$("##deleted_best_seller_product_id").val($(this).attr('productid'));
		});
		
		$( "##filter-group-id" ).change(function() {
			$(".filter-group").hide();
			$("##filter-group-" + $(this).val()).show();
		});
		
		var new_filter_index = 1;
		
		$('##new-filter-value-color').colorpicker();
		
		$('.filter-group').on("click","a.add-filter-value", function() {
			$("##new-filter-group-id-hidden").val($(this).attr('filtergroupid'));
			$("##new-filter-id-hidden").val($(this).attr('filterid'));
			$("##new-filter-name-hidden").val($(this).attr('filtername'));
			
			if($(this).attr('filtername') == 'color')
			{
				$('##new-filter-value').hide();
				$('##new-filter-value-color').show();
			}
			else
			{
				$('##new-filter-value-color').hide();
				$('##new-filter-value').show();
			}
		});
		
		$( "##add-new-filter-value-confirm" ).click(function() {
			var thumbnail_content = '';
			var name_content = $("##new-filter-display-name").val();
			var new_filter_name =  'new_filter_' + new_filter_index;
			var new_filter_tr_id =  'tr-fg-new-filter-' + new_filter_index;
		
			if($("##new-filter-name-hidden").val() == 'color')
				thumbnail_content = '<div style="width:14px;height:14px;border:1px solid ##CCC;background-color:'+$("##new-filter-value-color").val()+';margin-top:4px;"></div>';
			else
				thumbnail_content = name_content;
				
			$("##tr-" + $("##new-filter-group-id-hidden").val() + '-' + $("##new-filter-id-hidden").val()).after('<tr id="'+new_filter_tr_id+'"><td>'+name_content+'</td><td>'+thumbnail_content+'</td><td><a filtervalueid="'+new_filter_index+'" href="" class="delete-filter-value pull-right" data-toggle="modal" data-target="##delete-filter-value-modal"><span class="label label-danger">Delete</span></a></td></tr>'); 
		
			$("##new-filter-id-list").val($("##new-filter-id-list").val() + new_filter_index + ',');			
			$('<input>').attr({type: 'hidden',name: new_filter_name+'_name',value: $("##new-filter-display-name").val()}).appendTo($("##category-detail"));
			$('<input>').attr({type: 'hidden',name: new_filter_name+'_fgroup'+$("##filter-group-id").val()+'_filter_id',value: $("##new-filter-id-hidden").val()}).appendTo($("##category-detail"));
			if($("##new-filter-name-hidden").val() == 'color')
				$('<input>').attr({type: 'hidden',name: new_filter_name+'_value',value: $("##new-filter-value-color").val()}).appendTo($("##category-detail"));
			else
				$('<input>').attr({type: 'hidden',name: new_filter_name+'_value',value: $("##new-filter-value").val()}).appendTo($("##category-detail"));
			
			$("##new-filter-display-name").val('');
			$("##new-filter-value").val('');
			$("##new-filter-value-color").val('');
			
			new_filter_index++;
		});
		
		$('.filter-group').on("click","a.delete-filter-value", function() {
			$("##deleted-filter-value-id-hidden").val($(this).attr('filtervalueid'));
		});
		
		$( "##delete-filter-value-confirm" ).click(function() {			
			$("##tr-fg-" + $("##deleted-filter-value-id-hidden").val()).remove();
			$("##tr-fg-new-filter-" + $("##deleted-filter-value-id-hidden").val()).remove();
			
			var str = $("##new-filter-id-list").val();
			var n = str.indexOf($("##deleted-filter-value-id-hidden").val() + ',');
			
			if(n != -1)
			{
				$("##new-filter-id-list").val($("##new-filter-id-list").val().replace($("##deleted-filter-value-id-hidden").val() + ',', ''));
			}
			else
			{	
				$("##remove-filter-id-list").val($("##remove-filter-id-list").val() + $("##deleted-filter-value-id-hidden").val() + ',');
			}	
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
<form id="category-detail" method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<input type="hidden" name="deleted_image_id" id="deleted_image_id" value="" />
<input type="hidden" name="deleted_ad_id" id="deleted_ad_id" value="" />
<input type="hidden" name="deleted_best_seller_product_id" id="deleted_best_seller_product_id" value="" />

<input type="hidden" name="new_filter_value_id_hidden" id="new-filter-value-id-hidden" value="" />
<input type="hidden" name="new_filter_group_id_hidden" id="new-filter-group-id-hidden" value="" />
<input type="hidden" name="new_filter_id_hidden" id="new-filter-id-hidden" value="" />
<input type="hidden" name="new_filter_name_hidden" id="new-filter-name-hidden" value="" />
<input type="hidden" name="deleted_filter_value_id_hidden" id="deleted-filter-value-id-hidden" value="" />
<input type="hidden" name="new_filter_id_list" id="new-filter-id-list" value="" />
<input type="hidden" name="remove_filter_id_list" id="remove-filter-id-list" value="" />
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
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Filter</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Custom Design</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_5']#" tabid="tab_5"><a href="##tab_5" data-toggle="tab">Thumbnail Image</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_6']#" tabid="tab_6"><a href="##tab_6" data-toggle="tab">Product</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_7']#" tabid="tab_7"><a href="##tab_7" data-toggle="tab">Advertisement</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_8']#" tabid="tab_8"><a href="##tab_8" data-toggle="tab">Best Seller</a></li>
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
						<div class="form-group">
							<label>Display Category List</label>
							 <select class="form-control" name="display_category_list">
								<option value="1" <cfif IsBoolean(REQUEST.pageData.formData.display_category_list) AND REQUEST.pageData.formData.display_category_list EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif NOT (IsBoolean(REQUEST.pageData.formData.display_category_list) AND REQUEST.pageData.formData.display_category_list EQ TRUE)>selected</cfif>>No</option>
							</select>
						</div>
						<div class="form-group">
							<label>Special Category</label>
							 <select class="form-control" name="is_special">
								<option value="1" <cfif IsBoolean(REQUEST.pageData.formData.is_special) AND REQUEST.pageData.formData.is_special EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif NOT (IsBoolean(REQUEST.pageData.formData.is_special) AND REQUEST.pageData.formData.is_special EQ TRUE)>selected</cfif>>No</option>
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
							 <select class="form-control" name="filter_group_id" id="filter-group-id">
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
						
						<div class="form-group">
							<label>Display Filter</label>
							 <select class="form-control" name="display_filter">
								<option value="1" <cfif REQUEST.pageData.formData.display_filter EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.display_filter EQ FALSE>selected</cfif>>No</option>
							</select>
						</div>
					
						<cfloop array="#REQUEST.pageData.filterGroups#" index="filterGroup">
							<div class="filter-group" id="filter-group-#filterGroup.getFilterGroupId()#" style="<cfif IsNull(REQUEST.pageData.category) OR IsNull(REQUEST.pageData.category.getFilterGroup()) OR (NOT IsNull(REQUEST.pageData.category) AND (filterGroup.getFilterGroupId() NEQ REQUEST.pageData.category.getFilterGroup().getFilterGroupId()))>display:none;</cfif>">
								<label>Filter(s)</label>
								
								<div class="row" style="margin-top:10px;">
									<cfloop array="#filterGroup.getFilters()#" index="filter">	
										<div class="col-xs-3">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="warning" id="tr-#filterGroup.getFilterGroupId()#-#filter.getFilterId()#">
															<th colspan="2">#filter.getDisplayName()#</th>
															<th>
																<a filtergroupid="#filterGroup.getFilterGroupId()#" filterid="#filter.getFilterId()#" filtername="#filter.getName()#" href="" class="add-filter-value pull-right" data-toggle="modal" data-target="##add-filter-value-modal">
																	<span class="label label-primary">Add Option</span>
																</a>
															</th>
														</tr>
														
														<cfif NOT IsNull(REQUEST.pageData.category) AND NOT IsNull(REQUEST.pageData.category.getFilterGroup()) AND filterGroup.getFilterGroupId() EQ REQUEST.pageData.category.getFilterGroup().getFilterGroupId()>
															<cfset categoryFilterRela = EntityLoad("category_filter_rela",{category=REQUEST.pageData.category,filter=filter},true) />
															<cfif NOT IsNull(categoryFilterRela.getFilterValues())>
																<cfloop array="#categoryFilterRela.getFilterValues()#" index="filterValue">
																	<tr id="tr-fg-#filterValue.getFilterValueId()#">
																		<td>#filterValue.getDisplayName()#</td>
																		<td>
																		<cfif filter.getDisplayName() EQ "color">
																			<div style="width:14px;height:14px;border:1px solid ##CCC;background-color:#filterValue.getValue()#;display:inline-block;vertical-align:middle"></div>
																		<cfelse>
																			#filterValue.getValue()#
																		</cfif>
																		</td>
																		<td>
																			<a filtervalueid="#filterValue.getFilterValueId()#" href="" class="delete-filter-value pull-right" data-toggle="modal" data-target="##delete-filter-value-modal"><span class="label label-danger">Delete</span></a>
																		</td>
																	</tr>
																</cfloop>
															</cfif>
														</cfif>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</div>
							</div>
						</cfloop>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="form-group">
							<label>Display Custom Design Section</label>
							 <select class="form-control" name="display_custom_design">
								<option value="1" <cfif REQUEST.pageData.formData.display_custom_design EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.display_custom_design EQ FALSE>selected</cfif>>No</option>
							</select>
						</div>
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
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Action</th>
											</tr>
										
											<cfif NOT IsNull(REQUEST.pageData.paginationInfo.records) AND ArrayLen(REQUEST.pageData.paginationInfo.records) NEQ 0>
												<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="product">
													<tr>
														<td>#product[1].getDisplayName()#</td>
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
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Action</th>
											</tr>
										</table>
									</div><!-- /.box-body -->
									<div class="box-footer clearfix">
										<cfset extraURLParams = "active_tab_id=tab_6" />
										<cfinclude template="pagination.cfm" />
									</div>
								</div><!-- /.box -->
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_7']#" id="tab_7">
						<div class="form-group">
							<div class="row">
								<cfif NOT IsNull(REQUEST.pageData.advertisementSection.getSectionData())>
									<cfloop array="#REQUEST.pageData.advertisementSection.getSectionData()#" index="ad">						
										<div class="col-xs-2">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="warning">
															<th style="font-size:11px;line-height:20px;">
																<input type="text" placeholder="Rank" name="advertisement_rank_#ad.getPageSectionAdvertisementId()#" value="#ad.getRank()#" style="width:40px;text-align:center;" />
															</th>
															<th><a adid="#ad.getPageSectionAdvertisementId()#" href="" class="delete-ad pull-right" data-toggle="modal" data-target="##delete-ad-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<img class="img-responsive" src="#ad.getImageLink(type = "small")#" />
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<input type="text" placeholder="Link" name="advertisement_link_#ad.getPageSectionAdvertisementId()#" value="#ad.getLink()#" style="width:100%;padding-left:5px;"/>
															</td>
														</tr>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</cfif>
							</div>
							
							<div class="form-group">
								<div id="ads_image">
									<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
								</div>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_8']#" id="tab_8">
						<div class="form-group">
							<a data-toggle="modal" data-target="##add-best-seller-product-modal" href="">
								<span class="label label-primary">Add New Product</span>
							</a>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNull(REQUEST.pageData.bestSellerSection.getSectionData())>
									<cfloop array="#REQUEST.pageData.bestSellerSection.getSectionData()#" index="bs">	
										<cfset product = bs.getSectionProduct() />
										<div class="col-xs-2">
											<div class="box">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="default">
															<th style="font-size:11px;line-height:20px;">
																<input type="text" placeholder="Rank" name="best_seller_rank_#bs.getPageSectionProductId()#" value="#bs.getRank()#" style="width:40px;text-align:center;" />
															</th>
															<th><a productid="#product.getProductId()#" href="" class="delete-best-seller-product pull-right" data-toggle="modal" data-target="##delete-best-seller-product-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<a href="#product.getDetailPageURL()#">
																	<img class="img-responsive" src="#product.getDefaultImageLink(type='small')#" />
																</a>
															</td>
														</tr>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</cfif>
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
<div class="modal fade" id="add-filter-value-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Option</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<input id="new-filter-display-name" name="new_filter_display_name" type="text" class="form-control" placeholder="Name">
				</div>
				<div class="form-group">
					<input id="new-filter-value" name="new_filter_value" type="text" class="form-control" placeholder="Option value">
					<input id="new-filter-value-color" name="new_filter_value_color" type="text" class="form-control" placeholder="Option value" style="display:none;">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_filter_value_confirm" id="add-new-filter-value-confirm" type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE OPTION MODAL -->
<div class="modal fade" id="delete-filter-value-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this option?</h4>
			</div>
		
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_filter_value_confirm" id="delete-filter-value-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check"></i> Yes</button>
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
<!-- ADD BEST SELLER PRODUCT MODAL -->
<div class="modal fade" id="add-best-seller-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add Best Seller Product</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<label>Product Group</label>
					<select name="best_seller_product_group_id" multiple class="form-control">
						<cfloop array="#REQUEST.pageData.relatedProductGroups#" index="group">
							<option value="#group.getRelatedProductGroupId()#">#group.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group">
					<label>Product ID</label>
					<input id="new_best_seller_product_id" name="new_best_seller_product_id" type="text" class="form-control" placeholder="Product ID">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_best_seller_product" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE BEST SELLER PRODUCT MODAL -->
<div class="modal fade" id="delete-best-seller-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this best seller product?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_best_seller_product" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE AD MODAL -->
<div class="modal fade" id="delete-ad-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this Ad?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_ad" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>