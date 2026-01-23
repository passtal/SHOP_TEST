<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>   
    <% 
        List<Product> cartList = (List<Product>) session.getAttribute("cartList");
        if (cartList == null) cartList = new ArrayList<Product>();
        int cartCount = cartList.size();
        String cartId = session.getId();
    %>
    
    <jsp:include page="/layout/header.jsp" />
    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
    </div>
    
    <div class="container order">
        <table class="table table-striped table-hover table-bordered text-center align-middle">
            <thead>
                <tr class="table-primary">
                    <th>상품</th><th>가격</th><th>수량</th><th>소계</th><th>비고</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int sum = 0;
                    for (int i = 0; i < cartList.size(); i++) {
                        Product product = cartList.get(i);
                        int total = product.getUnitPrice() * product.getQuantity();
                        sum += total;
                %>
                <tr>
                    <td><%= product.getName() %></td>           
                    <td><%= product.getUnitPrice() %></td>          
                    <td><%= product.getQuantity() %></td>           
                    <td><%= total %></td>           
                    <td><a href="delete_action.jsp?id=<%= product.getProductId() %>" class="btn btn-danger">삭제</a></td>           
                </tr>
                <%
                    }
                %>
            </tbody>
            <tfoot>
                <% if (cartList.isEmpty()) { %>
                <tr><td colspan="5">추가된 상품이 없습니다.</td></tr>
                <% } else { %>
                <tr><td></td><td></td><td>총액</td><td id="cart-sum"><%= sum %></td><td></td></tr>
                <% } %>
            </tfoot>
        </table>
    
        <div class="d-flex justify-content-between align-items-center p-3">
            <a href="delete_action.jsp?cartId=<%= cartId %>" class="btn btn-lg btn-danger ">전체삭제</a>
            <a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
        </div>
    </div>
    
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
    
    <script>
        let cartId = '<%= cartId %>'
        let cartCount = <%= cartCount %>
        let cartSum = document.getElementById('cart-sum')
        
        function order() {
            if (cartCount == 0) {
                alert('장바구니에 담긴 상품이 없습니다.')
                return
            }
            let msg = '총 ' + cartCount + '개의 상품을 주문합니다.'
            if (confirm(msg)) {
                location.href = '../shipment/add.jsp?cartId=' + cartId
            }
        }
    </script>
</body>
</html>