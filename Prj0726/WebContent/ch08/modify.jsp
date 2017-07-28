<%@ page info="member modify" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" import="java.sql.*, java.io.*, java.net.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type">
	<script type="text/javascript">
		/* function MM.openBrWindow(theURL, winName, features) {
			window.open(theURL, winName, features);
		} */
		
		function doSubmit() {
			form = document.join;
			if(!form.username.value) {
				alert('이름을 입력하지 않았습니다.');
				form.username.focus();
				return;
			}
			
			if(!form.useremail.value) {
				alert('Email을 입력하지 않았습니다.');
				form.useremail.focus();
				return;
			}
			
			/* if(form.useremail.value.indexOf("@") < 0) {
				alert('Email 주소 형식이 틀립니다.');
				form.useremail.focus();
				return;
			}
			
			if(form.useremail.value.indexOf(".") < 0) {
				alert("Email 도메인 주소가 틀립니다.");
				form.useremail.focus();
				return;
			} */
			
			if(!form.postNo1.value || !form.postNo2.value) {
				alert('우편번호를 입력하지 않았습니다.');
				MM_openBrWindow('zipcode_search.jsp', 'zipcode_search', 'scrollbars = yes, width=500, height=250');
				return;
			}
			
			if(!form.address1.value) {
				alert('주소를 입력하지 않았습니다.');
				MM_openBrWindow('zipcode_search.jsp', 'zipcode_search', 'scrollbars = yes, width=500, height=250');
				return;
			}
			
			if(!form.address2.value) {
				alert('나머지 주소를 입력하지 않았습니다.');
				form.address2.focus();
				return;
			}
			
			form.submit();
		}
	</script>
	<style type="text/css">
		body {
			background: #ffffff;
			color: #000000;
		}
		
		div#container {
			display: table;
			margin: 0 auto;
			width: 80%;
		}
		
		hr {
			width: 100%;
			height: 8px;
			margin: 20px 0;
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
		
		table {
			border-collapse: collapse;
		}
		
		table, tr, td {
			border: 1px solid gray;
		}
		
		tr, td {
			padding: 10px;
		}
		
		span.red {
			color: red;
		}
		
		small.blue {
			color: blue;
		}
		
		p {
			text-align: center;
		}
		
		p input {
			margin: 5px;
		}
	</style>
	<title>** 회원정보 수정 **</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		String mode = request.getParameter("mode");
		String userid = request.getParameter("userid");
		String username = request.getParameter("username");
		String password = request.getParameter("userpw");
		String securitynum1 = request.getParameter("secureNo1");
		String securitynum2 = request.getParameter("secureNo2");
		String email = request.getParameter("useremail");
		String zipcode1 = request.getParameter("postNo1");
		String zipcode2 = request.getParameter("postNo2");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String phone1 = request.getParameter("phone1");		
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		
		String securitynum = new String();
		String query = new String();
		String selected = new String();
		
		StringTokenizer st_securitynum = null;
		StringTokenizer st_zipcode = null;
		StringTokenizer st_phone = null;
		
		java.util.Date yymmdd = new java.util.Date();
		SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
		String regdate = myformat.format(yymmdd);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			out.println(e);
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "1234");
			stmt = conn.createStatement();
			
			if(mode.equals("null") || mode.equals("modify")) {
				query = "select * from member where userid='" + userid + "'";
				rs = stmt.executeQuery(query);
				
				if(rs.next()) {
					username = rs.getString("username");
					password = rs.getString("password");					
					
					st_securitynum = new StringTokenizer(rs.getString("securitynum"), " - ");
					email = rs.getString("email");
					st_zipcode = new StringTokenizer(rs.getString("zipcode"), " - ");
					address1 = rs.getString("address1");
					address2 = rs.getString("address2");
					st_phone = new StringTokenizer(rs.getString("phone"), " - ");
					
					if(st_securitynum.hasMoreTokens()) {
						securitynum1 = st_securitynum.nextToken();
					}
					
					if(st_securitynum.hasMoreTokens()) {
						securitynum2 = st_securitynum.nextToken();
					}
					
					if(st_zipcode.hasMoreTokens()) {
						zipcode1 = st_zipcode.nextToken();
					}
					
					if(st_zipcode.hasMoreTokens()) {
						zipcode2 = st_zipcode.nextToken();
					}
					
					if(st_phone.hasMoreTokens()) {
						phone1 = st_phone.nextToken();
					}
					
					if(st_phone.hasMoreTokens()) {
						phone2 = st_phone.nextToken();
					}

					if(st_phone.hasMoreTokens()) {
						phone3 = st_phone.nextToken();
					}
				}
				rs.close();
				mode = "update";				
			} else if(mode.equals("update")) {
				query = "update member set username=?, password=?, email=?, zipcode=?," +
						"address1=? address2=?, phone=? where userid='" + userid + "'";
				
				pstmt = conn.prepareStatement(query);
				
				pstmt.setString(1, userid);
				pstmt.setString(2, password);
				pstmt.setString(3, email);
				pstmt.setString(4, zipcode1 + " - " + zipcode2);
				pstmt.setString(5, address1);
				pstmt.setString(6, address2);
				pstmt.setString(7, phone1 + " - " + phone2 + " - " + phone3);
				
				pstmt.executeUpdate();
				response.sendRedirect("left_Frame.jsp");
			}
		} catch(SQLException e) {
		} finally {
			conn.close();
		}
	%>
	
	<form name="join" method="post" action="modify.jsp">
		<div id="container">
			<hr id="top">
				<div id="wrapper">
					<table>
						<tr>
							<td><span class="red">*</span> 아이디</td>
							<td>
								<input type="text" name="userid" size="10" maxlength="10" value="<%= userid %>" readonly="readonly">
								<!-- <input type="button" name="userid_check" value="중복확인" onclick="MM_openBrWindow('userid_check.jsp', 'userid_check', 'width=330, height=200')">
								<span class="note">(영문+숫자 5~16자리)<small class="blue"> 중복 확인 절차를 거쳐야 합니다.</small></span> -->
							</td>
						</tr>
						<tr>
							<td><span class="red">*</span> 비밀번호</td>
							<td>
								<input type="password" name="userpw" size="16" maxlength="16" value="<%= password %>">
								&nbsp;다시한번
								<input type="password" name="userpw_check" size="16" maxlength="16" value="<%= password %>">
								<span>(영문+숫자 5~16자리)</span>
							</td>
						</tr>
						<tr>
							<td><span class="red">*</span> 이름</td>
							<td>
								<input type="text" name="username" size="10" maxlength="10" value="<%= username %>">
							</td>
						</tr>
						<tr>
							<td><span class="red">*</span> 주민등록번호</td>
							<td>
								<input type="text" size="6" maxlength="6" name="secureNo1" value="<%= securitynum1 %>" readonly="readonly"> - 
								<input type="text" size="7" maxlength="7" name="secureNo2" value="<%= securitynum2 %>" readonly="readonly">
								<!-- <input type="button" name="secureNo_check" value="중복확인" onclick="MM_openBrWindow('securitynum_check.jsp', 'securitynum_check', 'width=330, height=150')">
								<span class="note"><small class="blue"> 중복 확인 절차를 거쳐야 합니다.</small></span> -->
							</td>
						</tr>
						<tr>
							<td><span class="red">*</span> E-mail</td>
							<td>
								<input type="email" name="useremail" size="20" maxlength="50" value="<%= email %>">
							</td>
						</tr>
						<tr>
							<td><span class="red">*</span> 우편번호</td>
							<td>
								<input type="text" size="3" maxlength="3" name="postNo1" value="<%= zipcode1 %>"> - 
								<input type="text" size="3" maxlength="3" name="postNo2" value="<%= zipcode2 %>">
								<input type="button" name="zipcode_search" value="우편번호 검색" onclick="window.open('zipcode_search.jsp', 'zipcode_search', 'scrollbars=yes, width=500, height=250')">
								<span class="note"><small class="blue"> 우편번호 검색 버튼을 누르세요.</small></span>
							</td>
						</tr>
						<tr>
							<td><span class="red">*</span> 주소</td>
							<td>
								<input type="text" name="address1" size="50" maxlength="100" readonly="readonly" value="<%= address1 %>">
							</td>
						</tr>
						<tr>
							<td><span class="red">*</span> 나머지 주소</td>
							<td>
								<input type="text" name="address2" size="50" maxlength="100" value="<%= address2 %>">
								<span class="note"><small class="blue"> 나머지 주소를 적어넣습니다.</small></span>
							</td>
						</tr>
						<tr>
							<td>휴대전화 번호</td>
							<td>
								<select name="phone1">
									<option value="<%= phone1 %>" selected><%= phone1 %></option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="018">017</option>
								</select>
								 - <input type="text" size="4" maxlength="4" name="phone2" <%= phone2 %>> 
								 - <input type="text" size="4" maxlength="4" name="phone3" <%= phone3 %>> 
							</td>
						</tr>
					</table>
				</div>
				<p>
					<input type="hidden" name="mode" value="update">
					<input type="button" value="등록" onclick="doSubmit()">
					<input type="button" value="취소" onclick="javascript:history.go(-1);">
				</p>
			<hr id="bottom">
			<address>
				<p>Copyright by JSP STUDY</p>
			</address>
		</div>
	</form>
</body>
</html>
