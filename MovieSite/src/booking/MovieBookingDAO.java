package booking;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import myutil.DBManager;
import user.User;
import movie.Movie;
//추가, 삭제, 변경(status), list는 list인데 사용자 아이디(id)로 결정되서 나오는 list.
public class MovieBookingDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	private void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//삽임 메소드
	public boolean insertBook(MovieBooking mb) {
		//DB에 유저 예약정보 추가
		//Movie와 MovieSeat정보를 이용해 터플 하나 만들기
		conn = DBManager.getConnection();
		
		String sql = "insert into moviebooking(id_resv, id_mem, id_film, name_film, movie_date, resv_date, seat_no, status)"
				+ "values(?,?,?,?,?,?,?,?)";
		/*
		 * id_resv = 고유
		 * id_mem = User
		 * id_film = movie
		 * name_film = movie
		 * movie_date = movie
		 * resv_date = 오늘 날짜
		 * seat_no = seat_num
		 * status = -
		 */
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mb.getId_resv());
			pstmt.setInt(2, mb.getId_mem());
			pstmt.setInt(3, mb.getId_film());
			pstmt.setString(4, mb.getFilm_name());
			pstmt.setString(5, mb.getMovie_date());
			pstmt.setDate(6, mb.getResv_date());	
			pstmt.setInt(7, mb.getSeat_no());
			pstmt.setString(8, mb.getStatus());
			//아직 결제 안한 상태
			pstmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	public boolean deleteDB(int ins_id_resv) {
		conn = DBManager.getConnection();
		
		//취소를 누르면 하나 삭제.
		String sql = "delete from moviebooking where id_resv=?";
		
		try{ 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_resv);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}	
	//삭제 메소드
	public boolean deleteBook(int ins_id_resv) {
		conn = DBManager.getConnection();
		
		String sql = "delete from moviebooking where id_resv=?";
		
		try{ 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_resv);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	//update도 하나 필요.
	//결제 완료하면 status를 ok로 변경해야함..
	public boolean updateStatus(int ins_id_resv) {
		conn = DBManager.getConnection();
		
		String sql = "update moviebooking set status=? where id_resv = ?";
			
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "ok");
			pstmt.setInt(2, ins_id_resv);
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	} 
	//User의 아이디로 예약정보를 모두 조회할 수 있다...
	public ArrayList<MovieBooking> getUserList(int ins_id_mem) {
		conn = DBManager.getConnection();
		ArrayList<MovieBooking> list = new ArrayList<MovieBooking>();
		
		String sql = "select * from moviebooking where id_mem = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_mem);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieBooking mb = new MovieBooking();
				mb.setId_resv(rs.getInt("id_resv"));
				mb.setId_film(rs.getInt("id_film"));
				mb.setId_mem(rs.getInt("id_mem"));
				mb.setFilm_name(rs.getString("name_film"));
				mb.setResv_date(rs.getDate("resv_date"));
				mb.setMovie_date(rs.getString("movie_date"));
				mb.setSeat_no(rs.getInt("seat_no"));
				mb.setStatus(rs.getString("status"));
				list.add(mb);
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}	
		return list;	
	}
	
	public MovieBooking getDB(int ins_id_resv) {
		conn = DBManager.getConnection();
		
		String sql = "select * from moviebooking where id_resv=?";
		MovieBooking mr = new MovieBooking();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_resv);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//입력한다음.
				mr.setId_resv(rs.getInt("id_resv"));
				mr.setId_film(rs.getInt("id_film"));
				mr.setId_mem(rs.getInt("id_mem"));
				mr.setFilm_name(rs.getString("name_film"));
				mr.setResv_date(rs.getDate("resv_date"));
				mr.setMovie_date(rs.getString("movie_date"));
				mr.setSeat_no(rs.getInt("seat_no"));
				mr.setStatus(rs.getString("status"));
				rs.close();
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		System.out.println(mr);
		return mr;
	}//하나 출력.
	public ArrayList<MovieBooking> getDBList() {
		conn = DBManager.getConnection();
		ArrayList<MovieBooking> list = new ArrayList<MovieBooking>();
		
		String sql = "select * from moviebooking order by id_resv";
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieBooking mr = new MovieBooking();
				mr.setId_resv(rs.getInt("id_resv"));
				mr.setId_film(rs.getInt("id_film"));
				mr.setId_mem(rs.getInt("id_mem"));
				mr.setFilm_name(rs.getString("name_film"));
				mr.setResv_date(rs.getDate("resv_date"));
				mr.setMovie_date(rs.getString("movie_date"));
				mr.setSeat_no(rs.getInt("seat_no"));
				mr.setStatus(rs.getString("status"));
				list.add(mr);
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return list;
	}//모든 리스트 출력
	public int getLastId() {
		conn = DBManager.getConnection();
		
		String sql = "select max(id_resv) as max_num from moviebooking";
		int max_num;
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			max_num = rs.getInt("max_num");
			System.out.println("max_num=" + max_num );
			
			if(max_num == 0) {
				max_num = 1;
			}
			else {
				max_num = max_num + 1;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			disconnect();
		}
		return max_num;
	}
}
