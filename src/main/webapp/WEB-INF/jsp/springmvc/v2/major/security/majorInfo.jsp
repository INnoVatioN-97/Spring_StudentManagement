<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${major.majorName} 상세정보</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main>
    <%@ include file="/WEB-INF/jsp/springmvc/v2/headerNav.jsp" %>

    <div align="center">${major.majorName} 상세정보</div>
    <ul class>
        <li><label>총원</label> ${studentCount+staffCount} 명 (교직원 수 ${staffCount}명 / 학생 수 ${studentCount}명)</li>
        <li><label>개설 과목</label> 총 ${subjectCount} 과목</li>
        <li><label>학과 창설 일자</label> ${major.setupDate}</li>
    </ul>
    <c:choose>
        <c:when test="${!empty sessionScope.USER && sessionScope.USER.id eq 'root' or 'staff'}">
            <c:choose>
                <c:when test="${!empty subjectList}">
                    <h3 align="center">${major.majorName} 과목 목록</h3>
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
                        <a href="javascript:window.history.back();">돌아가기</a>
                        <a href="${pageContext.request.contextPath}/app/springmvc/v2/major/preAddSubject1?majorCode=${major.majorCode}">과목 추가</a>
                        <%@ include file="/WEB-INF/jsp/springmvc/v2/subject/subjectList.jsp"%>
<%--                        <table>--%>
<%--                            <thead>--%>
<%--                            <tr>--%>
<%--                                <td>과목코드</td>--%>
<%--                                <td>전공명</td>--%>
<%--                                <td>교번</td>--%>
<%--                                <td>담당교수</td>--%>
<%--                            </tr>--%>
<%--                            </thead>--%>

<%--                            <tbody>--%>
<%--                                &lt;%&ndash;subjectCode | subjectName | professorId | professorName&ndash;%&gt;--%>
<%--                            <c:forEach var="subject" items="${subjectList}">--%>
<%--                                &lt;%&ndash;                관리자 계정은 보이지 않게.&ndash;%&gt;--%>
<%--                                <tr>--%>
<%--                                    <td>${subject.subjectCode}</td>--%>
<%--                                    <td>${subject.subjectName}</td>--%>
<%--                                    <td>${subject.professorId}</td>--%>
<%--                                    <td>${subject.professorName}</td>--%>
<%--                                </tr>--%>
<%--                            </c:forEach>--%>
<%--                            </tbody>--%>
<%--                        </table>--%>
                    </div>
                </c:when>
                <c:otherwise>
                    <div>현재 이 학과에는 개설된 강좌가 없습니다.</div>
                    <a href="javascript:window.history.back();">돌아가기</a>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:redirect url="/"/>
        </c:otherwise>
    </c:choose>
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