<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 자동 로그인 토큰 삭제 (DB & 쿠키)
	if( loginId != null && !loginId.isEmpty() ) {
		UserRepository userDAO = new UserRepository();
		userDAO.deleteToken(loginId);
	}

	// 쿠키 삭제
	Cookie cookieMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	cookieMe.setPath("/");
	cookieToken.setPath("/");
	cookieMe.setMaxAge(0);
	cookieToken.setMaxAge(0);
	response.addCookie(cookieMe);
	response.addCookie(cookieToken);

	// 세션 무효화
	session.invalidate();
	
	// 메인 화면으로 이동
	response.sendRedirect(request.getContextPath() + "/");
%>