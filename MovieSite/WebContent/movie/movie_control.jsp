<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, movie.Movie"%>
<% request.setCharacterEncoding("UTF-8"); %>
    
<jsp:useBean id="movie" class="movie.Movie" scope="request"/>
<jsp:useBean id="movieDAO" class="movie.MovieDAO" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" type="java.util.ArrayList<movie.Movie>"/>
<jsp:setProperty name="movie" property="*" />

<jsp:useBean id="ms_set" class="seat.MovieSeatSet" scope="request" />
<jsp:useBean id="msDAO" class="seat.MovieSeatDAO" />
<jsp:setProperty name="ms_set" property="*" />

<%
	String action = request.getParameter("action");					//parameter (get)
	boolean isLogin = (session.getAttribute("name_mem") != null);	
	boolean isAdmin = (session.getAttribute("admin_login") != null);

		if(action.equals("list")) {
			
			request.setAttribute("list", movieDAO.getDBList());
			pageContext.forward("/movie/movie_list.jsp");
		}
		else if(action.equals("add")) {

			ArrayList<Integer> seats = new ArrayList<Integer>();
			String movie_date1 = request.getParameter("movie_date1");
			String movie_date2 = request.getParameter("movie_date2");
			//1.movie객체
			
			movie.setId_film(movieDAO.getLastId());
			movie.setMovie_date(movie_date1+"~"+movie_date2);
			
			//2.seatSet Object
			ms_set.setId_film(movie.getId_film());
			ms_set.setId_seat(msDAO.getLastId());
			
			for(int i=0; i<9; i++) {
				seats.add(new Integer(1));
			}
			ms_set.setSeats(seats);
			
			
			movieDAO.insertDB(movie);
			msDAO.insertDB(ms_set);
			
			pageContext.forward("/movie/movie_control.jsp?action=admin_list");
		}
		else if(action.equals("admin_list")) {
			//admin_list만들고
			//System.out.println("무비 컨트롤의 admin_list");
			list = movieDAO.getDBList();
			request.setAttribute("list", list);
			//System.out.println(list);
			pageContext.forward("/admin/admin_movie_manage.jsp");
		}
		else if(action.equals("delete")) {

			int id_film = Integer.parseInt(request.getParameter("id_film"));
			movieDAO.deleteDB(id_film);
			//포워딩
			pageContext.forward("/movie/movie_control.jsp?action=admin_list");
		}
	
%>
	

