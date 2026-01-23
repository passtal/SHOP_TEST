<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    String phone = request.getParameter("phone");
    String orderPw = request.getParameter("orderPw");
    
    OrderRepository orderDAO = new OrderRepository();
    List<Product> orderList = orderDAO.list(phone, orderPw);
    
    session.setAttribute("orderPhone", phone);
    session.setAttribute("orderList", orderList);
    
    response.sendRedirect("order.jsp");
%>