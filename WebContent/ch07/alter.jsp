<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>테이블 수정하기</title>
</head>
<body>
	<%
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		String a = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e);
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gboard", "root", "1234");
		} catch(SQLException e) {
			out.println(e);
		}
		
		try {
			st = conn.createStatement();
			st.executeUpdate("alter table woori add email char(30)");
			st.executeUpdate("alter table woori add password integer");
			st.executeUpdate("alter table `gboard`.`woori` change column `name` `name` char(20) not null");
		} catch(SQLException e) {
			out.println(e);
		}
		
		try {
			rs = st.executeQuery("select * from woori");
			ResultSetMetaData rsmd = rs.getMetaData();
			out.println("테이블이 수정되었습니다.<br>");
			out.println(rsmd.getColumnCount() + "개의 컬럼(필드)를 가지고 있으며<br>");
			
			for(int i=1; i<=rsmd.getColumnCount(); i++) {
				out.println(i + "번째 컬럼은 " + rsmd.getColumnName(i));
				out.println("이고 유형은 " + rsmd.getColumnTypeName(i));
				out.println("이며 크기는 " + rsmd.getPrecision(i) + "<br>");
			}
			
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