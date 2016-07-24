<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Password</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Password</h5></p>
							<form>
								<label>Current Password</label>
								<input type="text" value="" placeholder="Current Password" class="simple-field">
								<label>New Password</label>
								<input type="password" value="" placeholder="New Password" class="simple-field">
								<label>Confirm New Password</label>
								<input type="password" value="" placeholder="Confirm New Password" class="simple-field">
								<div class="button style-14">Save<input type="submit" value=""></div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<cfinclude template="nav.cfm" />
	</div>
</div>
</cfoutput>