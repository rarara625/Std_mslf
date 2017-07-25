<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
	function del(code){
		  var isDel = confirm("정말로 삭제하시겠습니까?");
		  
		  if(isDel){
		  	return true;
		  } else {
			  return false;
		  }
	}
	</script>
	<style type="text/css">
		div {
			display: table;
			margin: 20px auto 10px;
		}
		
		p {
			text-align: center;
		}
		
		label {
			display: table;
			margin: 5px auto;
		}
		
		a {
			color: black;
			font-weight: bolder;
		}
		
		button a {
			text-decoration: none;
			font-weight: lighter;
		}
	</style>
	<title>특정 레코드 조회 결과</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String password = request.getParameter("password").trim();
		String sql = "select * from woori where id=?";
		
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		// jdbc-odbc driver 등록
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e.getMessage());
		}
		
		// db와의 연결
		try  {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gboard", "root", "1234");
		} catch(SQLException e) {
			out.println(e);
		}
		
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, id);
			
			// sql 질의어를 수행하고, ResultSet을 구한다
			rs = pst.executeQuery();
			
			if (!(rs.next())) { %>
				<p>해당되는 회원이 없습니다.</p>
		<% } else {
				if (password.equals(rs.getString("password"))) { %>
				<p>사용자 ID가 <%= id %>인 회원의 정보는 다음과 같습니다.</p>
				<p>정보를 변경하려면 내용을 입력한 다음 [수정하기] 버튼을 누르세요.</p>
				
				<form name="form1" method="post" action="update.jsp">
					<label>
						ID : <input type="tel" name="id" value="<%= id %>" readonly="readonly">
					</label><br>
					<label>
						이름 : <input type="text" name="name" value="<%= rs.getString("name") %>">
					</label><br>
					<label>
						E-mail : <input type="text" name="email" value="<%= rs.getString("email") %>">
					</label>
					<div>
						<input type="submit" name="change" value="수정하기">&nbsp;
						<button onclick="return del();"><a href="delete.jsp?id=<%= id %>">삭제하기</a></button>
					</div>
				</form>
			<% } else { %>
				<p>비밀번호가 틀립니다.</p>
			<% } 
			}
		
			rs.close();
			con.close();
			pst.close();
		} catch(SQLException e) {
			out.println(e);
		}
		%>
		<div>
			<a href="main.html">메인으로</a>&nbsp;<a href="select.html">조회페이지로</a>
		</div>
</body>
</html>