<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="mytag" tagdir="/WEB-INF/tags" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<mytag:logout />

<a href="/movie/movie_control.jsp?action=admin_list">Back</a> <a href="/user/user_control.jsp?action=list">Member management</a>
<HR>
<form name="myForm" method="post" action="movie_control.jsp">
<input type="hidden" name="action" value="add">
<table border="1">
<tr> <th>제목</th> <td><input type="text" name="name_film" required ></td> </tr> 
<tr> 
<th>관람가</th> 
<td>
<select name="age_phase" required>
	<option>0</option>
	<option>12</option>
	<option>15</option>
	<option>18</option>
</select>
</td>
</tr>
<tr> <th>좌석 수</th> <td><input type="text" name="seat_num" value="9" readonly required></td></tr>
<tr> <th>상영 기간</th> <td><input type="date" name="movie_date1" required></td>-<td><input type="date" name="movie_date2" required></td></tr>

<tr> <td><input type="submit" value="추가"></td> <td><input type="reset" value="초기화" ></td></tr>
</table>
</form>


</body>
</html>