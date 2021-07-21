package kr.ac.mjc.youngil.web.springmvc.v2;
import kr.ac.mjc.youngil.web.HttpUtils;
import kr.ac.mjc.youngil.web.dao.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.Charset;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler)
            throws Exception {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER");

        if (user != null) // 로그인 했으면 그대로 진행
            return true;

        // 로그인 안했으면 로그인 화면으로
        String returnUrl = HttpUtils.getRequestURLWithQueryString(request);
        String loginUrl = String
                .format("%s/app/springmvc/v2/user/loginForm?returnUrl=%s",
                        request.getContextPath(),
                        URLEncoder.encode(returnUrl, Charset.defaultCharset()));
        response.sendRedirect(loginUrl);
        return false;
    }
}
