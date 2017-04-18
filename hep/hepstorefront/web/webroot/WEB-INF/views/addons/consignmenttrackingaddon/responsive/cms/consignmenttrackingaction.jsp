<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<spring:url value="/consignment/${trackingUrlFragment}/tracking" var="consignmentTrackingUrl"/>
<div class="label-order">
	<a id="consignment-tracking-link" href="javascript:;" class="btn btn-default btn-block" data-url="${consignmentTrackingUrl}"
		data-colorbox-title="<spring:theme code='text.account.order.consignment.tracking.events.title' />">
		<spring:theme code="text.account.order.consignment.tracking.button" text="Track Package"/>
	</a>
</div>
<c:remove var="trackingUrlFragment" />