<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<script>
	function mySubmit() {
		var frm = document.myForm;
		frm.action.value = 'payment';
		frm.submit();
	}
	function myCancel() {
		var frm = document.myForm;
		frm.action.value = 'list';
		frm.submit();
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>
<mytag:logout />


<H2>카드 결제</H2>

<form name="myForm" method="post" action="booking_control.jsp" >
<input type="hidden" name="action"> 
<table border="1">

<tr>
<th>카드 번호</th>
<td><input type="text" name="c1" maxlength="4"  size="1"required>-
<input type="text" name="c2" maxlength="4" size="1" required>-
<input type="text" name="c3" maxlength="4" size="1" required>-
<input type="text" name="c4" maxlength="4" size="1" required></td>
</tr>

<tr>
<th>유효 날짜</th> 
<td>
<select name="month" size="1" required>
	<option>1</option>
	<option>2</option>
	<option>3</option>
	<option>4</option>
	<option>5</option>
	<option>6</option>
	<option>7</option>
	<option>8</option>
	<option>9</option>
	<option>10</option>
	<option>11</option>
	<option>12</option>
</select > 
<select name="year" size="1" required>
	<option>2017</option>
	<option>2018</option>
	<option>2019</option>
	<option>2020</option>
	<option>2021</option>
	<option>2022</option>
	<option>2023</option>
</select>
</td>

</tr>
<tr><th>cvc 번호</th> <td><input type="password" size="3" maxlength="3" required></td></tr>
<tr><td><input type="button" value="제출" OnClick="mySubmit()"></td> <td><input type="button" value="취소" OnClick="myCancel()"></td> </tr>
</table>
</form>

</body>
</html>