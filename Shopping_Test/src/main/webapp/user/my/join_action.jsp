<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    User user = new User();
    
    user.setId(request.getParameter("id"));
    user.setPassword(request.getParameter("pw"));
    user.setName(request.getParameter("name"));
    user.setGender(request.getParameter("gender"));
    
    String birth = request.getParameter("year") + "/" + request.getParameter("month") + "/" + request.getParameter("day");
    user.setBirth(birth);
    
    String email = request.getParameter("email1") + "@" + request.getParameter("email2");
    user.setMail(email);
    user.setPhone(request.getParameter("phone"));
    user.setAddress(request.getParameter("address"));

    UserRepository userDAO = new UserRepository();
    int result = userDAO.insert(user);

    if (result > 0) {
        response.sendRedirect("complete.jsp?msg=1");
    } else {
        response.sendRedirect("join.jsp?error");
    }
%>