<cfoutput>

<script>
	$(document).ready(function() {
		CKEDITOR.replace('product_detail_text');
		
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
		
		$('##from_date').datepicker();
		$('##to_date').datepicker();
	});
</script>

<section class="content-header">
	<h1>
		Product Detail
		<small>product information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Product Detail</li>
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
					<li><a href="##tab_2" data-toggle="tab">Meta Data</a></li>
					<li><a href="##tab_3" data-toggle="tab">Price</a></li>
					<li><a href="##tab_4" data-toggle="tab">Images</a></li>
					<li><a href="##tab_5" data-toggle="tab">Attributes</a></li>
					<li><a href="##tab_6" data-toggle="tab">Related Products</a></li>
					<li><a href="##tab_7" data-toggle="tab">Reviews</a></li>
					<li><a href="##tab_8" data-toggle="tab">Shipping</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_1">
						<form role="form">
							 <div class="form-group">
								<label>Product Name</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
							</div>
							<div class="form-group">
								<label>Category</label>
								<select name="category_id" multiple class="form-control">
									<cfloop array="#REQUEST.pageData.formData.categories()#" index="cat">
										<option value="#cat.getCategoryId()#"
										<cfif Find(cat.getCategoryId(),LOCAL.pageData.currentCategoryList)>
										selected
										</cfif>
										>#cat.getDisplayName()#</option>
									</cfloop>
								</select>
							</div>
							<div class="form-group">
								<label>SKU</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.sku#"/>
							</div>
							<div class="form-group">
								<label>Status</label>
								 <select class="form-control" name="is_enabled">
									<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ TRUE>selected</cfif>>Enabled</option>
									<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ FALSE>selected</cfif>>Disabled</option>
								</select>
							</div>
							<div class="form-group">
								<label>Product Detail</label>
								<textarea name="product_detail_text" id="product_detail_text" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.detail#</textarea>
							</div>
						</form>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_2">
						<form role="form">
							 <div class="form-group">
								<label>Title</label>
								<input name="title" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.title#"/>
							</div>
							<div class="form-group">
								<label>Description</label>
								<textarea name="description" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
							</div>
							<div class="form-group">
								<label>Keywords</label>
								<textarea name="keywords" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.keywords#</textarea>
							</div>
						</form>
					</div><!-- /.tab-pane -->
					<div class="tab-pane" id="tab_3">
						<form role="form">
							 <div class="form-group">
								<label>Price</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.price#"/>
							</div>
							<cfloop array="#REQUEST.pageData.groupPrices#" index="gp">
								<div class="form-group">
									<label>Group Price</label>
									<input type="text" class="form-control" placeholder="Enter ..." value="#gp.getPrice()#"/>
								</div>
								<div class="form-group">
									<label>Group</label>
									<select name="category_id" multiple class="form-control">
										<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
											<option value="#group.getGroupId()#"
											<cfif ArrayFind(gp.getCustomerGroups(),group)>
											selected
											</cfif>
											>#cat.getDisplayName()#</option>
										</cfloop>
									</select>
								</div>
							</cfloop>
							 <div class="form-group">
								<label>Special Price</label>
								<input type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.special_price#"/>
							</div>
							 <div class="form-group">
								<label>Special Price From Date</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right" name="from_date" id="from_date" value="#REQUEST.pageData.formData.from_date#"/>
								</div><!-- /.input group -->
							</div><!-- /.form group -->
							<div class="form-group">
								<label>Special Price To Date</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right" name="to_date" id="to_date" value="#REQUEST.pageData.formData.to_date#"/>
								</div><!-- /.input group -->
							</div><!-- /.form group -->
							<div class="form-group">
								<label>Tax Category</label>
								<select name="tax_category_id" class="form-control">
									<cfloop array="#REQUEST.pageData.taxCategories#" index="tc">
										<option value="#tc.getTaxCategoryId()#"
										
										<cfif tc.getTaxCategoryId() EQ REQUEST.pageData.product.getTaxCategoryId()>
										selected
										</cfif>
										
										>#tc.getDisplayName()#</option>
									</cfloop>
								</select>
							</div>
							
						</form>
					</div><!-- /.tab-pane -->
					
					<div class="tab-pane" id="tab_4">
						<div class="row">
							<cfif IsDefined("REQUEST.pageData.product.getImages()")>
								<cfloop array="#REQUEST.pageData.product.getImages()#" index="img">
									<div class="col-lg-3 col-md-4 col-xs-6 thumb">
										<a class="thumbnail" href="#APPLICATION.absoluteUrlWeb#admin/uploads/product/#REQUEST.pageData.product.getProductId()#/#img.getName()#" target="_blank">
											<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#admin/uploads/product/#REQUEST.pageData.product.getProductId()#/#img.getName()#" />
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
					<div class="tab-pane" id="tab_5">
						<form role="form">
							<!-- text input -->
							<div class="form-group">
								<label>Attribute Set</label>
								<select name="attribute_set_id" class="form-control">
									<cfloop array="#REQUEST.pageData.attributeSets#" index="as">
										<option value="#tc.getAttributeSetId()#"
										
										<cfif tc.getAttributeSetId() EQ REQUEST.pageData.product.getAttributeSetId()>
										selected
										</cfif>
										
										>#as.getDisplayName()#</option>
									</cfloop>
								</select>
							</div>
							<table class="table table-bordered table-striped" style="margin-top:30px;">
								<tr>
									<th>Attribute Name</th>
									<th>Attribute Values</th>
								</tr>
								<cfloop array="#REQUEST.pageData.attributeSet.getAttributes()#" index="attribute">
									<tr>
										<td>Color</td>
										<td>
											<cfloop array="##" index="attributeValue">
											
											</cfloop>
										</td>
									</tr>
								</cfloop>
							</table>
							
						</form>
					</div>
					<div class="tab-pane" id="tab_6">
						<form role="form">
							<table class="table table-bordered table-striped">
								<tr>
									<th>Product Name</th>
									<th>Category</th>
									<th>Price</th>
									<th>Action</th>
								</tr>
								<tr>
									<td>Color</td>
									<td>Red,Blue,White,Black</td>
									<td>Red,Blue,White,Black</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?request_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Size</td>
									<td>Large,Medium,Small</td>
									<td>Large,Medium,Small</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?request_id=1">View Detail</a></td>
								</tr>
							</table>
							
						</form>
					</div>
					<div class="tab-pane" id="tab_7">
						<form role="form">
							<table class="table table-bordered table-striped">
								<tr>
									<th>Subject</th>
									<th>Message</th>
									<th>Rating</th>
									<th>Create Datetime</th>
									<th>Action</th>
								</tr>
								<tr>
									<td>Color</td>
									<td>Red,Blue,White,Black</td>
									<td>Red,Blue,White,Black</td>
									<td>Red,Blue,White,Black</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?request_id=1">View Detail</a></td>
								</tr>
								<tr>
									<td>Size</td>
									<td>Large,Medium,Small</td>
									<td>Large,Medium,Small</td>
									<td>Large,Medium,Small</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?request_id=1">View Detail</a></td>
								</tr>
							</table>
							
						</form>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>