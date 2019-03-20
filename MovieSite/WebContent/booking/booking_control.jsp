<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    
<jsp:useBean id="mb" class="booking.MovieBooking" />
<jsp:setProperty name="mb" property="*" />
<jsp:useBean id="mbDAO" class="booking.MovieBookingDAO" />

<jsp:useBean id="movie" class="movie.Movie" />
<jsp:useBean id="movieDAO" class="movie.MovieDAO" />

<jsp:useBean id="user" class="user.User" />
<jsp:useBean id="userDAO" class="user.UserDAO" />
<jsp:useBean id="list" class="java.util.ArrayList<booking.MovieBooking>" scope="request" />

<jsp:useBean id="msDAO" class="seat.MovieSeatDAO" />

<%
	String action = request.getParameter("action");
	boolean isLogin = (session.getAttribute("name_mem") != null);
	//로그인. 나중에 구현. 구현하면 지울것!!
	
	
	if(action.equals("create")) {
		//1.예약 정보 DB생성 

		//preprocess
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		int id_film = (Integer)session.getAttribute("id_film");
	    String name_mem = (String)session.getAttribute("name_mem");
		int seat_no = (Integer)request.getAttribute("seat_no");
		
	    //객체 생성
	    movie = movieDAO.getDB(id_film);
	    user = userDAO.getDB(name_mem);

	    //최종객체 생성
	    mb.setId_resv(mbDAO.getLastId());
	    mb.setId_mem(user.getId_mem());
	    mb.setId_film(movie.getId_film());
	    mb.setFilm_name(movie.getName_film());
	    mb.setMovie_date(movie.getMovie_date());
	    mb.setResv_date(sqlDate);
	    mb.setSeat_no(seat_no);
	    mb.setStatus("-");
	    
	    //DB에 삽입.
	    mbDAO.insertBook(mb);
		//2.예약 id seesion에 설정
		//session.setAttribute("id_resv", id_resv);
		pageContext.forward("/booking/booking_control.jsp?action=list");
	}
	
	if(action.equals("list")) {
		//name_mem으로 만들어낸 id_mem을 통해 리스트를 불러온다. 
		
		String name_mem = (String)session.getAttribute("name_mem");
		user = userDAO.getDB(name_mem);
		
		list = mbDAO.getUserList(user.getId_mem());

		request.setAttribute("list", list);
		pageContext.forward("/booing/booking_list.jsp");
	}
	
	if(action.equals("delete")) {
		
		int id_resv = mb.getId_resv();
		mb = mbDAO.getDB(id_resv);
		int id_film = mb.getId_film();
		
		msDAO.set1(mb.getSeat_no(), id_film);
		mbDAO.deleteBook(id_resv);

		pageContext.forward("/booking/booking_control.jsp?action=list");
	}
	
	//key: id_resv를 어떻게 보낼지.
	if(action.equals("payment_ready")) {

		int id_resv = Integer.parseInt(request.getParameter("id_resv"));
		
		session.setAttribute("id_resv", id_resv);	//세션에 넣어버리기
		pageContext.forward("/payment/payment.jsp");
	}
	if(action.equals("payment")) {

		int id_resv = (Integer)session.getAttribute("id_resv");
		mbDAO.updateStatus(id_resv);
		pageContext.forward("/booking/booking_control.jsp?action=list");
	}
	
%>