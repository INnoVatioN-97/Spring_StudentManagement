package kr.ac.mjc.youngil.web.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
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
public class StudentDao {
    //전체 학생 수
    public static final String COUNT_ALL_STUDENTS = """
            select count(studentId) from student 
            """;

    //학생 정보 수정
    public static final String UPDATE_STUDENT = """
            update student set name=:email, gender=:gender, major=:major where studentId=:studentId
            """;

    //학생 삭제
    public static final String DELETE_STUDENT = """
            delete from student where studentId=:studentId
            """;

    //학생 추가
    public static final String ADD_STUDENT = """
            insert student values(null, :name, :gender, :birthDay, :major)
            """;

    //학생 목록
    public static final String LIST_STUDENTS = """
            select studentId, name, gender, birthDay, major from student order by studentId desc limit ?,?
            """;

    //특정 학생 조회
    public static final String GET_STUDENT = """
            select studentId, name, gender, birthDay, major from student where studentId=?
            """;

    //학과별 학생수 조회
    public static final String COUNT_OF_STUDENT_OF_MAJOR = """
            select count(studentId) from student where major=:major
            """;

    private JdbcTemplate jdbcTemplate;
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private RowMapper<Student> rowMapper = new BeanPropertyRowMapper<>(Student.class);

    @Autowired
    public StudentDao(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

    /**
     * 학생 목록
     */
    public List<Student> listStudents(int offset, int count) {
        return jdbcTemplate.query(LIST_STUDENTS, rowMapper, offset, count);
    }

    /**
     * 총 학생 수
     */
    public Integer countAllStudents() {
        return jdbcTemplate.queryForObject(COUNT_ALL_STUDENTS, Integer.class);
    }

    /**
     * 학생 조회
     */
    public Student getStudent(int studentId) {
        return jdbcTemplate.queryForObject(GET_STUDENT, rowMapper, studentId);
    }

    /**
     * 사용자 등록
     *
     * @throws DuplicateKeyException 이메일이 중복되어 사용자 등록에 실패할 경우
     */
    public void addStudent(Student student) throws DuplicateKeyException {
        namedParameterJdbcTemplate
                .update(ADD_STUDENT, new BeanPropertySqlParameterSource(student));
    }

    /**
     * 학생 정보 수정
     *
     * @throws DuplicateKeyException 이메일이 중복되어 이메일 수정에 실패할 경우
     */
    public void updateStudent(Student student) throws DuplicateKeyException {
        namedParameterJdbcTemplate
                .update(UPDATE_STUDENT, new BeanPropertySqlParameterSource(student));
    }

    /**
     * 학생 탈퇴
     */
    public void quitStudent(int studentId) {
        namedParameterJdbcTemplate
                .update(DELETE_STUDENT, new BeanPropertySqlParameterSource(studentId));
    }

    /**
     * 특정 학과 학생수
     */
    public Integer countStudentOfMajor() {
        return jdbcTemplate.queryForObject(COUNT_OF_STUDENT_OF_MAJOR, Integer.class);
    }

}
