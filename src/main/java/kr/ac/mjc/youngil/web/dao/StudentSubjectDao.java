package kr.ac.mjc.youngil.web.dao;

import org.springframework.stereotype.Repository;

@Repository
public class StudentSubjectDao {
    private static final String LIST_ALL_STUDENT_SUBJECTS = """
            select subject.majorCode majorCode, major.majorName majorName,
            id, user.name name, subjectCode, score, subjectName 
            from studentSubject join subject using(subjectCode) join major using(majorCode) join user using(id) order by majorCode, subjectCode, id limit ?,?;
            """;

    // 내 수강 과목들
    private static final String MY_SUBJECTS = """
            select subjectCode, subject.professorName name,subject.subjectName subjectName, score from studentSubject join subject using(subjectCode) where id=
                        
            
                        
            """;
}
