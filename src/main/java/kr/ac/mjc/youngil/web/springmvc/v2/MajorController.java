package kr.ac.mjc.youngil.web.springmvc.v2;

import kr.ac.mjc.youngil.web.dao.MajorDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("majorControllerV2")
@RequestMapping("/springmvc/v2/student")
@Slf4j
public class MajorController {
    private final MajorDao majorDao;

    @Autowired
    public MajorController(MajorDao majorDao) {
        this.majorDao = majorDao;
    }
}
