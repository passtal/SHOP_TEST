<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	// EncodingFilter 에서 공통으로 처리됨
	// request.getCharacterEncoding("UTF-8");

	String cartIdVal = request.getParameter("cartId") == null ? "" : request.getParameter("cartId");
	String nameVal = request.getParameter("name") == null ? "" : request.getParameter("name");
	String dateVal = request.getParameter("shippingDate") == null ? "" : request.getParameter("shippingDate");
	String countryVal = request.getParameter("country") == null ? "" : request.getParameter("country");
	String zipCodeVal = request.getParameter("zipCode") == null ? "" : request.getParameter("zipCode");
	String addressNameVal = request.getParameter("addressName") == null ? "" : request.getParameter("addressName");
	String phoneVal = request.getParameter("phone") == null ? "" : request.getParameter("phone");
	
	Cookie cartId = new Cookie("ship_cartId", URLEncoder.encode(cartIdVal, "UTF-8"));
	Cookie name = new Cookie("ship_name", URLEncoder.encode(nameVal, "UTF-8"));
	Cookie date = new Cookie("ship_date", URLEncoder.encode(dateVal, "UTF-8"));
	Cookie country = new Cookie("ship_country", URLEncoder.encode(countryVal, "UTF-8"));
	Cookie zipCode = new Cookie("ship_zipCode", URLEncoder.encode(zipCodeVal, "UTF-8"));
	Cookie addressName = new Cookie("ship_addressName", URLEncoder.encode(addressNameVal, "UTF-8"));
	Cookie phone = new Cookie("ship_phone", URLEncoder.encode(phoneVal, "UTF-8"));
	
	int time = 24 * 60 * 60;		// 24 시간(1일)
	cartId.setMaxAge(time);
	name.setMaxAge(time);
	date.setMaxAge(time);
	country.setMaxAge(time);
	zipCode.setMaxAge(time);
	addressName.setMaxAge(time);
	phone.setMaxAge(time);
	
	// 쿠키 경로
	cartId.setPath("/");	
	name.setPath("/");
	date.setPath("/");
	country.setPath("/");
	zipCode.setPath("/");
	addressName.setPath("/");
	phone.setPath("/");
	
	response.addCookie(cartId);	
	response.addCookie(name);	
	response.addCookie(date);	
	response.addCookie(country);	
	response.addCookie(zipCode);	
	response.addCookie(addressName);	
	response.addCookie(phone);	
	
	// 주문 페이지로 리다이렉트
	response.sendRedirect(request.getContextPath() + "/user/order/add.jsp");
%>






