package kr.ac.mjc.youngil.web.dao;

import lombok.Data;

@Data
public class Student {
    int studentId;
    String name;
    String gender;
    String major;
    String birthDay;
}
