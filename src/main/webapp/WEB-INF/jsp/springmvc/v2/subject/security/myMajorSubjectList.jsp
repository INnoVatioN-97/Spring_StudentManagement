<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<%--param으로 전달받은 page와 count값이 안왔으면 자동으로 1, 20으로 설정--%>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<c:set var="count" value="${empty param.count ? 20 : param.count}"/>
<c:set var="maxPage" value="${Math.ceil(totalCount / count).intValue()}"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/springmvc/v2/headerNav.jsp" %>
    <title>우리 학과 과목 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>

<div class="list">
    <p>총 ${totalCount}건, ${maxPage}페이지</p>
    <form name="btns" method="get">
        <p class="pagebar">
            <a href="javascript:window.history.back();">
                돌아가기
            </a>
            <a href="${pageContext.request.contextPath}/app/springmvc/v2/major/preAddSubject1?majorCode=${major.majorCode}">과목
                추가
            </a>
            <%--page 가 1 이하일 경우 이전 버튼은 disbled 시킨다.--%>
            <button id="btnPrev" type="submit" class="button b"
                    <c:if test="${page <=1}"> disabled </c:if>>&lt;
            </button>
            <input type="text" name="page" value="${page}" min="1"
                   max="${maxPage}" readonly/>
            <button id="btnNext" type="submit" class="button b"
                    <c:if test="${page>= maxPage}">disabled</c:if> >&lt;
            </button>
            <input type="number" name="count" value="${count}" min="10" step="10"/>행씩

        </p>
    </form>

<form id="form1" action="/app/springmvc/v2/subject/deleteSubject" method="post">
    <table>
        <thead>
        <tr>
            <th colspan="6">
                ${subjectList.get(0).majorName} 과목 목록
            </th>
        </tr>
        <tr>
            <%--            majorName  | majorCode | subjectCode | subjectName       | professorId | professorName--%>
            <td>과목코드</td>
            <td>과목명</td>
            <td>담당교수</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="subject" items="${subjectList}">
            <tr>
                <td>${subject.subjectCode} </td>
                <td>${subject.subjectName}</td>
                <td>${subject.professorName}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <input type="text" name="majorCode" value="${major.majorCode}" hidden/>
</form>
</div>
</body>
</html>
