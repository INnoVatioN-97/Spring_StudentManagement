<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<c:set var="count" value="${empty param.count ? 20 : param.count}"/>
<c:set var="maxPage" value="${Math.ceil(totalCount / count).intValue()}"/>
<html>
<head>
    <title>${major.majorName} 상세정보</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main>
    <%@ include file="/WEB-INF/jsp/springmvc/v2/headerNav.jsp" %>

    <div align="center">${major.majorName} 상세정보</div>
    <ul class>
        <li><label>총원</label> ${studentCount+staffCount} 명 (교직원 수 ${staffCount}명 / 학생 수 ${studentCount}명)</li>
        <li><label>개설 과목</label> 총 ${subjectCount} 과목</li>
        <li><label>학과 창설 일자</label> ${major.setupDate}</li>
    </ul>
    <c:choose>
        <c:when test="${!empty sessionScope.USER && sessionScope.USER.id eq 'root' or 'staff'}">
            <c:choose>
                <c:when test="${!empty subjectList}">
                    <h3 align="center">${major.majorName} 과목 목록</h3>
                    <div class="list">
                        <%@ include file="/WEB-INF/jsp/springmvc/v2/subject/subjectList.jsp" %>
                    </div>
                </c:when>
                <c:otherwise>
                    <div>현재 이 학과에는 개설된 강좌가 없습니다.</div>
                    <a href="javascript:window.history.back();">돌아가기</a>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:redirect url="/"/>
        </c:otherwise>
    </c:choose>
</main>
<%@ include file="/WEB-INF/jsp/springmvc/v2/footer.jsp" %>
</body>
</html>