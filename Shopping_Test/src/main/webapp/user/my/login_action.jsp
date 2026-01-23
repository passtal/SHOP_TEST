<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	UserRepository userDAO = new UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// 로그인 실패
	if( loginUser == null ) {
		response.sendRedirect("login.jsp?error=0");
		return;
	}
	
	// 로그인 성공
	session.setAttribute("loginId", loginUser.getId());
	session.setAttribute("orderList", null);
	
	String rememberId = request.getParameter("remember-id");
	String rememberMe = request.getParameter("remember-me");
	
	// 아이디 저장 쿠키
	Cookie cookieId = new Cookie("rememberId", id);
	cookieId.setPath("/");
	if( rememberId != null && rememberId.equals("on") ) {
		cookieId.setMaxAge(60 * 60 * 24 * 7); // 7일
	} else {
		cookieId.setMaxAge(0);
	}
	response.addCookie(cookieId);
	
	// 자동 로그인 처리
	if( rememberMe != null && rememberMe.equals("on") ) {
		String token = userDAO.refreshToken(loginUser.getId());
		Cookie cookieMe = new Cookie("rememberMe", "on");
		Cookie cookieToken = new Cookie("token", token);
		cookieMe.setPath("/");
		cookieToken.setPath("/");
		cookieMe.setMaxAge(60 * 60 * 24 * 7);
		cookieToken.setMaxAge(60 * 60 * 24 * 7);
		response.addCookie(cookieMe);
		response.addCookie(cookieToken);
	} else {
		Cookie cookieMe = new Cookie("rememberMe", "");
		Cookie cookieToken = new Cookie("token", "");
		cookieMe.setPath("/");
		cookieToken.setPath("/");
		cookieMe.setMaxAge(0);
		cookieToken.setMaxAge(0);
		response.addCookie(cookieMe);
		response.addCookie(cookieToken);
	}
	
	response.sendRedirect("complete.jsp?msg=0");		
%>