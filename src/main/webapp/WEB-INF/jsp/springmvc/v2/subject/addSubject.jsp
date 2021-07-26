<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>과목 추가</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<div align="center">
    addSubject 페이지
    <div>
        ${major}
    </div>
    <div>
        ${professorList}
    </div>
</div>
    <div>
        <form action="./app/springmvc/v2/subject/addSubjectAction" method="post">
            <input type="text" value="${major.majorName}" disabled/>
            <input type="text" name="subjectName" placeholder="과목명" required autofocus/>
            <select name="professorId" size="1">
                <c:forEach var="professor" items="${professorList}">
                    <option value="${professor.id}">${professor.name}</option>
                </c:forEach>
            </select>
            <input type="hidden" name="majorCode" value="${major.majorCode}">
            <button type="submit">
                과목 등록
            </button>
        </form>
    </div>
</body>
</html>
