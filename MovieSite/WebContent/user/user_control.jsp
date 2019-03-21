<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="request"/>
<jsp:useBean id="userDAO" class="user.UserDAO" />
<jsp:setProperty name="user" property="*" />

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<!--기타 빈즈  -->

<%
	System.out.println("유저_컨트롤 실행");
	String action = request.getParameter("action");
	boolean isLogin = (session.getAttribute("name_mem") != null);
	boolean isAdminLogin = (session.getAttribute("admin_login") != null);
	//user객체에 name_mem, password 전달됨.
	//id_mem,가입날짜,age= null값.
	if(action.equals("login")) {
		//request로 입력받기.
		System.out.println(user);
		String name_mem = request.getParameter("name_mem");
		String password = request.getParameter("password");
		
		if(userDAO.login(name_mem,password)) {
			System.out.println("유저 컨트롤에서 로그인작업 수행");
			user = userDAO.getDB(name_mem);		
			session.setAttribute("name_mem",user.getName_mem());	//세션에 회원 정보값 저장. 로그인 구현.
			//System.out.println("로그인 세션값:" + session.getAttribute("name_mem"));	//확인작업
			pageContext.forward("/seat/seat_control.jsp?action=seatSet");
		}
		else {
			out.println("<script>alert('로그인 불가능(아이디,비밀번호가 다릅니다)'); history.go(-1)</script>");
		}	
	}
	
	if(action.equals("register")) {
		//회원가입
		System.out.println("유저 컨트롤:회원가입 작업");
		String name = user.getName_mem();
		String password = user.getPassword();
		String password_re = request.getParameter("password_re");
		int age = user.getAge_mem();
		//int last_id = userDAO.getLastId();
		

		if(name == null || password == null || password_re == null || age == 0) {
			out.println("<script>alert('빈칸없이 모든 정보를 입력하시오'); history.go(-1) </script>");
		}
		else if(userDAO.checkID(name)) {
			out.println("<script>alert('이 아이디로 가입할 수 없음. 중복된 아이디 있음'); history.go(-1) </script>");
		}
		else if(!password.equals(password_re))  {
			out.println("<script>alert('비밀번호와 비밀번호 확인이 다릅니다'); history.go(-1) </script>");
		}
		else {
			user.setId_mem(userDAO.getLastId());
			//아이디 설정
			java.util.Date utilDate = new java.util.Date();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			user.setRegister_date(sqlDate);
			//일정 설정
			System.out.println("회원가입: 현재 user객체 상태: "+user);
			userDAO.insertDB(user);
			pageContext.forward("user_login.jsp");
		}
	}
	//회원정보변경할때 호출	
	if(action.equals("change")) {
		
		String name = request.getParameter("name_mem");
		String pwd = request.getParameter("password");
		String pwd_re = request.getParameter("password_re");
		System.out.println(user);
		int age = Integer.parseInt(request.getParameter("age_mem"));
		
		if(!pwd.equals(pwd_re)) {
			out.println("<script>alert('비밀번호와 비밀번호 확인이 다릅니다'); history.go(-1) </script>");
		}
		else {
			user = userDAO.getDB(name);
			System.out.println(user);
			user.setPassword(pwd);
			user.setAge_mem(age);
			userDAO.updateDB(user);
			pageContext.forward("seat_control.jsp?action=seatSet");
		}
	}
	//로그아웃
	if(action.equals("logout")) {
		
		if(isLogin) {
			session.setAttribute("name_mem", null);
			pageContext.forward("movie_control.jsp?action=list");
		}
		else if(isAdminLogin){
			session.setAttribute("admin_login", null);
			pageContext.forward("movie_control.jsp?action=list");
		}
	}
	//관리자 로그인
	if(action.equals("admin_login")) {
		
		System.out.println("컨트롤러의 관리자 로그인");
		System.out.println(user);
		String name_mem = request.getParameter("name_mem");
		String password = request.getParameter("password");

		if(userDAO.checkAdmin(name_mem, password)) {
			System.out.println("유저 컨트롤에서 관리자 로그인작업 수행");
			user = userDAO.getDB(name_mem);		
			session.setAttribute("admin_login",user.getName_mem());	//세션에 아이디 저장.
			System.out.println("로그인 세션값:" + session.getAttribute("name_mem"));	//확인작업
			pageContext.forward("movie_control.jsp?action=admin_list");
		}
		else {
			out.println("<script>alert('관리자가 아닙니다'); history.go(-1)</script>");
		}	
		
	}
	//관리자에서 삭제함.
	if(action.equals("delete")) {
		System.out.println("유저 컨트롤에서 관리자 삭제작업 수행");
		//admin이 회원 삭제.
		//name_mem이 매개변수형식으로 온다.
		int id_mem = Integer.parseInt(request.getParameter("id_mem"));
		//위가 오류 난 부분.
		System.out.println(id_mem);
		userDAO.deleteDB(id_mem);
		//아이디는 유일한 값이므로 가능.
		//유저 지워지면 에앾정보 지워질듯. 확인해볼것.
		System.out.println("예약정보도 지워지는지 확인");
		pageContext.forward("user_control.jsp?action=list");
	}
	//관리자에서 보여줄 유저 리스트
	if(action.equals("list")) {
		System.out.println("유저 컨트롤에서 관리자 리스트 작업 수행");
		request.setAttribute("list",userDAO.getDBList());
		System.out.println(request.getAttribute("list"));
		pageContext.forward("admin_user_manage.jsp");
	}

%>

