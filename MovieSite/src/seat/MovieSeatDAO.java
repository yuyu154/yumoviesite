package seat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import movie.Movie;
import myutil.DBManager;
//추가,삭제,업데이트,반환(1개)
public class MovieSeatDAO {

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
	//추가
	public boolean insertDB(MovieSeatSet msSet) {
		//DB에 유저 한명 추가
		conn = DBManager.getConnection();
		
		String sql = "insert into movieseat(s1, s2, s3, s4, s5, s6, s7, s8, s9, id_film, id_seat)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?)";
		
		try {
			System.out.println(msSet);
			pstmt = conn.prepareStatement(sql);
			for(int i=1; i<=9; i++) {
				pstmt.setInt(i, msSet.getSeats().get(i-1));
				//System.out.println("s"+i +"="+ msSet.getSeats().get(i-1));
			}
			pstmt.setInt(10, msSet.getId_film());
			pstmt.setInt(11, msSet.getId_seat());
			pstmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		System.out.println("좌석 입력 성공");
		return true;
	}
	//update
	public boolean updateDB(MovieSeatSet msSet) {
		conn = DBManager.getConnection();
		
		String sql = "update movieseat set s1=?, s2=?, s3=?, s4=?, s5=?, s6=?, s7=?, s8=?, s9=?, id_film=?";
			
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(10, msSet.getId_film());
			
			for(int i=1; i<=9; i++) {
				pstmt.setInt(i, msSet.getSeats().get(i-1));
				System.out.println("s"+i +"="+ msSet.getSeats().get(i-1));
			}
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
	
	public MovieSeatSet getSeatSet(int ins_id_film) {

		conn = DBManager.getConnection();
		
		String sql = "select * from movieseat where id_film=?";
		MovieSeatSet msSet = new MovieSeatSet();
		ArrayList<Integer> seats = new ArrayList<Integer>();
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_film);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				msSet.setId_film(rs.getInt("id_film"));
				msSet.setId_seat(rs.getInt("id_seat"));
				for(int i=1; i<=9; i++) {
					//배열에다 값들을 집어넣고 s1부터 s9까지..
					seats.add(rs.getInt("s"+i));
				}
				msSet.setSeats(seats);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			disconnect();
		}
		System.out.println("movieseatDAO의 msSEt값:"+msSet);
		return msSet;
	}
	// reserv -> empty
	public boolean set0(int ins_seat_no, int id_film) {
		conn = DBManager.getConnection();
		
		String sql = "update movieseat set s" + ins_seat_no + "= 0 where id_film=?";
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id_film);
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
	// empty -> reserv
	public boolean set1(int ins_seat_no, int id_film) {
		conn = DBManager.getConnection();
		
		String sql = "update movieseat set s" + ins_seat_no + "= 1 where  id_film=?";
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id_film);
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
	
	public int getLastId() {
		conn = DBManager.getConnection();
		
		String sql = "select max(id_seat) as max_num from movieseat";
		int max_num;
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			max_num = rs.getInt("max_num");
			//System.out.println("max_num=" + max_num );
			
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
