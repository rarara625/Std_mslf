<%@ page info="insert" errorPage="error.jsp" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type">
	<script type="text/javascript">
	<!--
		function doSubmit() {
			form = document.join;
			if(!form.userid.value) {
				alert('아이디를 입력하지 않았습니다.'');
				form.userid.focus();
				return;
			}
			form.submit();
		}
	//-->
	</script>
	<style type="text/css">
		div {
			display: table;
			margin: 0 auto;
		}
		
		h4 {
			column-span: 2;
			text-align: center;
		}
		
		table {
			width: 500px;
		}
		
		table, tr, td {
			border: 1px solid gray;
			border-collapse: collapse;
		}
		
		tr, td {
			padding: 10px;
		}
		
		td.lCell {
			text-align: right;
			width: 15%;
		}
		
		p {
			text-align: center;
		}
	</style>
	<title>가입완료</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		String userid = request.getParameter("userid");
		String username = request.getParameter("username");
		String password = request.getParameter("userpw");
		String securitynum1 = request.getParameter("secureNo1");
		String securitynum2 = request.getParameter("secureNo2");
		String securitynum = securitynum1 + " - " + securitynum2;
		String email = request.getParameter("useremail");
		String zipcode1 = request.getParameter("postNo1");
		String zipcode2 = request.getParameter("postNo2");
		String zipcode = zipcode1 + " - " + zipcode2;
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String phone1 = request.getParameter("phone1");		
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String phone = phone1 + " - " + phone2 + " - " + phone3;
		
		String query = new String();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		int check_count = 0;
		
		java.util.Date yymmdd = new java.util.Date();
		SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
		String regdate = myformat.format(yymmdd);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassCastException e) {
			out.println(e);
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "1234");
			stmt = conn.createStatement();
			
			query = "inser into member values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, username);
			pstmt.setString(3, password);
			pstmt.setString(4, securitynum);
			pstmt.setString(5, email);
			pstmt.setString(6, zipcode);
			pstmt.setString(7, address1);
			pstmt.setString(8, address2);
			pstmt.setString(9, phone);
			pstmt.setString(10, regdate);
			pstmt.executeUpdate();
		} catch(SQLException e) {
			out.println("<script>alert('가입처리가 되지 않았습니다. 다시 시도해 주세요.'); history.back();</script>");
		} finally {
			conn.close();
		}
	%>
	
	
	<form name="join" method="post" action="modify.jsp">
		<input type="hidden" name="userid" value="<%= userid %>">
		<input type="hidden" name="mode" value="modify">
		<div>
			<h4>가입을 축하드립니다. 입력하신 내용을 확인하세요.</h4>
			<table>
				<tr>
					<td class="lCell">아이디</td>
					<td><%= userid %></td>
				</tr>
				<tr>
					<td class="lCell">이름</td>
					<td><%= username %></td>
				</tr>
				<tr>
					<td class="lCell">비밀번호</td>
					<td class="lCell">보안상 기재하지 않습니다.</td>
				</tr>
				<tr>
					<td class="lCell">주민등록번호</td>
					<td><%= securitynum %></td>
				</tr>
				<tr>
					<td class="lCell">E-mail</td>
					<td><%= email %></td>
				</tr>
				<tr>
					<td class="lCell">우편번호</td>
					<td><%= zipcode %></td>
				</tr>
				<tr>
					<td class="lCell">주소</td>
					<td><%= address1 %></td>
				</tr>
				<tr>
					<td class="lCell">나머지 주소</td>
					<td><%= address2 %></td>
				</tr>
				<tr>
					<td class="lCell">휴대폰</td>
					<td>
						<%
							if(phone.equals("--")) {
								out.println("<span style='color: blue'>선택하지 않았습니다</span>");
							} else {
								out.println(phone);
							}
						%>
					</td>
				</tr>
			</table>
		</div>
		<p>
			<input type="button" value="확인" onclick="location='left_Frame.jsp'">
			<input type="button" value="tnwjd" onclick="doSubmit()">
		</p>
	</form>
</body>
</html>
