<cfoutput>

<script>
	$(document).ready(function() {		
		$( ".delete-related-product" ).click(function() {
			$("##related_product_id").val($(this).attr('relatedproductid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		Group Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Group Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="related_product_id" id="related_product_id" value="" />
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
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-body">
					<div class="form-group">
						<label>Name</label>
						<input type="text" name="display_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
					</div>
					<div class="form-group">
						<label>Products</label>
						<a href="" data-toggle="modal" data-target="##add-product-modal" style="margin-left:10px;"><span class="label label-primary">Add Product</span></a>
						<cfif NOT IsNull(REQUEST.pageData.relatedProductGroup) AND NOT IsNull(REQUEST.pageData.relatedProductGroup.getRelatedProducts()) >
							<div class="row" style="margin-top:10px;">
								<cfloop array="#REQUEST.pageData.relatedProductGroup.getRelatedProducts()#" index="product">
									<div class="col-xs-2">
										<div class="box box-warning">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr class="warning">
														<th>#product.getDisplayName()#</th>
														<th>
															<a relatedproductid="#product.getProductId()#" href="" class="delete-attribute-option-value pull-right" data-toggle="modal" data-target="##delete-product-modal"><span class="label label-danger">Delete</span></a>
														</th>
													</tr>
													<tr>
														<td colspan="2">
															<img class="img-responsive" src="#APPLICATION.absoluteUrlWeb#images/uploads/product/#product.getProductId()#/#EntityLoad("product_image",{isDefault = true},true).getName()#" />
														</td>
													</tr>
												</table>
											</div><!-- /.box-body -->
										</div><!-- /.box -->
									</div>
								</cfloop>
							</div>
						</cfif>
					</div>
					<div class="form-group">
						<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Product Group</button>
						<button name="delete_item" type="submit" class="btn btn-danger top-nav-button pull-right #REQUEST.pageData.deleteButtonClass#">Delete Product Group</button>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- ADD PRODUCT MODAL -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add Related Product</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_related_product_id" name="new_related_product_id" type="text" class="form-control" placeholder="Product ID">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_related_product" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE PRODUCT MODAL -->
<div class="modal fade" id="delete-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this related product?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_related_product" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>