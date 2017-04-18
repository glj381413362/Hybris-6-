<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/responsive/formElement"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/responsive/nav" %>

<c:set var="searchUrl" value="/my-account/my-interests?sort=${searchPageData.pagination.sort}"/>

<div class="account-section-header">
	<spring:theme code="text.account.myInterests" text="My Interests" />
</div>
<c:choose>
	<c:when test="${not empty searchPageData.results}">
	   	<div class="account-orderhistory-pagination">
	        <nav:pagination top="true" msgKey="text.account.myInterests.page" showCurrentPageInfo="true" hideRefineButton="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchUrl}"  numberPagesShown="${numberPagesShown}"/>
        </div>
		 <ul class="item__list item__list__cart">
		    <li class="hidden-xs hidden-sm">
		        <ul class="item__list--header">
		            <li class="item__toggle"></li>
		            <li class="item__image"></li>
		            <li class="item__info my-interest"><spring:theme code="text.account.myInterests.product"/></li>
		            <li class="item__price"><spring:theme code="text.account.myInterests.price"/></li>
		            <li class="item__price"><spring:theme code="text.account.myInterests.addedDate"/></li>
		            <li class="item__price"><spring:theme code="text.account.myInterests.notificaiton"/></li>
		            <li class="item__remove"></li>
		        </ul>
		    </li>
		
		    <c:forEach items="${searchPageData.results}" var="entry" varStatus="loop">
		
		        <c:url value="${entry.productData.url}" var="productUrl"/>
		    
		        <li class="item__list--item">
		            <%-- chevron for multi-d products --%>
		            <div class="hidden-xs hidden-sm item__toggle"></div>

		            <%-- product image --%>
		            <div class="item__image">
			            <ycommerce:testId code="test_searchPage_wholeProduct">
							<a href="${productUrl}"> 
								<product:productPrimaryImage product="${entry.productData}" format="thumbnail" />
							</a>
						</ycommerce:testId>
		            </div>
		
		            <%-- product name, code, availability --%>
		            <div class="item__info">
						<ycommerce:testId code="searchPage_productName_link_${entry.productData.code}">
		                    <a href="${productUrl}"><span class="item__name">${entry.productData.name}</span></a>
		                </ycommerce:testId>
		
		                <div class="item__code">
							<c:set value="${entry.productData.code}" var="productCode" />
		                	<c:out value="${productCode}" />
		                </div>
		
		                <%-- availability --%>
		                <div class="item__stock">
							<ycommerce:testId code="searchPage_productName_link_${entry.productData.code}">
			                    <c:set var="entryStock" value="${entry.productData.stock.stockLevelStatus.code}"/>
			                    <c:forEach items="${entry.productData.baseOptions}" var="option">
			                        <c:if test="${not empty option.selected and option.selected.url eq entry.productData.url}">
			                            <c:forEach items="${option.selected.variantOptionQualifiers}" var="selectedOption">
			                                <div>
			                                    <strong>${selectedOption.name}:</strong>
			                                    <span>${selectedOption.value}</span>
			                                </div>
			                                <c:set var="entryStock" value="${option.selected.stock.stockLevelStatus.code}"/>
			                            </c:forEach>
			                        </c:if>
			                    </c:forEach>
			
			                    <div>
			                        <c:choose>
			                            <c:when test="${not empty entryStock and entryStock eq 'inStock'}">
			                                <span class="stock instock"><spring:theme code="product.variants.in.stock"/></span>
			                            </c:when>
			                            <c:when test="${not empty entryStock and entryStock eq 'lowStock'}">
			                                <span class="stock lowstock"><spring:theme code="product.variants.low.stock"/></span>
			                            </c:when>
			                            <c:otherwise>
			                                <span class="out-of-stock">
			                                	<spring:theme code="product.variants.out.of.stock"/>
			                                </span>
			                            </c:otherwise>
			                        </c:choose>
			                    </div>
			                    
								<c:if test="${empty entryStock or entryStock eq 'outOfStock' and not empty entry.productData.futureStocks}">
				                    <div>
										<span class="stockSpan">
											<spring:theme code="text.account.myInterests.estimatedAvailability" />
											<fmt:formatDate value="${entry.productData.futureStocks[0].date}" pattern="yyyy/MM/dd" />
										</span>
				                    </div>
								</c:if>
							</ycommerce:testId>
		                </div>
		            </div>
		
		            <%-- price --%>
		            <div class="item__price">
		                <c:out value="${entry.productData.price.formattedValue}" />
		            </div>
		
		            <%-- added date --%>
		            <div class="item__price">
						<c:forEach items="${entry.productInterestDetail}" var="productInterest">
							<fmt:formatDate value="${productInterest.dateAdded}" pattern="yyyy/MM/dd" />
						</c:forEach>
		            </div>
		
		            <%-- notification --%>
		            <div class="item__price">
						<c:forEach items="${entry.productInterestDetail}" var="productInterest" varStatus="status">
							<spring:message code="text.${productInterest.interestType}.title" text="Notification" var="title" />
							<spring:message code="text.${productInterest.interestType}.type.label" text="Notification" var="notificaitonTypeLabel" />
							<div class="notificaitonPanel">
								<input type="checkbox" name="notificaiton-checkbox-default" disabled
									id="notificaiton-checkbox-default${loop.index}${status.index}"
									class="notificaitonCheckbox" autocomplete="off" checked="${productInterest.enabled}"
									data-title="${title}" data-productCode="${productCode}" data-notificationType="${productInterest.interestType}" />
								<div class="btn-group">
									<label id="notificaiton-checkbox-label${loop.index}${status.index}"
										class="btn btn-checkbox notificaiton-checkbox btn-notificaiton"
										data-title="${title}" data-productCode="${productCode}"
										data-notificationType="${productInterest.interestType}">
										<span class="glyphicon glyphicon-ok"></span>
										<span></span>
									</label> 
									<label id="notificaiton-type-label${loop.index}${status.index}"
										class="btn btn-label active notificaiton-label btn-notificaiton"
										data-title="${title}" data-productCode="${productCode}"
										data-notificationType="${productInterest.interestType}">
										${notificaitonTypeLabel}
									</label>
								</div>
							</div>
						</c:forEach>
		            </div>
		
		            <%-- remove icon --%>
		            <div class="item__remove">
	                    <button class="btn remove-interests-for-product" id="removeEntry_${loop.index}">
	                        <span class="glyphicon glyphicon-remove" data-productCode="${productCode}"></span>
	                    </button>
		            </div>
		        </li>
		        <li></li>
		    </c:forEach>
		</ul>
		<div class="account-orderhistory-pagination">
			<nav:pagination top="false" msgKey="text.account.myInterests.page" showCurrentPageInfo="true" hideRefineButton="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchUrl}"  numberPagesShown="${numberPagesShown}"/>
		</div>
	</c:when>
	<c:otherwise>
		<div class="account-section-content content-empty">
			<spring:theme code="text.account.noInterests" text="You Have Not Add Any Interests Now" />
		</div>
	</c:otherwise>
</c:choose>