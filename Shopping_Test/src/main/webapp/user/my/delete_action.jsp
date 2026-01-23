<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
    if (loginId != null) {
        int result = userDAO.delete(loginId);
        if (result > 0) {
            session.invalidate();
            response.sendRedirect("complete.jsp?msg=3");
        } else {
            response.sendRedirect("update.jsp?error");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>