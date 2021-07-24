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

@Repository
public class MajorDao {
    // 전공 추가
    private static final String ADD_MAJOR = """
            insert major values(:majorCode, :majorName);
            """;
    // 전공명 변경
    private static final String UPDATE_MAJOR = """
            update major set majorName=:majorName where majorCode=:majorCode
            """;

    // 전공 목록 출력
    private static final String LIST_MAJOR = """
            select majorCode, majorName from major order by majorCode desc limit ?, ?
            """;

    // 전공 삭제
    private static final String DELETE_MAJOR = """
            delete from major where majorCode=:majorCode
            """;

    // 총 전공 개수
    private static final String COUNT_OF_MAJORS= """
            select count(majorCode) from major
            """;


    // 전공 이름들 가져오기 (회원가입용)
    private static final String GET_MAJOR_NAMES =
            "select majorName, majorCode from major order by majorCode";

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Major> rowMapper = new BeanPropertyRowMapper<>(Major.class);

    @Autowired
    public MajorDao(NamedParameterJdbcTemplate namedParameterJdbcTemplate, JdbcTemplate jdbcTemplate) {
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
        this.jdbcTemplate = jdbcTemplate;
    }


    // 전공 목록
    public List<Major> listMajors(int offset, int count){
        return jdbcTemplate.query(LIST_MAJOR, rowMapper, offset, count);
    }

    // 전공 이름 목록
    public List<Major> getMajorNames(){
        return jdbcTemplate.query(GET_MAJOR_NAMES, rowMapper);
    }

    // 전공 등록
    public void addMajor(Major major) throws DuplicateKeyException{
        namedParameterJdbcTemplate.update(ADD_MAJOR, new BeanPropertySqlParameterSource(major));
    }

    // 전공명 수정
    public void updateMajor(Major major) throws DuplicateKeyException{
        namedParameterJdbcTemplate.update(UPDATE_MAJOR, new BeanPropertySqlParameterSource(major));
    }

    // 전공 삭제
    public void deleteStudent(String majorCode){
        namedParameterJdbcTemplate.update(DELETE_MAJOR, new BeanPropertySqlParameterSource(majorCode));
    }


    // 총 전공 개수
    public Integer countOfMajors(){
        return jdbcTemplate.queryForObject(COUNT_OF_MAJORS, Integer.class);
    }
}
