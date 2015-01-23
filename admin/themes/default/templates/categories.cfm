
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		Categories
		<small>all categories information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Categories</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	 <div class="row">
		<div class="col-md-4">
			<div class="box box-solid">
				<div class="box-header">
					<i class="fa fa-text-width"></i>
					<h3 class="box-title">Categories</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<ul>
						<li><a href="category_detail.cfm?category_id=#i.category_id#">#i.category_name#</a>
							<ul>
								<li><a href="category_detail.cfm?category_id=#k.category_id#">#k.category_name#</a></li>
							</ul>
						</li>
					</ul>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!-- ./col -->
		<div class="col-md-8">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">Categories</h3>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table id="example2" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Category Name</th>
								<th>Active</th>
								<th>Rank</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>#REQUEST.categories.name#</td>
								<td>#REQUEST.categories.is_active#</td>
								<td>#REQUEST.categories.rank#</td>
								<td><a href="#APPLICATION.absolute_url_web#admin/category_detail.cfm?category_id=#REQUEST.categories.category_id#">View Detail</a></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th>Category Name</th>
								<th>Active</th>
								<th>Rank</th>
								<th>Action</th>
							</tr>
						</tfoot>
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		
		</div><!-- ./col -->
	</div><!-- /.row -->
</section><!-- /.content -->
