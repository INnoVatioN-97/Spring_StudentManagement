package kr.ac.mjc.youngil.web.springmvc.v2;

import kr.ac.mjc.youngil.web.HttpUtils;
import kr.ac.mjc.youngil.web.dao.Major;
import kr.ac.mjc.youngil.web.dao.MajorDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller("majorControllerV2")
@RequestMapping("/springmvc/v2/major")
@Slf4j
public class MajorController {
    private final MajorDao majorDao;

    @Autowired
    public MajorController(MajorDao majorDao) {
        this.majorDao = majorDao;
    }

    /**
     * 과목 목록 화면
     */
    @GetMapping("/majorList")
    public void majorList(
            @RequestParam(required = false, defaultValue = "1") int page,
            @RequestParam(required = false, defaultValue = "20") int count,
            HttpServletRequest request, Model model) {
        int offset = (page - 1) * count;
        List<Major> majorList = majorDao.listMajors(offset, count);
        int totalCount = majorDao.countOfMajors();

        model.addAttribute("majorList", majorList);
        model.addAttribute("totalCount", totalCount);

        log.debug(HttpUtils.getRequestURLWithQueryString(request));

        request.getSession().setAttribute("listPage", HttpUtils.getRequestURLWithQueryString(request));
    }


    // 전공 이름들 가져오기
    @GetMapping("/preJoinForm")
    public String majorNameList(HttpServletRequest request, Model model) {
        List<Major> majorNameList = majorDao.getMajorNames();

        model.addAttribute("majorNameList", majorNameList);
//        log.debug(HttpUtils.getRequestURLWithQueryString(request));

//        request.getSession().setAttribute("listPage", HttpUtils.getRequestURLWithQueryString(request));
        return "/springmvc/v2/user/joinForm";
    }

    /**
     * 전공 추가 화면
     */
    @PostMapping("/addMajor")
    public String addStudent(
            @ModelAttribute Major major, RedirectAttributes attributes
    ) {
        try {
            majorDao.addMajor(major);
            return "redirect:/app/springmvc/v2/major/majorList";
        } catch (DuplicateKeyException e) {
            // redirect 시 attribute 를 저장
            attributes.addFlashAttribute("msg", "Duplicate Major Name");
            return "springmvc/v2/springmvc/v2/major/addMajor";
        }
    }

}

