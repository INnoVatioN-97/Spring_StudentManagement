<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학과 추가화면</title>
</head>
<body>
<main>
    <h3 align="center">학과 추가 화면 (addMajor.jsp)</h3>
    <%--    addMajorAction--%>
    <form action="${pageContext.request.contextPath}/app/springmvc/v2/major/root/addMajorAction" method="post">
        <p>
            <input type="text" name="majorCode" placeholder="학과코드" required autofocus/>
        </p>
        <p>
            <input type="text" name="majorName" placeholder="학과명" required/>
        </p>
        <p>
            <button type="submit" class="buttonAdd">학과 추가하기</button>
            <button type="button" onclick="history.back();" class="buttonCancel">취소</button>
        </p>
    </form>
</main>
</body>
</html>
