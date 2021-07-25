package kr.ac.mjc.youngil.web.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Repository : Entity에 의해 생성된 DB에 접근하는 메소드들을 사용하기 위한 인터페이스
 * -> 후술할 ADD_STUDENT 등과 같은 여러 SQL 명령어가 들어간 final String을 이용해
 * 학생 정보를 가져오든, 추가/제거 하든 하는 등의 메소드를 사용하도록 Annotation을 붙여주는 것.
 * <p>
 * 쉽게 말해 DB를 만들었고, 테이블까지 만들었으면 이제 거기에서 값을 가져오든, 말든 하는 등의
 * CRUD(Create Read, Update, Delete)를 해야 쓸모가 있으니까, 얘를 어찌 쓸지 정의해주는 계층
 */
@Repository
public class UserDao {
    //전체 학생 수
    private static final String COUNT_ALL_USERS = """
            select count(id) from user 
            """;

    //회원 정보 수정
    private static final String UPDATE_USER = """
            update user set name=:name, gender=:gender, major=:major, password=:password where id=:id
            """;

    //회원 삭제
    private static final String DELETE_USER = """
            delete from user where id=:id and password=:password
            """;

    //회원 추가
    private static final String ADD_USER = """
            insert user values(?, ?, sha2(?,256), ?, ?, ?, ?)
            """;

    // 전체 회원 목록 (관리자 제외)
    private static final String LIST_USERS = """
            select classification, id, name, gender, birthDay, majorCode,
            major.majorName majorName from user join major
            using (majorCode) order by majorName, classification, id limit ?,?
            """;

    // 내 정보 (특정 회원 조회)
    private static final String GET_USER = """
            select id, name, classification, gender, birthDay, majorCode, major.majorName majorName from user join major using(majorCode) where id=?
            """;

    //학과별 교직원 수 조회
    private static final String COUNT_OF_STAFFS_OF_MAJOR = """
            select count(id) from user where majorCode=? and classification='staff'
            """;

    //학과별 학생 수 조회
    private static final String COUNT_OF_STUDENTS_OF_MAJOR = """
            select count(id) from user where majorCode=? and classification='student'
            """;

    // 회원 로그인
    private static final String LOGIN_USER = """
            select id, password, name, classification, majorCode from user
            where(id, password) = (?, sha2(?, 256))
            """;

    private JdbcTemplate jdbcTemplate;
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private RowMapper<User> rowMapper = new BeanPropertyRowMapper<>(User.class);

    @Autowired
    public UserDao(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

    /**
     * 회원 목록
     */
    public List<User> listUsers(int offset, int count) {
        return jdbcTemplate.query(LIST_USERS, rowMapper, offset, count);
    }

    /**
     * 총 회원 수
     */
    public Integer countAllUsers() {
        return jdbcTemplate.queryForObject(COUNT_ALL_USERS, Integer.class);
    }

    /**
     * 회원 조회
     */
    public User getUser(String id) {
        return jdbcTemplate.queryForObject(GET_USER, rowMapper, id);
    }

    /**
     * 사용자 등록
     *
     * @throws DuplicateKeyException 이메일이 중복되어 사용자 등록에 실패할 경우
     */
    public void addUser(User user) throws DuplicateKeyException {
//        namedParameterJdbcTemplate
//                .update(ADD_USER, new BeanPropertySqlParameterSource(user));
        jdbcTemplate.query(ADD_USER, rowMapper, user.id, user.classification, user.password, user.name, user.gender, user.birthDay, user.majorCode);
    }

    /**
     * 회원 정보 수정
     *
     * @throws DuplicateKeyException 이메일이 중복되어 이메일 수정에 실패할 경우
     */
    public void updateUser(User user) throws DuplicateKeyException {
        namedParameterJdbcTemplate
                .update(UPDATE_USER, new BeanPropertySqlParameterSource(user));
    }

    /**
     * 회원 탈퇴
     */
    public void quitUser(int id) {
        namedParameterJdbcTemplate
                .update(DELETE_USER, new BeanPropertySqlParameterSource(id));
    }

    /**
     * 특정 학과 학생 수
     */
    public Integer countStudentOfMajor(String majorCode) {
        return jdbcTemplate.queryForObject(COUNT_OF_STUDENTS_OF_MAJOR, Integer.class, majorCode);
    }

    /**
     * 특정 학과 교직원 수
     */
    public Integer countStaffOfMajor(String majorCode) {
        return jdbcTemplate.queryForObject(COUNT_OF_STAFFS_OF_MAJOR, Integer.class, majorCode);
    }

    /**
     * 회원 로그인
     */
    public User login(String id, String password) throws EmptyResultDataAccessException {
        return jdbcTemplate.queryForObject(LOGIN_USER, rowMapper, id, password);
    }
}
