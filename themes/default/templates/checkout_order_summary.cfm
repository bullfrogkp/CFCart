<cfoutput>
<div class="info-sidebar" style="margin-top:3px;">
	<strong>Order Summary</strong>
	<table style="width:100%;margin-top:13px;line-height:20px;">	
		<tr>
			<td style="font-weight:bold;width:173px;">Items(#REQUEST.pageData.shoppingCartItemTotalCount#):</td>
			<td>
				#LSCurrencyFormat(SESSION.order.subTotalPrice,"local",SESSION.currency.locale)#
			</td>
		</tr>
		<tr>
			<td style="font-weight:bold;width:173px;">Tax:</td>
			<td>
				<cfif NOT IsNull(SESSION.order.totalTax) AND SESSION.order.totalTax NEQ 0>
					#LSCurrencyFormat(SESSION.order.totalTax,"local",SESSION.currency.locale)#
				<cfelse>
					-
				</cfif>
			</td>
		</tr>
		<tr>
			<td style="font-weight:bold;width:173px;">Shipping & Handling:</td>
			<td>
				-
			</td>
		</tr>
		<tr>
			<td style="font-weight:bold;width:173px;">Total:</td>
			<td>
				#LSCurrencyFormat(SESSION.order.subTotalPrice,"local",SESSION.currency.locale)#
			</td>
		</tr>
	</table>			
</div>	
</cfoutput>