<%@ page info="securitynum check" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.net.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type">
	<style type="text/css">
		body {
			color: #000000;
			background: #ffffff;
		}
		
		table {
			width: 300px;
		}
		
		table, tr, td {
			border-collapse: collapse;
			border: 1px solid #999999;
		}
		
		tr, td {
			padding: 5px;
			text-align: center;
		}
		
		p {
			text-align: center;
		}
		
		span.bd {
			font-weight: bold;
		}
	</style>
	<title>주민등록번호 중복검사</title>
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String securitynum = request.getParameter("securitynum");
		String query = new String();
		
		int check_count = 0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e);
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "1234");
			stmt = conn.createStatement();
			
			query = "select count(*) as count from member where securitynum='" + securitynum + "'";
			rs = stmt.executeQuery(query);
			rs.next();
			check_count = rs.getInt("count");
			rs.close();
		} catch(SQLException e) {
		} finally {
			conn.close();
		}
	%>
	
	<div>
		<table>
			<tr>
				<td>
					<%
						if(check_count > 0) {
					%>
					
					<span class="bd"><%= securitynum %></span>은 등록되어있는 주민등록번호입니다.
					
					<%
						} else {
					%>
					
					<span class="bd"><%= securitynum %></span>은 사용 가능합니다.
					
					<%
						}
					%>
						
				</td>
			</tr>
		</table>
		<p>
			<input type="button" value="확인" onclick="self.close()">
		</p>
	</div>
</body>
</html>
