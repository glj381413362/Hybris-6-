<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<spring:url value="/checkout/multi/summary/placeOrder"
	var="placeOrderUrl" />
<spring:url value="/checkout/multi/termsAndConditions"
	var="getTermsAndConditionsUrl" />

<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">


	
	<div class="row">
		<div class="col-sm-6">
			<div class="checkout-headline">
				<spring:theme code="checkout.multi.secure.checkout"
					text="Secure Checkout"></spring:theme>
			</div>
			<multi-checkout:checkoutSteps checkoutSteps="${checkoutSteps}"
				progressBarId="${progressBarId}">
				<ycommerce:testId code="checkoutStepFour">
					<div class="checkout-review">
						<div class="hidden-xs">
							<div class="checkout-order-summary">
								<multi-checkout:orderTotals cartData="${cartData}"
									showTaxEstimate="${showTaxEstimate}" showTax="${showTax}"
									subtotalsCssClasses="dark" />
							</div>
							<form:form action="${placeOrderUrl}" id="placeOrderForm1"
								commandName="placeOrderForm">
								<div class="checkbox">
									<label> <form:checkbox id="Terms1" path="termsCheck" />
										<spring:theme
											code="checkout.summary.placeOrder.readTermsAndConditions"
											arguments="${getTermsAndConditionsUrl}"
											text="Terms and Conditions" />
									</label>
								</div>

								<button id="placeOrder" type="submit"
									class="btn btn-primary btn-place-order btn-block">
									<spring:theme code="checkout.summary.placeOrder"
										text="Place Order" />
								</button>
							</form:form>
						</div>
					</div>
				</ycommerce:testId>
			</multi-checkout:checkoutSteps>
		</div>
		
		
    	<div class="col-sm-6">
			<div class="checkout-headline hidden-xs">
				<spring:theme code="checkout.multi.order.summary"
					text="Order Summary" />
			</div>
			<div class="checkout-order-summary">
				<ycommerce:testId code="orderSummary">
					<multi-checkout:deliveryCartItems cartData="${cartData}"
						showDeliveryAddress="true" />

					<c:forEach items="${cartData.pickupOrderGroups}" var="groupData"
						varStatus="status">
						<multi-checkout:pickupCartItems cartData="${cartData}"
							groupData="${groupData}" index="${status.index}" showHead="true" />
					</c:forEach>

					<c:if test="${not empty cartData.chinesePaymentInfo}">
						<ul class="checkout-order-summary-list">
							<li class="checkout-order-summary-list-heading">
								<div class="title">
									<spring:theme code="checkout.multi.payment" text="Payment:"></spring:theme>
								</div>
								<div>
									<img src="${cartData.chinesePaymentInfo.paymentProviderLogo}"
										height="45px" class="payment-logo">
								</div>
							</li>
						</ul>
					</c:if>
					<multi-checkout:orderTotals cartData="${cartData}"
						showTaxEstimate="true" showTax="true" />
				</ycommerce:testId>
			</div>
			<div class="visible-xs">
				<div class="checkbox">
					<form:form action="${placeOrderUrl}" id="placeOrderForm1"
						commandName="placeOrderForm">
						<label> <form:checkbox id="Terms1" path="termsCheck" /> <spring:theme
								code="checkout.summary.placeOrder.readTermsAndConditions"
								arguments="${getTermsAndConditionsUrl}"
								text="Terms and Conditions" />
						</label>

						<button id="placeOrder" type="submit"
							class="btn btn-primary btn-place-order btn-block">
							<spring:theme code="checkout.summary.placeOrder"
								text="Place Order" />
						</button>
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-sm-12 col-lg-12">
        	<br class="hidden-lg">
			<cms:pageSlot position="SideContent" var="feature" element="div"
				class="checkout-help">
				<cms:component component="${feature}" />
			</cms:pageSlot>
		</div>
	</div>


</template:page>