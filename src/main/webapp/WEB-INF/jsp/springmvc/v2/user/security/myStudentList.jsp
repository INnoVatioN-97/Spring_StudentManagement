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
    <title>우리 학과 학생 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<%--    <%@ include file="Navigation 페이지 아직 안만듬."%>--%>
<main>
    <%
        if(session.getAttribute("USER") != null){
    %>
    <h3>우리 학과 학생 목록</h3>
    <p>총 ${totalCount}건, ${maxPage}페이지</p>
    <form name="btns" method="get">
        <p class="pagebar">
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
    <div class="list">
        <table>
            <thead>
            <tr>
                <th colspan="4"> 학생 목록</th>
            </tr>
            <tr>
<%--                id, name, gender, birthDay--%>
                <td>학번</td>
                <td>이름</td>
                <td>성별</td>
                <td>생년월일</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="student" items="${studentList}">
                <%--                관리자 계정은 보이지 않게.--%>
                    <tr>
                        <td>${student.id}</td>
                        <td>${student.name}</td>
                        <td>${student.gender}</td>
                        <td>${student.birthDay}</td>
                    </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <%
    }else{
    %>
    <div>
        <h3>
            먼저 로그인 하세요.
        </h3>
    </div>
    <%
        }
    %>
</main>
<%--<%@ include file="/WEB-INF/jsp/springmvc/v2/footer.jsp" %>--%>
<script>
    let btns = document.btns;
    // form1.getElementById("btnPrev").onclick = function () {
    //     form1.page.value--;
    // };
    const prev = () => {
        btns.page.value--;
    }
    const next = () => {
        btns.page.value++;
    }
    document.getElementById("btnPrev").onclick = prev;
    document.getElementById("btnNext").onclick = next;
    //숫자가 바뀌면 JS function 을 통해 submit()을 즉각 실행하도록.
    btns.count.onchange = function () {
        btns.submit();
    };
</script>
<%@ include file="/WEB-INF/jsp/springmvc/v2/footer.jsp" %>
</body>
</html>