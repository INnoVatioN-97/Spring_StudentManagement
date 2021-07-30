<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 정보 등록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="./css/user.css">
</head>
<body>
    <main>
        <h3>
            회원 등록
        </h3>
        <form action="./app/springmvc/v2/user/security/addUser" method="post">
            <p><input type="text" name="id" placeholder="학번/교번" required autofocus/></p>
            <p>구분 :
                <label>
                    <select name="classification" size="1">
                        <option value="student">학생</option>
                        <option value="staff">교직원</option>
                    </select>
                </label>
            </p>
            <p><input type="text" name="name" placeholder="이름" required/></p>
            <p><input type="password" name="password" placeholder="비밀번호" required/> </p>
            <p>
                <label>
                    <select name="majorCode" size="1">
                        <c:forEach var="major" items="${majorNameList}">
                            <option value="${major.majorCode}">${major.majorName}</option>
                        </c:forEach>
                    </select>
                </label>
            </p>
            <p>성별 :
                <select name="gender" size="1">
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                    <option value="Non-Binary">일단 둘다 아님.</option>
                </select>
            </p>
            <p><input type="date" name="birthDay" placeholder="생년월일" required/></p>
            <p>
                <button type="submit" class="button a">가입 하기</button>
                <button type="button" onclick="history.back();" class="button b">취소
                </button>
            </p>
        </form>
        <p class="warn">${msg}</p>
    </main>
</body>
</html>