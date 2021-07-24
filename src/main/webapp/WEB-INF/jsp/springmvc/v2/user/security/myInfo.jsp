<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>내 정보</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="./css/app.css">
</head>
<body>
<%@include file="/WEB-INF/jsp/springmvc/v2/headerNav.jsp" %>
<main>
    <c:choose>
        <%--로그인 했고, 동시에 세션에 로그인 된 USER의 ID와 myInfo의 ID가 같은지--%>
        <c:when test="${!empty sessionScope.USER}">
            <h3>내 정보</h3>
            <ul class="myInfo">
                <li><label>학번 / 교번</label> ${requestScope.get('userObj').id}</li>
                <li><label>구분</label>
                    <c:choose>
                        <c:when test="${requestScope.get('userObj').classification eq 'staff'}">
                            교직원
                        </c:when>
                        <c:when test="${requestScope.get('userObj').classification eq ('root')}">
                            관리자
                        </c:when>
                        <c:otherwise>
                            학생
                        </c:otherwise>
                    </c:choose>
                </li>
                <li><label>이름</label>${requestScope.get('userObj').name}</li>
                <li><label>학과</label>${requestScope.get('userObj').majorName}</li>
            </ul>
        </c:when>
        <c:otherwise>
            <c:redirect url="/" />
        </c:otherwise>
    </c:choose>
</main>
</body>
</html>
