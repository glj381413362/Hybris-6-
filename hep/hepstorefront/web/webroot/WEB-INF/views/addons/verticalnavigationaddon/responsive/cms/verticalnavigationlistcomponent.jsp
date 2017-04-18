<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">div.nav-bottom{display:none}</style>
<div id="vertical_navigation_bar">
	<c:forEach items="${components}" var="verticalBar">
		<cms:component component="${verticalBar}" evaluateRestriction="true" />
	</c:forEach>
</div>