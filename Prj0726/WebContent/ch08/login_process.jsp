<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.text.*, java.net.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>로그인 처리 페이지</title>
</head>
<body>
	<%
		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = new String();
		String name = new String();
		String email = new String();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e);
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "1234");
			pstmt = conn.prepareStatement(query);
		} catch(SQLException e) {
			out.println(e);
		}
		
		boolean bLogin = false;
		try {
			query = "select * from member where userid=? and password=?";
			
			pstmt.setString(1, userid);
			pstmt.setString(2, password);

			rs = pstmt.executeQuery();          
			
			if (rs.next()) {
				name = rs.getString("username");
				email = rs.getString("email");
				bLogin = true;
			} else {
				bLogin = false;
			}
			
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			out.println(e);
		} finally {
			conn.close();
		}
		
		if (bLogin) {
			session.setAttribute("member_id", userid);
			session.setAttribute("member_name", name);
			response.sendRedirect("left_Frame.jsp");
		} else {
			out.println("<script>alert('아아디와 비밀번호를 확인하세요.'); history.back();</script>");
		}
	%>
</body>
</html>