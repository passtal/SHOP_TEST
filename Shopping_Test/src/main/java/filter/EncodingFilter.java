package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebInitParam;


@WebFilter(
    urlPatterns = "/*",
    initParams = {
        @WebInitParam(name = "encoding", value = "UTF-8")
    }
)
public class EncodingFilter implements Filter {
	
	private String encoding; 
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		encoding = filterConfig.getInitParameter("encoding");
		
		if (encoding == null) {
			encoding = "UTF-8";
		}
		System.out.println("EncodingFilter 초기화... encoding : " + encoding);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		// 요청 및 응답 인코딩 설정
		request.setCharacterEncoding(encoding);
		response.setCharacterEncoding(encoding);
		
		// 다음 필터 호출
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
	}

}