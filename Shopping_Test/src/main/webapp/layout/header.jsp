<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 세션에서 장바구니 목록 가져오기
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	int cartCount = cartList == null ? 0 : cartList.size();
	
	String root = request.getContextPath();
	
	// 세션에서 로그인 아이디(loginId) 가져오기
	String loginId = (String) session.getAttribute("loginId");

	// 검색어(keyword) 파라미터 가져오기
	String keyword = request.getParameter("keyword");
	keyword = keyword == null ? "" : keyword;
%>
<nav class="navbar bg-dark navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${ root }/">
    	<img src="${ root }/static/img/logo.png" alt="" width="48" height="48">
    	쇼핑몰
    </a>
    <ul class="navbar-nav d-flex align-items-center px-3 gap-3">
       	<%
       		if( loginId == null || loginId.equals("") ) {
       	%>
       	<li class="nav-item"><a class="nav-link" href="${ root }/user/my/login.jsp">로그인</a></li>
        <li class="nav-item"><a class="nav-link" href="${ root }/user/my/join.jsp">회원가입</a></li>
        <li class="nav-item"><a class="nav-link" href="${ root }/user/my/order.jsp">주문내역</a></li>
        <%
       		} else {
        %>
        <li class="nav-item">
        <div class="dropdown">
	      <a href="#" class="d-flex align-items-center link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
	        <img src="${ root }/static/img/avatar.png" alt="" width="32" height="32" class="rounded-circle me-3">
	        <strong><%= loginId %></strong>
	      </a>
	      <ul class="dropdown-menu text-small shadow">
	        <li><a class="dropdown-item" href="${ root }/user/my/detail.jsp">마이 페이지</a></li>
	        <li><a class="dropdown-item" href="${ root }/user/my/update.jsp">회원정보 수정</a></li>
	        <li><a class="dropdown-item" href="${ root }/user/my/order.jsp">주문내역</a></li>
	        <li><hr class="dropdown-divider"></li>
	        <li><a class="dropdown-item" href="${ root }/user/my/logout.jsp">로그아웃</a></li>
	      </ul>
	    </div>
        </li>
        <%
        	}
        %>
        <li class="nav-item">
	        <a class="nav-link position-relative" href="${ root }/user/cart/detail.jsp">
	        	<i class="material-symbols-outlined">shopping_bag</i>
	        	<span class="cart-count"><%= cartCount %></span>
	        </a>
        </li>
      </ul>
      <form class="d-flex mx-3" role="search" action="${ root }/user/product/list.jsp" method="get">
        <input class="form-control me-2" type="search" name="keyword" placeholder="검색어" value="<%= keyword %>">
        <button class="btn btn-outline-success d-flex align-items-center" type="submit">
        	<i class="material-symbols-outlined">search</i>
        </button>
      </form>
    </div>
</nav>