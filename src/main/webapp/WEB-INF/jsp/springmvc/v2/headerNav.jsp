<%@ page import="kr.ac.mjc.youngil.web.dao.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul class="nav">
    <c:choose>
        <%--로그인을 했을 경우--%>
        <c:when test="${!empty sessionScope.USER}">
            <c:choose>
                <c:when test="${sessionScope.USER.classification.equalsIgnoreCase('staff')}">
                    <li style="color: white">
                        환영합니다, ${sessionScope.USER.name} 교수님
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/user/userList?target=student">내 정보</a>
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/user/userList?target=student">학생 목록</a>
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/user/s/logout">로그아웃</a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.USER.classification.equalsIgnoreCase('root')}">
                    <li style="color: white">
                        환영합니다, 관리자님
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/user/s/userList">전체 회원 목록</a>
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/major/addMajor">과목 추가</a>
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/major/majorList">전체 과목 목록</a>
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/user/s/logout">로그아웃</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li style="color: white">
                        환영합니다, ${sessionScope.USER.name} 학생
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/student/studentInfo">내 정보</a>
                    </li>
                    <li>
                        <a href="./app/springmvc/v2/user/s/logout">로그아웃</a>
                    </li>
                </c:otherwise>
            </c:choose>
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