<%@ page info="Error Page" isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type">
	<style type="text/css">
		body {
			background: #ffffff;
			color: #000000;
		}
		
		div#container {
			display: table;
			margin: 0 auto;
		}
		
		table {
			width: 60%;
			border: 1px solid black;
		}
		
		tr, th, td {
			border: 1px solid black;
		}
		
		tr th {
			column-span: 2;
			background: #ccccff;
			height: 25px;
		}
		
		tr td {
			padding: 10px;
		}
	</style>
	<title>Error Page</title>
</head>
<body>
	<div id="container">
		<table>
			<tr>
				<th>에러(ERROR)</th>
			</tr>
			<tr>
				<td>시스템에 문제가 발생하였습니다. 잠시후 다시 이용해 주세요.</td>
				<td>에러내용 : <%= exception.getMessage() %></td>
			</tr>
		</table>
	</div>
</body>
</html>
