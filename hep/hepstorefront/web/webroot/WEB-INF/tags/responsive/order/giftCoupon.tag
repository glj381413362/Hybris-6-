<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="giftCoupon" required="true" type="de.hybris.platform.commercefacades.coupon.data.CouponData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<c:if test="${not empty giftCoupon}">
	<div class="gift__coupon">
		<ycommerce:testId code="checkout_orderConfirmation_giftCoupon">

			<span class="gift__coupon--title">
                <spring:theme code="checkout.orderConfirmation.get.coupon"/>
            </span>
			<span class="gift__coupon--name">
			    ${fn:escapeXml(giftCoupon.name)}
            </span>
			<span class="gift__coupon--code">
                <spring:theme code="checkout.orderConfirmation.coupon.code" arguments="${giftCoupon.couponCode}"/>
            </span>
			
		</ycommerce:testId>
	</div>
</c:if>