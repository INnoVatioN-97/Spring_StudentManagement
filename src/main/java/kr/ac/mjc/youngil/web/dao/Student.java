package kr.ac.mjc.youngil.web.dao;

import lombok.Data;

@Data
public class Student {
    int studentId;
    String password;
    String name;
    String gender;
    String birthDay;
    String major;
}
