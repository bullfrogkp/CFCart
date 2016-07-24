<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Order Detail</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<form>
					<div class="row">
						<div class="col-md-12 information-entry">
							<div class="article-container style-1">
								<p><h5>Order Detail (OR12345)</h5></p>
									<label>Tracking Number: OR12345</label>
									<label>Phone: 4168309367</label>
									<label>Billing Address: Kevin Pan, Toronto, Ontario, Canada, M2M 4M6</label>
									<label>Shipping Address: Kevin Pan, Toronto, Ontario, Canada, M2M 4M6</label>
							</div>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-md-12 information-entry">
							<div class="article-container style-1">
								<p><h5>Products</h5></p>
								<div class="table-responsive">
									<table class="profile-table">
										<tr>
											<th>Tracking No.</th>
											<th>Created</th>
											<th>Status</th>
											<th></th>
										</tr>
										<tr>
											<td>OR12345</td>
											<td>Julu 12, 2016</td>
											<td>Shipped</td>
											<td><a>View Detail</a></td>
										</tr>
										<tr>
											<td>OR12345</td>
											<td>Julu 12, 2016</td>
											<td>Shipped</td>
											<td><a href="">View Detail</a></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<br/>
					<div class="button style-14">Save<input type="submit" value=""></div>
				</form>
			</div>
		</div>
		<cfinclude template="nav.cfm" />
	</div>
</div>
</cfoutput>