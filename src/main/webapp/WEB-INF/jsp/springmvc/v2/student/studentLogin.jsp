<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<header>
    <a href="./">To Home</a>
</header>
<ul class="nav">
    <c:choose>
        <%--로그인을 했을 경우--%>
        <c:when test="${!empty sessionScope.USER}">
            <li>
                <a href="./app/springmvc/v2/student/studentList">학생 목록</a>
            </li>
        </c:when>
        <%-- 로그인을 안한 경우 --%>
        <c:otherwise>
            <li>
                <a href="./app/springmvc/v2/student/studentLogin">로그인</a>
            </li>
            <li>
                <a href="./app/springmvc/v2/student/studentForm">회원가입</a>
            </li>
        </c:otherwise>
    </c:choose>
    <
</ul>