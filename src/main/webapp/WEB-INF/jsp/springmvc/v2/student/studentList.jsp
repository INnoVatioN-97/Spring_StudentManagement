<%--JSTL 에서 제공하는 C, E 태그를 사용할 수 있게 선언.
    JSTL 은 JSP 에서 사용되는 반복, 조건, 데이터 관리, DB 접근,
    시간, 숫자, 날짜, 문자열 가공 등을 사용할 수 있는
    표준 라이브러리 이다.
    출처: https://hackersstudy.tistory.com/42
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<%--param으로 전달받은 page와 count값이 안왔으면 자동으로 1, 20으로 설정--%>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<c:set var="count" value="${empty param.count ? 20 : param.count}"/>
<c:set var="maxPage" value="${Math.ceil(totalCount / count).intValue()}"/>
<!DOCTYPE html>
<html>
<head>
    <title>학생 목록</title>
    <%--너비를 화면에 맞게 조절--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">
</head>
<body>
<%--    <%@ include file="Navigation 페이지 아직 안만듬."%>--%>
<main>
    <h3>학생 목록</h3>
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
        <a href="./app/springmvc/v2/student/studentForm" class="addStudentBtn">학생 추가하기</a>
    </form>
    <div class="list_student">
        <c:forEach var="student" items="${studentList}">
            <div>
                <div class="item1">${student.studentId}</div>
                <div class="item2">${student.name}</div>
                <div class="item3">${student.gender}</div>
                <div class="item4">${student.major}</div>
                <div class="item5">${student.birthDay}</div>
            </div>

            <%--                <div class="item2"><a--%>
            <%--                        href="./app/springmvc/v2/student/viewStudent?studentId=${student.studentId}">${e:forHtml(student.name)}</a>--%>
            <%--                </div>--%>
            <%--                <div class="item3"><a--%>
            <%--                        href="./app/springmvc/v2/user/userInfo?userId=${article.userId}">${article.name}</a>--%>
            <%--                </div>--%>
            <%--                <div class="item4">${article.udate}</div>--%>
        </c:forEach>
    </div>
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
</body>
</html>