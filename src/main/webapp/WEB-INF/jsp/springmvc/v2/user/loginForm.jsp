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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/springmvc/v2/header.jsp" %>
<div class="loginForm">
    <form action="./app/springmvc/v2/user/userLoginAction" method="post" id="form1">
        <table>
            <tbody>
            <tr>
                <td colspan="6" id="loginText">로그인</td>
            </tr>
            <tr>
                <td colspan="4">
                    <input type="text" name="id" value="${id}" placeholder="아이디 입력" required autofocus/>
                </td>
                <td rowspan="2">
                    <button type="submit" class="btnLogin">로그인</button>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <input type="password" name="password"  required />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <button class="btnBack" onclick="location.href='${pageContext.request.contextPath}/'">돌아가기</button>
                </td>
                <td colspan="3">
                    <button type="submit" class="btnB" id="btnGoJoin">회원가입</button>
                </td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="returnUrl"
               value="${!empty param.returnUrl? param.returnUrl : header.referer}"/>
    </form>
    <p class="warn">${msg}</p>
</div>
</body>
<script>
    var btnGoJoin = document.getElementById("btnGoJoin");
    btnGoJoin.onclick=  ()=> {
        location.href="./app/springmvc/v2/user/joinForm";
    };

</script>
</html>
