<%@ page info="userid check" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
		function checkEnd() {
			var form = document.id_check;
			
			opener.join.userid.value = form.userid.value;	// 원본창 = 새로 뜬 창
			//opener.join.userid_check.value = form.check_count.value;
			self.close();
		}
		
		function doCheck() {
			var form = document.id_check;
			if(!checkValue(form.userid, '아이디', 5, 16)) {
				return;
			}
			form.submit();
		}
		
		function checkValue(target, cmt, lmin, lmax) {
			var Alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
			var Digit = '1234567890';
			var astr = Alpha + Digit;
			var i;
			
			var tValue = target.value;
			if(tValue.length < lmin || tValue.length > lmax) {
				if(lmin == lmax) {
					alert(cmt + '는 ' + lmin + 'Byte이어야 합니다.');
				} else {
					alert(cmt + '는 ' + lmin + '~' + lmax + 'Byte 이내로 입력하셔야 합니다.');
				}
				target.focus();
				return false;
			}
			
			if(astr.length > 1) {
				for(i=0; i<tValue.length; i++) {
					if(astr.indexOf(tValue.substring(i, i+1)) < 0) {
						alert(cmt + '에 허용할 수 없는 문자가 입력되었습니다.');
						target.focus();
						return false;
					}
				}
			}
			return true;
		}
	</script>
	<style type="text/css">
		body {
			color: #000000;
			background: #ffffff;
			margin: 0;
		}
		
		div {
			display: table;
			margin: 0 auto;
		}
		
		table {
			width: 300px;
		}
		
		table, tr, td {
			border-collapse: collapse;
		}
		
		tr, td {
			padding: 5px 15px;
		}
		
		td#line1 {
			text-align: center;
		}
		
		td#line2 {
			background: #b6c1d6;
			text-align: center;
		}
		
		td#line3 {
			background: #b6c1d6;
			text-align: center;
		}
		
		p {
			text-align: center;
		}
		
		span.bd {
			font-weight: bold;
		}
	</style>
	<meta http-equiv="Content-Type">
	<title>아이디 중복검사</title>
</head>
<body>
	<%
		String userid = request.getParameter("userid");
		String query = new String();
		
		int check_count = 0;
		boolean bjoin = false;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassCastException e) {
			out.println(e);
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "1234");
			stmt = conn.createStatement();
			
			query = "select count(*) as count from member where userid='" + userid + "'";
			rs = stmt.executeQuery(query);
			rs.next();
			check_count = rs.getInt("count");
			rs.close();
		} catch(SQLException e) {
		} finally {
			conn.close();
		}
	%>
	
	<form name="id_check" method="post" action="userid_check.jsp">
		<div>
			<input type="hidden" name="check_count" value="<%= check_count %>">
			<table>
				<tr>
					<td id="line1">원하는 아이디를 입력하세요.</td>
				</tr>
				<tr>
					<td id="line2">
						<input type="text" name="userid" value="<%= userid %>" onfocus="this.value=''" maxlength="16" size="16">
						<input type="button" value="중복확인" onclick="doCheck()">
					</td>
				</tr>
				<tr>
					<td id="line3">
						<%
							if(check_count > 0){
						%>
						
						<span class="bd"><%= userid %></span>은 등록되어있는 아이디입니다.<br>다시 시도해주십시오.
						
						<%
							} else {
						%>
						
						<span class="bd"><%= userid %></span>은 사용 가능합니다.
						
						<%
							}
						%>
					</td>
				</tr>
			</table>
			<p>
				<input type="button" value="확인" onclick="checkEnd()">
			</p>
		</div>
	</form>
</body>
</html>
