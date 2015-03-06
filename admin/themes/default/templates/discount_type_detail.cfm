<cfoutput>
<section class="content-header">
	<h1>
		Discount Type Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Discount Type Detail</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<form role="form">
					<div class="box-body">
						<div class="form-group">
							<label>Name</label>
							<input name="display_name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
						</div>
						<div class="form-group">
							<label>Calculation Type</label>
							<select name="Calculation_type_id" class="form-control">
								<cfloop array="#REQUEST.pageData.CalculationTypes#" index="type">
									<option value="#type.getCalculationTypeId()#"
									
									<cfif type.getCalculationTypeId() EQ REQUEST.pageData.discountType.getCalculationType().getCalculationTypeId()>
									selected
									</cfif>
									
									>#type.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<div class="form-group">
							<label>Amount</label>
							<input name="amount" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.amount#"/>
						</div>
						<button name="save_item" type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>