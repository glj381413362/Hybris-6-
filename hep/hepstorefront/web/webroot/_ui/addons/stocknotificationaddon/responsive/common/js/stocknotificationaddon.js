ACC.stocknotification = {

	_autoload: [
		"bindStockNotification",
		"enableNotificationButton",
		"changePickUpInStoreBtnText"
	],

	bindStockNotification: function(){

        $("#arrival-notification").click(function(e){
        	
            var title = $(this).attr("data-box-title");
            var productCode = $("span.code").text();
            var url = ACC.config.encodedContextPath + "/my-account/my-stocknotification/open/" + productCode+"?channel=pdp";
            
            ACC.common.checkAuthenticationStatusBeforeAction(function(){
                ACC.colorbox.open(title, {
                    href : url,
                    maxWidth : "100%",
                    width : "550px",
                    initialWidth : "550px"
                });
            });           
        });
    },
    
    enableNotificationButton : function(){
    	$("#arrival-notification").removeAttr("disabled");
    },
    
    changePickUpInStoreBtnText : function() {
    	var productCode = $("input:hidden[name='productCodePost']").val();
    	var checkAvailabilityInStore = $("input:hidden[name='pickUpInStoreBtnText']");
    	if(checkAvailabilityInStore.length > 0) {
        	$("button#product_" + productCode).text($(checkAvailabilityInStore).val());
    	}
    }
};
