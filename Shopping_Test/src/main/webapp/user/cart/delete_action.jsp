<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String productId = request.getParameter("id");
    String cartId = request.getParameter("cartId");

    // 장바구니 전체 삭제
    if (productId == null && cartId != null) {
        session.setAttribute("cartList", null); 
        response.sendRedirect("detail.jsp");
        return;
    }

    // 장바구니 개별 항목 삭제
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    
    if (cartList != null && productId != null) {
        for (int i = 0; i < cartList.size(); i++) {
            if (cartList.get(i).getProductId().equals(productId)) {
                cartList.remove(i);
                break;
            }
        }
    }
    response.sendRedirect("detail.jsp");
%>