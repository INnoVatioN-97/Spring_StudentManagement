package kr.ac.mjc.youngil.web.springmvc.v2;

import kr.ac.mjc.youngil.web.HttpUtils;
import kr.ac.mjc.youngil.web.dao.Subject;
import kr.ac.mjc.youngil.web.dao.SubjectDao;
import kr.ac.mjc.youngil.web.dao.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller("subjectControllerV2")
@RequestMapping("/springmvc/v2/subject")
@Slf4j
public class SubjectController {
    private final SubjectDao subjectDao;

    @Autowired
    public SubjectController(SubjectDao subjectDao) {
        this.subjectDao = subjectDao;
    }

    /**
     * 전체 과목 화면
     */
    @GetMapping("/root/allSubjectList")
    public void allSubjectList(
            @RequestParam(required = false, defaultValue = "1")int page,
            @RequestParam(required = false, defaultValue = "20") int count,
            HttpServletRequest request, Model model){
        int offset = (page - 1) * count; // 목록 시작 위치
        // 위에서 구한 offset 값과 count 를 메소드에 넣어 학생 목록을 불러온다.
        List<Subject> subjectList = subjectDao.listAllSubjects(offset, count);
        int totalCount = subjectDao.countAllSubjects();

        //view 를 생성할 때 Model 을 이용해 view 에 값을 전달할 수 있다.
        model.addAttribute("subjectList", subjectList);
        model.addAttribute("totalCount", totalCount); //각각의 이름으로 userList, totalCount 를 전달.
        //debug 를 출력해 request 정보를 쿼리스트링에 담아 이를 성공적으로 보냈음을 디버그에 띄움.
        log.debug(HttpUtils.getRequestURLWithQueryString(request));

        // 세션에 현재 리스트 페이지를 넣는다.
        request.getSession().setAttribute("listPage", HttpUtils.getRequestURLWithQueryString(request));
    }
}
