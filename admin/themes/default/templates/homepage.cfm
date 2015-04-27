<cfoutput>
<script>
	$(document).ready(function() {		
		CKEDITOR.replace( 'slide_content',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html'}
		);
		
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlWeb#admin/ajax/upload_ads.cfm",

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
		
		$( ".delete-ad" ).click(function() {
			$("##deleted_ad_id").val($(this).attr('adid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		Home Page
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Home Page</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="deleted_ad_id" id="deleted_ad_id" value="" />
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
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">Slide</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Advertise Images</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Top Selling</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Group Buying</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						<div class="form-group">
							<textarea name="slide_content" id="slide_content" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.slide_content#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
						<div class="form-group">
							<div class="row">
								<cfif NOT IsNull(REQUEST.pageData.homepageAds)>
									<cfloop array="#REQUEST.pageData.homepageAds#" index="ad">						
										<div class="col-xs-2">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="warning">
															<th style="font-size:11px;line-height:20px;">
																<input type="text" placeholder="Rank" name="rank_#ad.getHomepageAdId()#" value="#ad.getRank()#" style="width:40px;text-align:center;" />
															</th>
															<th><a adid="#ad.getHomepageAdId()#" href="" class="delete-ad pull-right" data-toggle="modal" data-target="##delete-ad-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#images/uploads/advertise/#ad.getName()#" />
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
								<div id="uploader">
									<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
								</div>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
						<div class="form-group">
							<a data-toggle="modal" data-target="##add-product-modal" href="" style="margin-left:10px;">
								<span class="label label-primary">Add New Product</span>
							</a>
							<div class="row" style="margin-top:10px;">
								<cfloop array="#REQUEST.pageData.topSellingProducts#" index="product">	
									<div class="col-xs-2">
										<div class="box">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr class="default">
														<th><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">#product.getDisplayName()#</a></th>
														<th><a relatedproductid="#product.getProductId()#" href="" class="delete-related-product pull-right" data-toggle="modal" data-target="##delete-product-modal"><span class="label label-danger">Delete</span></a></th>
													</tr>
													<tr>
														<td colspan="2">
															<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#images/uploads/product/#product.getProductId()#/#productImg.getName()#" />
														</td>
													</tr>
												</table>
											</div><!-- /.box-body -->
										</div><!-- /.box -->
									</div>
								</cfloop>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="form-group">
							<a data-toggle="modal" data-target="##add-product-modal" href="" style="margin-left:10px;"><span class="label label-primary">Add New Product</span></a>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNULL(REQUEST.pageData.product) AND NOT IsNULL(REQUEST.pageData.product.getRelatedProducts())>
									<cfloop array="#REQUEST.pageData.product.getRelatedProducts()#" index="product">	
										<cfset productImg = EntityLoad("product_image",{product = product, isDefault = true},true) />
										<cfif NOT IsNull(productImg)>
											<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#product.getProductId()#/#productImg.getName()#" />
										<cfelse>
											<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/site/no_image_available.png" />
										</cfif>
										<div class="col-xs-2">
											<div class="box">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="default">
															<th><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">#product.getDisplayName()#</a></th>
															<th><a relatedproductid="#product.getProductId()#" href="" class="delete-related-product pull-right" data-toggle="modal" data-target="##delete-product-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<img class="img-responsive" src="#imageLink#" />
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
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Homepage</button>
			</div>
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
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