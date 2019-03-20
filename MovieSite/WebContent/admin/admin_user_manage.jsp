<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="user.User,java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<!DOCTYPE html>
<html>
<head>
<script>
	function mySubmit(myValue) {
		document.myForm.id_mem.value = myValue;
		document.myForm.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<mytag:logout />

<a href="movie_control.jsp?action=admin_list">Back</a> <a>Member management</a>
<HR>
<form name="myForm" method="post" action="user_control.jsp" >
<input type="hidden" name="action" value="delete">
<input type="hidden" name="id_mem" >
<table border="1">
<tr>
<th>ID</th> <th>Age</th> <th>가입일</th> <th>Operation</th>
</tr>
<!-- list 받아온다음 처리 -->
<c:forEach var="i" items="${list}" >
<tr>
<td>${i.name_mem}</td>
<td>${i.age_mem}</td>
<td>${i.register_date}</td>
<td><input type="button" value="remove" OnClick="mySubmit(${i.id_mem})"> </td>
</tr>
</c:forEach>

</table>
</form>


</body>
</html>