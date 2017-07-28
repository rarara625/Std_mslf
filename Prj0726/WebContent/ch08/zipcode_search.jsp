<%@ page info="zipcode search" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" import="java.sql.*, java.io.*, java.net.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type">
	<script type="text/javascript">
		function choiceZipcode(zipcodeno, address1) {
			opener.join.postNo1.value= zipcodeno.substring(0,3);
			opener.join.postNo2.value= zipcodeno.substring(4,7);
			opener.join.address1.value= address1;
			opener.join.address2.focus();
			self.close();
		}
	</script>
	<style type="text/css">
		body {
			color: #000000;
			background: #ffffff;
			margin: 0;
		}
		
		div.container {
			display: table;
			margin: 0 auto;
		}
		
		table {
			width: 450px;
		}
		
		table, tr, td {
			border-collapse: collapse;
			padding: 3px;
			text-align: center;
		}
		
		p {
			color: #405893;
			text-align: center;
		}
		
		div#btn {
			display: table;
			margin: 0 auto;
		}
		
		div#btn input {
			margin: 5px;
		}
		
		td#post {
			width: 30%;
			background: #b4b4da;
			color: #999999;
		}
		
		td#addr {
			width: 70%;
			background: #f7edfe;
			color: #999999;
		}
		
		td#adr {
			border: 1px solid #cccccc;
			background: #ffffff;
			text-align: center;
		}
		
		td#adr1 {
			border: 1px solid #999999;
			background: #ffffff;
			text-align: center;
		}
	</style>
	<title>우편번호 검색</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String searchaddr = request.getParameter("addr");
		String query = new String();
		String zipcode = new String();
		String sido = new String();
		String gugun = new String();
		String dong = new String();
		String bunji = new String();
		String address = new String();
		String address1 = new String();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e);
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "1234");
			stmt = conn.createStatement();
		} catch(SQLException e) {
		}
	%>
	
	<form name="zipcode" method="post" action="zipcode_search.jsp">
		<div class="container">
			<table>
				<tr>
					<td>
						<p>찾고자 하는 주소의 동/읍/면 이름을 입력하세요.<br>검색한 후 주소를 클릭하세요</p>
					</td>
				</tr>
			</table>
			<div id="btn">
				<input type="text" name="addr" maxlength="15" size="15">
				<input type="submit" value="검색">
			</div>
		</div>
	</form>
	
	<%
		if(searchaddr != null) {
	%>
	<div class="container">
		<table>
			<tr>
				<td id="post">우편번호</td>
				<td id="addr">주소</td>
			</tr>
		</table>
	
		<table>
			<%
				try {
					query = "select * from zipcode where dong like '%" + searchaddr + "%'";
					rs = stmt.executeQuery(query);
					
					while(rs.next()) {
						zipcode = rs.getString("zipcode");
						sido = rs.getString("sido");
						gugun = rs.getString("gugun");
						dong = rs.getString("dong");
						bunji = rs.getString("bunji");
						address = sido + " " + gugun + " " + dong + " " + bunji;
						address1 = sido + " " + gugun + " " + dong;
			%>
			
			<tr>
				<td id="adr">
					<a href="javascript:choiceZipcode('<%= zipcode %>', '<%= address1 %>')"><%= zipcode %></a>
				</td>
				<td id="adr1">
					<a href="javascript:choiceZipcode('<%= zipcode %>', '<%= address1 %>')"><%= address %></a>
				</td>
			</tr>
			
			<%
					}
					rs.close();
					stmt.close();
				} catch(SQLException e) {
				} finally {
					conn.close();
				}
			%>
		</table>
	</div>
	<%
		}
	%>
</body>
</html>
