<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="user" class="user.User" scope="request"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<mytag:logout />

<H2>회원정보변경</H2>
<HR>
<form name="myForm" method="post" action="user_control.jsp" > 
<input type="hidden" name="action" value="change" >
<table border="1">
<tr> <th>아이디</th> <td><input type="text" name="name_mem" value="<%=session.getAttribute("name_mem") %>" readonly></td></tr>
<tr> <th>비밀번호</th> <td><input type="password" name="password" required ></td></tr>
<tr> <th>비밀번호 확인</th> <td><input type="password" name="password_re" required></td></tr>
<tr> <th>나이</th> <td><input type="text" name="age_mem" required></td></tr>
<tr> <th><input type="submit" value="변경" /></th></tr>
</table>
</form>

</body>
</html>