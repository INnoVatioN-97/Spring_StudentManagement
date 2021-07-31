package kr.ac.mjc.youngil.web.dao;

import lombok.Data;

@Data
public class StudentSubject {
    String id;
    String subjectCode;
    String score;

    //VO 역할
    String majorCode, majorName, subjectName, name;
}
