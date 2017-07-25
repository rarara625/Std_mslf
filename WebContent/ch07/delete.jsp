<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>회원 삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		
		Connection con = null;
		Statement st = null;
		String sql = null;
		
		// jdbc-odbc driver 등록
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e.getMessage());
		}
		
		// db와의 연결
		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gboard", "root", "1234");
			
			// Statement 객체 생성
			st = con.createStatement();
			
			// sql 질의어 수행
			sql = "delete from woori where id = '" + id + "'";
			
			st.executeUpdate(sql);
			
			con.close();
			st.close();
		} catch(SQLException e) {
		}
	%>
	
	<jsp:forward page="selectall.jsp"/>
</body>
</html>