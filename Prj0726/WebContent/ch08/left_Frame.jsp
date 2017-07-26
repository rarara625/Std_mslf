<%@ page info="left_Frame" errorPage="error.jsp" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
		<!-- 
			function login_check() {
				if (!document.login.userid.value) {
					alert("ID를 입력하세요!");
					document.login.userid.focus();
					return;
				}
				
				if (!document.login.password.value) {
					alert("패스워드를 입력하세요!");
					document.login.password.focus();
					return;
				}
				document.login.submit();
			} 
		//-->
	</script>
	<style type="text/css">
		body {
			margin: 0;
		}
		div#container {
			width: 30%;
		}
		
		hr {
			height: 8px;
			margin: 15px 0;
		}
		
		hr#top {
			background: #006400;
		}
		
		hr#bottom {
			background: #8B6331;
		}
		
		div#wrapper {
			display: table;
			margin: 0 auto;
		}
		
		p {
			text-align: center;
		}
		
		p a {
			text-decoration: none;
			font-weight: bold;
			color: black;
			margin: 5px;
			padding: 5px 5px;
		}
		
	</style>
	<title>로그인 창과 메뉴</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		Object mem_name = session.getAttribute("member_name");
		Object mem_id = session.getAttribute("member_id");
		
		session.setAttribute("member_id", mem_id);
		if (session.getValue("member_id") == null) {	// 기로그인 정보가 없으면
	%>

	<form name="login" method="post" action="login_process.jsp">
		<div id="container">
			<hr id="top">
				<div id="wrapper">
					<table>
						<tr>
							<td>회원ID</td>
							<td>
								<input type="text" name="userid" size="10" maxlength="16">
							</td>
						</tr>
						<tr>
							<td>PASS</td>
							<td>
								<input type="password" name="password" size="10" maxlength="12">
							</td>
						</tr>
					</table>
				</div>
			<hr id="bottom">
			<p>
				<a href="javascript:login_check()">로그인</a>
				<a href="insert.html" target="_top">회원가입</a>
			</p>
		</div>
	</form>
	
	<% } else {	%>
	<div id="container">
		<div id="wrapper">
			<table>
				<tr>
					<td>
						<p><%= mem_name %>님<br>환영합니다.</p>
					</td>
				</tr>
			</table>
		</div>
		<p>
			<a href="logout.jsp">로그아웃</a>
			<a href="select.jsp" target="mainframe">개인정보조회</a>
			<a href="admin.jsp" target="mainframe">전체목록보기</a>
		</p>
	</div>
	<% } %>
</body>
</html>