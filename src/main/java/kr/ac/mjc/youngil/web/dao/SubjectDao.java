package kr.ac.mjc.youngil.web.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
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

    // 특정 학과 교과목
    private static final String LIST_SUBJECTS_OF_CERTAIN_MAJOR = """
            select subjectCode, subjectName, professorId, user.name professorName,
             subject.majorCode, major.majorName 
             from subject join user join major 
             where professorId = user.id 
             and subject.majorCode = major.majorCode 
             and subject.majorCode = ? order by professorId limit ?,?
            """;

    /**
     * 특정 학과 교과목 수
     */
    private static final String COUNT_OF_SUBJECTS_OF_CERTAIN_MAJOR = """
            select count(subjectCode) from subject where majorCode=?;
            """;

    // 과목 추가
    private static final String ADD_SUBJECT = """
            insert subject values(null, ?, ?, ?)
            """;

    // 특정 과목 삭제
    private static final String DELETE_SUBJECT = """
            delete from subject where majorCode = ? and subjectCode = ?
            """;

    // 과목 정보 수정
    private static final String UPDATE_SUBJECT = """
            update subject set subjectName=:subjectName
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
    public List<Subject> listAllSubjects(int offset, int count) {
        return jdbcTemplate.query(LIST_ALL_SUBJECTS, rowMapper, offset, count);
    }

    /**
     * 전체 과목 수
     */
    public Integer countAllSubjects() {
        return jdbcTemplate.queryForObject(COUNT_ALL_SUBJECTS, Integer.class);
    }

    /**
     * 특정 학과 과목들 조회
     */
    public List<Subject> listSubjectOfCertainMajor(String majorCode, int offset, int count) {
        return jdbcTemplate.query(LIST_SUBJECTS_OF_CERTAIN_MAJOR, rowMapper, majorCode, offset, count);
    }

    /**
     * 특정 학과 교과목 수
     */
    public Integer countOfSubjectsOfCertainMajor(String majorCode) {
        return jdbcTemplate.queryForObject(COUNT_OF_SUBJECTS_OF_CERTAIN_MAJOR, Integer.class, majorCode);
    }

    public void addSubject(Subject subject) throws DuplicateKeyException {
        jdbcTemplate.update(ADD_SUBJECT, rowMapper, subject.majorCode, subject.subjectName, subject.professorId);
    }

    /**
     * n개 교과목 삭제
     */
    public void deleteSubject(String majorCode, int subjectCode) {
        jdbcTemplate.update(DELETE_SUBJECT, majorCode, subjectCode);
    }
}
