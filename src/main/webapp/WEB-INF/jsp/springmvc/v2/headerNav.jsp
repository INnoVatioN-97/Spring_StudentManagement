<%@ page import="kr.ac.mjc.youngil.web.dao.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul class="nav">
    <c:choose>
        <%--로그인을 했을 경우--%>
        <c:when test="${!empty sessionScope.USER}">
            <%
                User user = (User)session.getAttribute("USER");
                if(user.getClassification().equalsIgnoreCase("staff"))
            %>
            <li>
                <a href="./app/springmvc/v2/user/studentList">학생 목록</a>
            </li>
        </c:when>
        <%-- 로그인을 안한 경우 --%>
        <c:otherwise>
            <li>
                <a href="./app/springmvc/v2/user/loginForm">로그인</a>
            </li>
            <li>
                <a href="./app/springmvc/v2/user/joinForm">회원가입</a>
            </li>
        </c:otherwise>
    </c:choose>
    <
</ul>