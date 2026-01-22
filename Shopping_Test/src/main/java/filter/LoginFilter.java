package filter;

import java.io.IOException;
import java.net.URLDecoder;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shop.dao.UserRepository;
import shop.dto.PersistentLogin;

@WebFilter("/*")
public class LoginFilter implements Filter {
	
	Cookie[] cookies;
	UserRepository userDAO;
	
    public LoginFilter() {
        super();
    }

    public void init(FilterConfig fConfig) throws ServletException {
    	userDAO = new UserRepository();
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		cookies = req.getCookies();
		
		String rememberMe = null;
		String token = null;
		
		// 1. 쿠키 정보 가져오기
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode(cookie.getValue(), "UTF-8");
				
				if(cookieName.equals("rememberMe")) rememberMe = cookieValue;
				if(cookieName.equals("token")) token = cookieValue;
			}
		}
		
		// 2. 자동 로그인 확인
		if (rememberMe != null && token != null) {
			PersistentLogin persistentLogin = userDAO.selectTokenByToken(token);
			
			// 토큰이 유효하면 로그인 처리
			if (persistentLogin != null) {
				HttpSession session = req.getSession();
				session.setAttribute("loginId", persistentLogin.getUserId());
			}
		}
		
		chain.doFilter(request, response);
	}

	public void destroy() {
		
	}

}