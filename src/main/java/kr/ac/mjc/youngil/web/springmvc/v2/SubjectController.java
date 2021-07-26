package kr.ac.mjc.youngil.web.springmvc.v2;

import kr.ac.mjc.youngil.web.HttpUtils;
import kr.ac.mjc.youngil.web.dao.Subject;
import kr.ac.mjc.youngil.web.dao.SubjectDao;
import kr.ac.mjc.youngil.web.dao.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

    // 학과 정보 출력 전 사전작업 2 (UserController 에서 넘어옴.)
    @GetMapping("/security/preMajorInfo")
    public String preMajorInfo(
            @RequestParam(required = false, defaultValue = "1") int page,
            @RequestParam(required = false, defaultValue = "20") int count,
            HttpServletRequest request, Model model, HttpSession session) {
        String majorCode = request.getParameter("majorCode");
//        String majorCode = (String)session.getAttribute("majorCode");

        int offset = (page - 1) * count; // 목록 시작 위치
        List<Subject> subjectList = subjectDao.listSubjectOfCertainMajor(majorCode, offset, count);
        model.addAttribute("subjectList", subjectList);

        int subjectCount = subjectDao.countOfSubjectsOfCertainMajor(majorCode);
        model.addAttribute("subjectCount", subjectCount);
        return "forward:/app/springmvc/v2/major/security/majorInfo?majorCode="+majorCode;
    }

    /**
     * 과목 추가 액션 (from addSubject.jsp-> form action)
     */
    @PostMapping("/addSubjectAction")
    public String addSubject(HttpServletRequest request, @ModelAttribute Subject subject, RedirectAttributes attributes){
        try{
            subjectDao.addSubject(subject);
            return "redirect:/app/springmvc/v2/user/security/preMajorInfo?majorCode="+request.getParameter("majorCode");
        }catch (DuplicateKeyException e){
            attributes.addFlashAttribute("msg", "Duplicate Subject. check it again");
            return "redirect:/app/springmvc/v2/subject/addSubject";
        }catch (EmptyResultDataAccessException e){
            return "300";
        }
    }
}
