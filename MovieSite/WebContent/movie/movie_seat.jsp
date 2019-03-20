<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="ms_set" class="seat.MovieSeatSet" scope="request"/>
<jsp:setProperty name="ms_set" property="*" />
    
<!DOCTYPE html>
<html>
<head>
<script>
	function mySubmit(myValue) {
		document.myForm.seat_no.value = myValue; 
		document.myForm.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<mytag:logout />

<H2>영화 '${movie.name_film} '의 예약 페이지입니다</H2>
<HR>

<form name="myForm" method="post" action="seat_control.jsp" >
<input type="hidden" name="action" value="update" >
<input type="hidden" name="seat_no" >

<table border="1">
<tr><th>좌석 번호</th> <th>좌석 현황</th> <th>예매</th> </tr>
<c:forEach var="item" items="${ms_set.seats}" varStatus="status">
<tr><td>${status.count}</td>

<c:choose> 
<c:when test="${item == 1}">
<td>이용 가능</td> 
<td><input type="button" value="예매" onClick= "mySubmit(${status.count})"></td>
</c:when>
<c:when test="${item == 0}">
<td>이용 불가</td> 
<td><input type="button" value="완료" ></td>
</c:when>
</c:choose>

</tr>
</c:forEach>

</table>
</form>
<HR>
<a href="user_change_info.jsp">회원 정보 변경</a>
</body>
</html>