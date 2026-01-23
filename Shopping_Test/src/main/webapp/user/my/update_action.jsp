<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
    request.setCharacterEncoding("UTF-8");
    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    
    User user = new User();
    user.setId(id);
    
    // 비밀번호 미입력 시 기존 비밀번호 유지
    if (pw == null || pw.equals("")) {
        User oldUser = userDAO.getUserById(id);
        if (oldUser != null) {
            pw = oldUser.getPassword();
        }
    }
    user.setPassword(pw);
    
    user.setName(request.getParameter("name"));
    user.setGender(request.getParameter("gender"));
    user.setBirth(request.getParameter("year") + "/" + request.getParameter("month") + "/" + request.getParameter("day"));
    user.setMail(request.getParameter("email1") + "@" + request.getParameter("email2"));
    user.setPhone(request.getParameter("phone"));
    user.setAddress(request.getParameter("address"));

    int result = userDAO.update(user);
    
    if (result > 0) {
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp?error");
    }
%>