<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	
<html>
<head>
	<style type="text/css">
		h3 {
			text-align: center;
		}
		
		table {
			border: 1px solid black;
			margin: 0 auto;
		}
		
		tr, th, td {
			border: 1px solid black;
			margin: 10px 20px;
			padding: 10px;
		}
		
		div {
			display: table;
			margin: 0 auto;
		}
		
		div a {
			text-decoration: none;
			color: black;
		}
	</style>
	<title>전체 회원 정보 조회</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		String a = null;
		
		// jdbc-odbc driver를 등록
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e);
		}
		
		// db와 연결
		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gboard", "root", "1234");
		} catch(SQLException e) {
			out.println(e);
		}
		
		// 쿼리 실행
		try {
			st = con.createStatement();
			rs = st.executeQuery("select * from woori order by id");
	%>
			<h3>우리 회원 정보 보기</h3>
			<table>
				<tr>
					<th>사용자 ID</th>
					<th>이름</th>
					<th>E-mail</th>
				</tr>
				
		<% if (!(rs.next())) { %>
		<tr>
			<td colspan="4">등록된 회원이 없습니다.</td>
		</tr>
		<% } else {
				do {
					out.println("<tr>");
					out.println("<td>" + rs.getString("id") + "</td>");
					out.println("<td>" + rs.getString("name") + "</td>");
					out.println("<td>" + rs.getString("email") + "</td>");
					out.println("</tr>");
				} while(rs.next());
			}
		
			rs.close();
			st.close();
			con.close();
		
		} catch(SQLException e) {
			System.out.println(e);
		}
		%>
		</table>
		<div>
			[<a href="main.html">main으로</a>]&nbsp;[<a href="insert.html">회원 등록 페이지로</a>]
		</div>
</body>
</html>