<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="request" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
</head>
<body>

<center>

<form name="myForm" method="post" action="/user/user_control.jsp">
<input type="hidden" name="action" value="register">
<table border="1">
<tr> <th>ID</th> <td><input type="text" style="IME-MODE: disabled" name="name_mem" required ></td> </tr> 
<tr> <th>비밀번호</th> <td><input type="password" name="password" required></td></tr>
<tr> <th>비밀번호 확인</th> <td><input type="password" name="password_re" required></td></tr>
<tr> <th>나이</th> <td><input type="text" name="age_mem" required></td></tr>
<tr> <td><input type="submit" value="가입"></td> <td><input type="reset" value="초기화" ></td></tr>
</table>
</form>

</center>

</body>
</html>