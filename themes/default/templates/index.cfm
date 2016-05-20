<cfoutput>
<script type="text/javascript">
	$(function() {
		$('##da-slider').cslider({
			autoplay	: true,
			bgincrement	: 0
		});
	});
</script>
<div id="slide-div" style="width:722px;float:right;margin-top:4px;">
	#REQUEST.pageData.modules.slide.slideSection#
</div>
</cfoutput>
