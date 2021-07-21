<%--
  Created by IntelliJ IDEA.
  User: koyou
  Date: 2021-07-21
  Time: 오후 2:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>사용자 로그인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="./css/app.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/springmvc/v2/header.jsp" %>
<div class="formTemplate">
    <form action="./app/springmvc/v2/user/userLogin" method="post">
        <table class="loginForm">
            <tbody>
            <tr>
                <td>
                    <input type="text" name="id" value="${id}" placeholder="아이디 입력" required autofocus/>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="password" name="password"  required />
                </td>
            </tr>
            <tr>
                <td>
                    <button type="submit" class="btnA">로그인</button>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>
