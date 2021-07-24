package kr.ac.mjc.youngil.web.dao;

import lombok.Data;

@Data
public class Subject {
    String subjectCode;
    String majorCode;
    String subjectName;
    String professorId; // 이 과목 담당 교수의 교번

    // 과목 목록 출력시 보여줄 요소들
    String professorName;
    String majorName;
}
