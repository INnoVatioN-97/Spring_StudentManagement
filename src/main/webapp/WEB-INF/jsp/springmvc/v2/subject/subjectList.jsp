<html>
<body>
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
            <td>${subject.subjectCode}</td>
            <td>${subject.subjectName}</td>
            <td>${subject.professorId}</td>
            <td>${subject.professorName}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
