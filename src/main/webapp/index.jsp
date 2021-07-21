<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Index Page</title>
</head>
<body>
<main>

<div>
    Index.jsp 입니다.
</div>
<%--<p><a href="./app/springmvc/v2/student/studentList">Spring Web MVC V2 - Not--%>
<%--    Using--%>
<%--    Sevlet API</a></p>--%>
<%
//    response.sendRedirect("./app/springmvc/v2/student/studentLogin");

    response.sendRedirect("./app/springmvc/v2/user/userList");
%>

</main>
<%--<%@ include file="/WEB-INF/jsp/springmvc/v2/footer.jsp" %>--%>
</body>
</html>
