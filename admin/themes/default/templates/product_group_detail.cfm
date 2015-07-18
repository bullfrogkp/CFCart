<cfoutput>

<script>
	$(document).ready(function() {		
		$( ".delete-product" ).click(function() {
			$("##product_id").val($(this).attr('productid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		Product Group Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Product Group Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="product_id" id="product_id" value="" />
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
					<div class="row">
						<div class="col-xs-3" style="padding-right:0;">
							<select name="product_group_id" id="product-group-id" class="form-control">
								<option value="0">Product Group</option>
								<cfloop array="#REQUEST.pageData.productGroups#" index="group">
									<option value="#group.getProductGroupId()#">#group.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<div class="col-xs-4" style="padding-right:0;">
							<select class="form-control" name="category_id" id="category-id">
								<option value="0">Category</option>
								<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
									<option value="#cat.getCategoryId()#"
									<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),cat)>
									selected
									</cfif>
									>#RepeatString("&nbsp;",1)##cat.getDisplayName()#</option>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<option value="#subCat.getCategoryId()#"
										<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),subCat)>
										selected
										</cfif>
										>#RepeatString("&nbsp;",11)##subCat.getDisplayName()#</option>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<option value="#thirdCat.getCategoryId()#"
											<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),thirdCat)>
											selected
											</cfif>
											>#RepeatString("&nbsp;",21)##thirdCat.getDisplayName()#</option>
										</cfloop>
										</li>
									</cfloop>
									</li>
								</cfloop>
							</select>
						</div>
						<div class="col-xs-4" style="padding-right:0;padding-left:10px;">
							<input type="text" name="keywords" id="keywords" class="form-control" placeholder="Keywords">
						</div>
						<div class="col-xs-1" style="padding-left:10px;">
							<button name="search_product" id="search-product" type="button" class="btn btn-sm btn-primary search-button" style="width:100%">Search</button>
						</div>
					</div>
					<div class="row" style="margin-top:18px;">
						<div class="col-xs-5">	
							<select name="product_searched" id="product-searched" multiple class="form-control" style="height:340px;">
								<option>product</option>
								<option>product</option>
								<option>product</option>
								<option>product</option>
								<option>product</option>
								<option>product</option>
							</select>
						</div>
						<div class="col-xs-2" style="text-align:center;">
							<a class="btn btn-app">
								<i class="fa fa-angle-double-right"></i> Add All
							</a>
							<a class="btn btn-app">
								<i class="fa fa-angle-right"></i> Add
							</a>
							<a class="btn btn-app">
								<i class="fa fa-angle-left"></i> Remove
							</a>
							<a class="btn btn-app">
								<i class="fa fa-angle-double-left"></i> Remove All
							</a>
							<a class="btn btn-app">
								<i class="fa fa-trash-o"></i> Delete
							</a>
						</div>
						<div class="col-xs-5">	
							<select name="product_selected" id="product-selected" multiple class="form-control" style="height:340px;">
							
							</select>
						</div>
					</div>
					<div class="form-group">
						<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Product Group</button>
						<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Product Group</button>
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
				<h4 class="modal-title"> Add Product</h4>
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
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this product group?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_item" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>