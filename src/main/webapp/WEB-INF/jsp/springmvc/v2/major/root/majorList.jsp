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
    <title>전체 학과 목록 (관리자용)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main>
    <c:choose>
        <c:when test="${!empty sessionScope.USER && sessionScope.USER.id eq 'root'}">
            <h3 align="center">전체 학과 목록</h3>
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
                <a href="./app/springmvc/v2/major/root/addMajor">학과 추가하기</a>
                <table>
                    <thead>
                    <tr>
                        <td>학과코드</td>
                        <td>학과명</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="major" items="${majorList}">
                        <tr>
                            <td>${major.majorCode}</td>
                            <td>
                                <a href="./app/springmvc/v2/user/security/preMajorInfo?majorCode=${major.majorCode}">${major.majorName}</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <c:redirect url="/"/>
        </c:otherwise>
    </c:choose>
</main>
<script>
    let btns = document.btns;
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