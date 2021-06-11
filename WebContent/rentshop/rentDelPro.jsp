<%@page import="com.matara.user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("user_id");
	if (id == null) {
		response.sendRedirect("../login/loginForm.jsp");
	} else {

		String[] arg = request.getParameterValues("rsLinstChk_del");

		RentshopDAO rsdao = new RentshopDAO();

		for (int i = 0; i < arg.length; i++) {
			rsdao.rentshopDEL(arg[i]);
		}

		response.sendRedirect("rentshopList.jsp");

	}
%>