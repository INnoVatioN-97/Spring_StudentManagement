<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/springmvc/v2/headerNav.jsp" %>
    <title>홈화면</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main>
    <c:choose>
        <c:when test="${!empty sessionScope.USER}">
    상단의 네비게이션 바를 이용해 원하는 화면으로 이동하세요.
        </c:when>
        <c:otherwise>
            먼저 로그인 하세요.
        </c:otherwise>
    </c:choose>
</main>
</body>
</html>
