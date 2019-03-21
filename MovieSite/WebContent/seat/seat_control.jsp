<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    
<jsp:useBean id="ms_set" class="seat.MovieSeatSet" scope="request"/>
<jsp:useBean id="msDAO" class="seat.MovieSeatDAO" />
<jsp:useBean id="movie" class="movie.Movie" scope="request" />
<jsp:useBean id="movieDAO" class="movie.MovieDAO" />
<jsp:useBean id="user" class="user.User" />
<jsp:useBean id="userDAO" class="user.UserDAO" />

<%
	String action = request.getParameter("action");
	boolean isLogin = (session.getAttribute("name_mem") != null);	//로그인되있음
	
	if(request.getParameter("id_film") != null) {
		
		int temp = Integer.parseInt(request.getParameter("id_film"));
		session.setAttribute("id_film",temp);
	}
	else {
		//id_film이 null이면 로그인창도 아니고 리스트 페이지도 아닌 다른데서 왔다는 뜻임.
	}
	
	String name_mem = (String)session.getAttribute("name_mem");
	int id_film = (Integer)session.getAttribute("id_film");
	user = userDAO.getDB(name_mem);
	movie = movieDAO.getDB(id_film);
	
	if(action.equals("seatSet")) {
		
		if(isLogin) {
			//if login
			ms_set = msDAO.getSeatSet(id_film);
			
			int temp_sum = 0;
			ArrayList<Integer> temp_seats = ms_set.getSeats();
			
			for(int t: temp_seats){
				temp_sum += t;
			}
			
			
			if(temp_sum == 0) {
				out.println("<script>alert('좌석이 모두 매진되었습니다'); location.replace('/movie/movie_control.jsp?action=list') </script>");
			}
			else if(movie.getAge_phase() > user.getAge_mem() ) {
				out.println("<script>alert('회원분의 나이가 관람가보다 어립니다'); location.replace('/movie/movie_control.jsp?action=list') </script>");
			}
			else {	//seat을 위한 정상 처리 값.
				session.setAttribute("id_seat", ms_set.getId_seat());
				request.setAttribute("ms_set", ms_set);
				request.setAttribute("movie", movie);
				pageContext.forward("/movie/movie_seat.jsp");
			}
		}
		else {
			//로그인 안했으면
			pageContext.forward("/user/user_login.jsp");
		}
  	}
	
	if(action.equals("update")) {
		//좌석의 값을 업데이트해야됨.

		int seat_no = Integer.parseInt(request.getParameter("seat_no"));
		msDAO.set0(seat_no, id_film);
		request.setAttribute("seat_no", seat_no);
		
		pageContext.forward("/booking/booking_control.jsp?action=create"); //영화 예약 결제 페이지로 이동
	}

%>