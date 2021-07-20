package kr.ac.mjc.youngil.web.springmvc.v2;

import kr.ac.mjc.youngil.web.HttpUtils;
import kr.ac.mjc.youngil.web.dao.Student;
import kr.ac.mjc.youngil.web.dao.StudentDao;
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
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.List;

@Controller("studentControllerV2")
@RequestMapping("/springmvc/v2/student")
@Slf4j
public class StudentController {
    private final StudentDao studentDao;

    @Autowired
    public StudentController(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    /**
     * 학생 목록 화면
     */
    @GetMapping("/studentList")
    public void studentList(
            @RequestParam(required = false, defaultValue = "1") int page,
            @RequestParam(required = false, defaultValue = "20") int count,
            HttpServletRequest request, Model model) {
        int offset = (page - 1) * count; // 목록 시작 위치
        // 위에서 구한 offset 값과 count 를 메소드에 넣어 학생 목록을 불러온다.
        List<Student> studentList = studentDao.listStudents(offset, count);
        int totalCount = studentDao.countAllStudents();

        //view 를 생성할 때 Model 을 이용해 view 에 값을 전달할 수 있다.
        model.addAttribute("studentList", studentList);
        model.addAttribute("totalCount", totalCount); //각각의 이름으로 studentList, totalCount 를 전달.
        //debug 를 출력해 request 정보를 쿼리스트링에 담아 이를 성공적으로 보냈음을 디버그에 띄움.
        log.debug(HttpUtils.getRequestURLWithQueryString(request));

        // 세션에 현재 리스트 페이지를 넣는다.
        request.getSession().setAttribute("listPage", HttpUtils.getRequestURLWithQueryString(request));
    }

    /**
     * 학생 추가 화면
     */
    @PostMapping("/addStudent")
    public String addStudent(
            @ModelAttribute Student student, RedirectAttributes attributes
    ){
        try{
            studentDao.addStudent(student);
            return "redirect:/app/springmvc/v2/student/studentList";
        }catch (DuplicateKeyException e){
            // redirect 시 attribute 를 저장
            attributes.addFlashAttribute("msg", "Duplicate email");
            return "springmvc/v2/springmvc/v2/student/addStudent";
        }
    }

    /**
     * 학생 로그인 동작
     */
    @PostMapping("/studentLoginAction")
    public String loginStudent(
            @RequestParam int studentId, @RequestParam String password,
            @RequestParam(required = false, defaultValue = "/") String returnUrl,
            HttpSession session, RedirectAttributes attributes) {
        try{
            Student student = studentDao.login(studentId, password);
            session.setAttribute("USER", student);
            return "redirect:"+returnUrl;
            //로그인 성공시 다시 redirect
        }catch (EmptyResultDataAccessException e){
            attributes.addFlashAttribute("studentId", studentId);
            attributes.addFlashAttribute("msg", "학번, 또는 비밀번호가 잘못 되었습니다.");
            return "redirect:/app/springmvc/v2/student/studentLogin?returnUrl=" +
                    URLEncoder.encode(returnUrl, Charset.defaultCharset());
        }
    }
}
