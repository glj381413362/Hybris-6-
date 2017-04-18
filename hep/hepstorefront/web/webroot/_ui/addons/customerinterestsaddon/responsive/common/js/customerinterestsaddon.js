ACC.customerInterests = {

	_autoload : [ "showInterest", "removeAllInterestForProduct" ],

	removeAllInterestForProduct : function() {
		$('.remove-interests-for-product').click(
				function() {
					var productCode = $(this).children("span").attr(
							"data-productCode");
					var myInterestUrl = ACC.config.encodedContextPath
							+ "/my-account/my-interests";
					$.ajax({
						method : "get",
						url : ACC.config.encodedContextPath
								+ "/my-account/my-interests/removeall/"
								+ productCode,
						success : function(data) {
							$(location).attr('href', myInterestUrl);
						}
					});
				});
	},

	showInterest : function() {
		$('.btn-notificaiton').click(
				function() {
					var productCode = $(this).attr("data-productCode");
					var notificationType = $(this)
							.attr("data-notificationType").toLowerCase();
					var url = ACC.config.encodedContextPath
							+ "/my-account/my-interests/show/"
							+ notificationType + "/" + productCode;
					var title = $(this).attr("data-title");
					ACC.colorbox.open(title, {
						href : url,
						maxWidth : "100%",
						width : "550px",
						initialWidth : "550px"
					});
				});
	}
}
