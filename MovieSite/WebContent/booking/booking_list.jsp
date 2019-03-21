<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" type="java.util.ArrayList<booking.MovieBooking>" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	function myPay(myValue) {
		var frm = document.myForm;
		frm.id_resv.value = myValue;
		frm.action.value = 'payment_ready';
		frm.submit();
	}
	function myCancel(myValue) {
		var frm = document.myForm;
		frm.id_resv.value = myValue;
		frm.action.value = 'delete';
		frm.submit();
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>결제 페이지</title>
</head>
<body>
<mytag:logout /> <a href="/movie/movie_control.jsp?action=list">영화 선택 화면으로 돌아가기</a>

<form name="myForm" method="post" action="/booking/booking_control.jsp" >
	<input type="hidden" name="action">
	<input type="hidden" name="id_resv">
	
	<table border="1">
		<tr>
		<th>영화 제목</th> <th>상영 기간</th> <th>예약일</th> <th>좌석 번호</th> <th>예약 상황</th> <th>결제 및 취소</th>
		</tr>
		
		<c:forEach var="i" items="${list}" >
		<tr>
		<td>${i.film_name}</td>
		<td>${i.movie_date}</td>
		<td>${i.resv_date }</td>
		<td>${i.seat_no}</td>
		<td>${i.status}</td>
		<c:choose >
		<c:when test="${i.status != 'ok' }">
		<td><input type="button" value="결제" OnClick="myPay(${i.id_resv})" ></td>
		</c:when>
		<c:when test="${i.status == 'ok' }">
		<td>결제 완료</td>
		</c:when>
		</c:choose> 
		<td><input type="button" value="삭제" OnClick="myCancel(${i.id_resv})" ></td>
		</tr>
		</c:forEach>
		
		
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
	
	</table>

</form>

</body>
</html>