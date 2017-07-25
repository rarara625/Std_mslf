<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		String id = request.getParameter("id");
		int password = Integer.parseInt(request.getParameter("password"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		String sql = null;
		Connection conn = null;
		Statement st = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		int cnt = 0;
		
		// jdbc-odbc driver 등록
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e.getMessage());
		}
		
		// db 연결
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gboard", "root", "1234");
			st = conn.createStatement();
			rs = st.executeQuery("select * from woori where id= '" + id + "'");	// 기생성된 아이디 유무 확인
			

		
			if(!(rs.next())) {
				sql = "insert into woori values(?, ?, ?, ?)";
				
				// Statement 객체 생성
				/* st = conn.createStatement();
				sql = "insert into woori(id, password, name, email)";
				sql += " values('" + id + "', " + password + ", ";
				sql += "'" + name + "', '" + email + "')"; */
				pst = conn.prepareStatement(sql);
				
				pst.setString(1, id);
				pst.setString(2, name);
				pst.setString(3, email);
				pst.setInt(4, password);
				
				// insert문을 이용하여 데이터 추가
				//cnt = st.executeUpdate(sql);
				cnt = pst.executeUpdate(sql);
				if(cnt > 0) {
					out.println("데이터가 성공적으로 입력되었습니다.");
				} else {
					out.println("데이터가 입력되지 않았습니다.");
				}
			} else {
				out.println("id가 이미 등록되어 있습니다.");
			}
			
			pst.close();
			st.close();
			conn.close();
		} catch(SQLException e) {
			out.println(e.getMessage());
		}
	%>
	
	[<a href="main.html">main으로</a>]&nbsp;[<a href="insert.html">회원 등록 페이지로</a>]
</body>
</html>