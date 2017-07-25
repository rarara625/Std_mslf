<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>테이블 만들기</title>
</head>
<body>
	<%
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		String a = null;
		
		// jcbc-odbc driver 로드
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			out.println(e);
		}
		
		//DB 연결
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gboard", "root", "1234");
		} catch(SQLException e) {
			out.println(e);
		}
		
		// 객체 생성, query문 수행
		try {
			st = conn.createStatement();
			st.executeUpdate("create table woori(id char(10) primary key, name char(10))");
		} catch(SQLException e) {
			out.println(e);
		}
		
		// 결과 받기 -> 처리
		try {
			rs= st.executeQuery("select * from woori");
			ResultSetMetaData rsmd = rs.getMetaData();
			out.println("새로운 테이블이 생성되었습니다.<br>");
			out.println(rsmd.getColumnCount() + "개의 컬럼(필드)를 가지고 있으며<br>");
			out.println("첫 번째 칼럼은 " + rsmd.getColumnName(1) + "<br>");
			out.println("두 번째 칼럼은 " + rsmd.getColumnName(2) + "<br>");
			
			rs.close();
			st.close();
			conn.close();
		} catch(SQLException e) {
			out.println(e);
		}
	%>
	
	<a href="main.html">main으로</a>
</body>
</html>