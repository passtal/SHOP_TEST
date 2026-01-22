package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

public class EncodingFilter implements Filter {
	
	private String encoding; 
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// web.xml 에서 설정한 초기 파라미터 "encoding"을 가져와 초기화
		encoding = filterConfig.getInitParameter("encoding");
		
		// 설정이 없으면 기본값 UTF-8
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
		// 필터 해제 시 처리
	}

}