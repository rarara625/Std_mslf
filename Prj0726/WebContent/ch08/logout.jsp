<%@ page info="logout" errorPage="error.jsp" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
		<!--
			parent.location.href="left_Frame.jsp"
		//-->
	</script>
	<title>로그아웃 처리</title>
</head>
<body>
	<%
		session = request.getSession(false);
		session.invalidate();
	%>
</body>
</html>
