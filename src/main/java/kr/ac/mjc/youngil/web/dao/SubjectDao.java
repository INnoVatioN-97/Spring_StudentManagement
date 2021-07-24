package kr.ac.mjc.youngil.web.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SubjectDao {
    // 과목 목록
    private static final String LIST_ALL_SUBJECTS = """
            select subjectCode, major.majorName, user.name professorName, 
            subjectName, professorId, majorCode from subject 
            join major using (majorCode) join user using(majorCode) 
            where professorId = user.id 
            order by majorCode asc, professorId asc limit ?,?
            """;

    /**
     * select subjectCode, subject.majorCode, subjectName,
     * user.name name, professorId from subject
     * join user where professorId = user.id;
     */

    // 과목 추가
    private static final String ADD_SUBJECT = """
            insert subject values(null, :majorCode, :subjectName)
            """;

    // 특정 과목 삭제
    private static final String DELETE_SUBJECT = """
            delete from subject where subjectCode = ? and majorCode = ?
            """;

    // 과목 정보 수정
    private static final String UPDATE_SUBJECT = """
            update subject set subjectName=:subjectName, 
            """;

    /**
     * 전체 과목 수
     */
    private static final String COUNT_ALL_SUBJECTS = """
            select count(subjectCode) from subject
            """;

    private JdbcTemplate jdbcTemplate;
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private RowMapper<Subject> rowMapper = new BeanPropertyRowMapper<>(Subject.class);

    @Autowired
    public SubjectDao(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

    /**
     * 과목 목록
     */
    public List<Subject> listAllSubjects(int offset, int count){
        return jdbcTemplate.query(LIST_ALL_SUBJECTS, rowMapper, offset, count);
    }

    /**
     * 전체 과목 수
     */
    public Integer countAllSubjects(){
        return jdbcTemplate.queryForObject(COUNT_ALL_SUBJECTS, Integer.class);
    }

}
