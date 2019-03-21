<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, movie.Movie" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<c:choose>
<c:when test="${sessionScope.name_mem != null }" >
<mytag:logout />
</c:when>
<c:when test="${sessionScope.name_mem == null}" >
</c:when>
</c:choose>


<form name="myForm" method="post" action="/seat/seat_control.jsp">
	<input type="hidden" name="action" value="seatSet" >
	<input type="hidden" name="id_film" >
	<table border="1">
		
		<tr><th>타이틀</th> <th>관람가</th> <th>총 좌석 수</th> <th>상영기간</th> <th>예매</th> </tr>
		
		<c:forEach var="i" items="${list}">
			<tr> 
			
			<td>${i.name_film}</td> 	
			<c:choose>
			<c:when test="${i.age_phase != 0}">
			<td>${i.age_phase}세 이용가</td>
			</c:when>
			<c:when test="${i.age_phase ==0}">
			<td>전체 이용가</td>
			</c:when>
			</c:choose>			
			<td>${i.seat_num}</td> 
			<td>${i.movie_date}</td> 
			
			<td><input type="button" value="선택" OnClick="mySubmit(${i.id_film})"></td> 
			</tr>
		</c:forEach>
		
	</table>
</form>
<hr>
<h3>
참고:'좌석이 꽉찬 영화'는 현재 매진된 상태임 <BR>
로그인하면 좌석이 꽉찼다고 뜸 <BR>
</h3>

</body>
</html>