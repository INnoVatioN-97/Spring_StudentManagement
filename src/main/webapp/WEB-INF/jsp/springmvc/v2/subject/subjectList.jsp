<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>

<a href="javascript:window.history.back();">
    돌아가기
</a>
<a href="${pageContext.request.contextPath}/app/springmvc/v2/major/preAddSubject1?majorCode=${major.majorCode}">과목
    추가
</a>
<form id="form1" action="/app/springmvc/v2/subject/deleteSubject" method="post">
    <table>
        <thead>
        <tr>
            <td>과목코드</td>
            <td>전공명</td>
            <td>교번</td>
            <td>담당교수</td>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="subject" items="${subjectList}">
            <tr>
                <td>${subject.subjectCode} </td>
                <td>${subject.subjectName}</td>
                <td>${subject.professorId}</td>
                <td>${subject.professorName}
                    <button class="btnB" id="btnDel" name="subjectCode" value="${subject.subjectCode}"
                            onclick="delAction('${subject.subjectCode}', '${subject.subjectName}')">삭제
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <input type="text" name="majorCode" value="${major.majorCode}" hidden/>
</form>
</body>
<script>
    btnDel = document.getElementById('btnDel');
    const delAction = (subjectCode, subjectName) => {
        console.log(subjectCode + ' 눌림');
        let isDelete = confirm(subjectName + '과목을 삭제할까요?');
        if (isDelete) {
            const form = document.getElementById('form1');
            form.submit();
            alert(subjectName+'과목을 삭제했습니다.');
        }
    }
</script>
</html>
