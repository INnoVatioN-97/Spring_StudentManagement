package kr.ac.mjc.youngil.web.dao;

import lombok.Data;

@Data
public class User {
    String id;
    String classification;
    String password;
    String name;
    String gender;
    String birthDay;
    String majorCode;

    String majorName; // 평상시에는 안담겨있다가 목록출력시 가져와진다.
}
