<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="movie.Movie,java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<!DOCTYPE html >
<html>
<head>
<script>
	function mySubmit(myValue) {
		document.myForm.id_film.value = myValue;
		document.myForm.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<mytag:logout />

<a href="/admin/admin_movie_add.jsp">Insert film</a> <a href="/user/user_control.jsp?action=list">Member management</a>
<HR>
<div>
<form name="myForm" method="post" action="/movie/movie_control.jsp" >
<input type="hidden" name="action" value="delete">
<input type="hidden" name="id_film" >
<table border="1">
<tr><th>제목</th> <th>이용가</th> <th>좌석 수</th> <th>개봉 기간</th> <th>Operation</th> </tr>
<c:forEach var="i" items="${list}">
<tr> 
	<td>${i.name_film}</td> 
	<td>${i.age_phase}세 이용가</td> 
	<td>${i.seat_num}</td> 
	<td>${i.movie_date}</td> 
	<td><input type="button" value="Remove" OnClick="mySubmit(${i.id_film})"></td>
</tr>
</c:forEach>
</table>
</form>
</div>

</body>
</html>