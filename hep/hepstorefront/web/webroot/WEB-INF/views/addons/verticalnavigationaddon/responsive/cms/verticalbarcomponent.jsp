<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<ul id="banner_menu_wrap">
	<c:forEach var="navNode" items="${navNodes}">
		<li>
			<a href="<c:url value='${navNode.entries[0].item.url}'/>">
				<c:out value="${navNode.title}" />
			</a>
			<div class="banner_menu_content">
				<ul>
					<c:forEach var="subNavNode" items="${navNode.children}">
						<c:choose>
							<c:when test="${not empty subNavNode.children}">
								<c:forEach items="${subNavNode.children}" var="subNavNodeChild">
									<c:forEach items="${subNavNodeChild.entries}" var="subNavNodeEntry">
										<c:set var="subNavNodeLink" value="${subNavNodeEntry.item}" />
										<c:set var="isThumbnailOnly" value="${subNavNodeLink.thumbnailOnly}" />
										<li <c:if test="${isThumbnailOnly}">class="thumbnail_only"</c:if>>
											<a href="<c:url value='${subNavNodeLink.url}'/>" title="${subNavNodeLink.linkName}">
												<img alt="${subNavNodeLink.linkName}" src="${subNavNodeLink.thumbnail.downloadURL}" />
												<c:if test="${not isThumbnailOnly}">
													<c:out value="${subNavNodeLink.linkName}" />
												</c:if>
											</a>
										</li>
									</c:forEach>
								</c:forEach>
							</c:when>
							<c:when test="${not empty subNavNode.entries}">
								<c:forEach items="${subNavNode.entries}" var="subNavNodeEntry">
									<c:set var="subNavNodeLink" value="${subNavNodeEntry.item}" />
									<c:set var="isThumbnailOnly" value="${subNavNodeLink.thumbnailOnly}" />
									<li <c:if test="${isThumbnailOnly}">class="thumbnail_only"</c:if>>
										<a href="<c:url value='${subNavNodeLink.url}'/>" title="${subNavNodeLink.linkName}">
											<img alt="${subNavNodeLink.linkName}" src="${subNavNodeLink.thumbnail.downloadURL}" />
											<c:if test="${not isThumbnailOnly}">
												<c:out value="${subNavNodeLink.linkName}" />
											</c:if>
										</a>
									</li>
								</c:forEach>
							</c:when>
						</c:choose>
					</c:forEach>
				</ul>
			</div>
		</li>
	</c:forEach>
</ul>
