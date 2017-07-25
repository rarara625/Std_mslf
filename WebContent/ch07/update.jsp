<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>회원 정보 수정</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		String sql = null;
		Connection con = null;
		Statement st = null;
		
		// jdbc-odbc driver 등록
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e.getMessage());
		}
		
		// db와의 연결
		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gboard", "root", "1234");
		} catch(SQLException e) {
			out.println(e);
		}
		
		try {
			st = con.createStatement();
			
			// sql 질의어를 수행
			sql = "update woori set ";
			sql += "name = '" + name + "', " + "email = '" + email + "'";
			sql += " where id = '" + id + "'";
			
			st.executeUpdate(sql);
			
			con.close();
			st.close();
		} catch(SQLException e) {
			out.println(e);
		}
	%>
	
	<jsp:forward page="selectall.jsp"/>
</body>
</html>