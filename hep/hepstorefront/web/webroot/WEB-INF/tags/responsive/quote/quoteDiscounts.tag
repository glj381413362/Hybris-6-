<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<%--
    ~ /*
    ~  * [y] hybris Platform
    ~  *
    ~  * Copyright (c) 2000-2017 SAP SE or an SAP affiliate company.
    ~  * All rights reserved.
    ~  *
    ~  * This software is the confidential and proprietary information of SAP
    ~  * ("Confidential Information"). You shall not disclose such Confidential
    ~  * Information and shall use it only in accordance with the terms of the
    ~  * license agreement you entered into with SAP.
    ~  *
    ~  */
--%>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:set var="quoteData" value="${cartData.quoteData}"/>
<spring:url value="/quote/{/quoteCode}/discount/apply" var="quoteDiscountApplyAction" htmlEscape="false">
    <spring:param name="quoteCode"  value="${quoteData.code}"/>
</spring:url>

<c:if test="${not empty quoteData}">
	<c:if test="${ycommerce:isQuoteUserSalesRep() && !disableUpdate}">
		<div class="col-xs-12 cart-totals-right text-right">
			<a href="#" class="js-quote-discount-link"> <spring:theme code="basket.page.quote.discounts.link" /></a>
			<div style="display: none">
				<spring:theme code="text.quote.discount.modal.title" arguments="${quoteData.code}" var="discountModalTitle" />
				<div id="js-quote-discount-modal"
					data-quote-modal-title="${discountModalTitle}"
					data-quote-modal-total="${fn:escapeXml(cartData.subTotalWithoutQuoteDiscounts.value)}"
					data-quote-modal-quote-discount="${fn:escapeXml(cartData.quoteDiscounts.value)}"
					data-quote-modal-currency="${fn:escapeXml(currentCurrency.symbol)}">
					<div class="quote-discount__modal">
						<form:form id="quoteDiscountForm"
							action="${quoteDiscountApplyAction}" method="post"
							commandName="quoteDiscountForm">
							<div class="row">
								<div class="col-xs-6 col-sm-7">
									<label class="quote-discount__modal--label text-left"> <spring:theme code="text.quote.discount.by.percentage" /></label>
								</div>
								<div class="col-xs-6 col-sm-5">
									<div class="input-group quote-discount__modal--input">
										<span class="quote-discount__modal--input__label">%</span> 
										<input type="text" min="0" max="100" step="any" class="form-control input-sm pull-right text-right" name="quote-discount-by-percentage" id="js-quote-discount-by-percentage" maxlength="10" />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-6 col-sm-7">
									<label class="quote-discount__modal--label text-left"> <spring:theme code="text.quote.discount.by.amount" /></label>
								</div>
								<div class="col-xs-6 col-sm-5">
									<div class="input-group quote-discount__modal--input">
										<span class="quote-discount__modal--input__label">$</span> 
										<input type="text" step="any" class="form-control input-sm pull-right text-right" name="quote-discount-by-amount" id="js-quote-discount-by-amount" maxlength="10" />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-6 col-sm-7">
									<label class="quote-discount__modal--label text-left"> <spring:theme code="text.quote.discount.adjust.total" /></label>
								</div>
								<div class="col-xs-6 col-sm-5">
									<div class="input-group quote-discount__modal--input">
										<span class="quote-discount__modal--input__label">$</span> 
										<input type="text" step="any" class="form-control input-sm pull-right text-right" name="quote-discount-adjust-total" id="js-quote-discount-adjust-total" maxlength="10" />
									</div>
								</div>
							</div>

							<div class="quote-discount__modal--original__total">
								<div class="row">
									<div class="col-xs-6 text-left">
										<spring:theme code="basket.page.totals.quote.total.original" />
									</div>

									<div class="col-xs-6 text-right">
										<format:price priceData="${cartData.subTotalWithoutQuoteDiscounts}" />
									</div>
								</div>
							</div>
							<div class="quote-discount__modal--new__total">
								<div class="row">
									<div class="col-xs-6 text-left">
										<spring:theme code="basket.page.totals.quote.total.after.discount" />
									</div>
									<div class="col-xs-6 text-right" id="js-quote-discount-new-total">
										<format:price priceData="${cartData.subTotal}" />
									</div>
								</div>
							</div>

							<form:input type="hidden" name="quote-discount-rate" id="js-quote-discount-rate" value="0" maxlength="10" path="discountRate" />
							<form:input type="hidden" name="quote-discount-type" id="js-quote-discount-type" maxlength="10" path="discountType" />

                            <button type="submit" class="btn btn-primary btn-block" id="submitButton">
                                <spring:theme code="text.quote.done.button.label" />
                            </button>
							<button type="button" class="btn btn-default btn-block" id="cancelButton">
								<spring:theme code="text.quote.cancel.button.label" />
							</button>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</c:if>