package movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import myutil.DBManager;
import seat.MovieSeat;
import movie.Movie;

//추가,삭제, (변경?), 반환(1개), 리스트 반환
public class MovieDAO {
	
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
	public boolean insertDB(Movie movie) {
		//DB에 유저 한명 추가
		conn = DBManager.getConnection();
		
		String sql = "insert into movie(id_film, name_film, age_phase, seat_num, movie_date)"
				+ "values(?,?,?,?,?)";
		
		try {
			System.out.println(movie);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movie.getId_film());
			pstmt.setString(2, movie.getName_film());
			pstmt.setInt(3, movie.getAge_phase());
			pstmt.setInt(4, movie.getSeat_num());
			pstmt.setString(5, movie.getMovie_date());
			pstmt.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		System.out.println("insertDB성공");
		return true;
	}
	
	public boolean deleteDB(int ins_id_film) {
		conn = DBManager.getConnection();
		
		String sql = "delete from movie where id_film=?";
		
		try{ 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_film);
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
	
	public boolean updateDB(Movie movie) {
		conn = DBManager.getConnection();
		
		String sql = "upmovie_date movie set name_film=?, age_phase=?, seat_num=?, movie_date=? where name_film = ?";
			
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie.getName_film());
			pstmt.setInt(2, movie.getAge_phase());
			pstmt.setInt(3, movie.getSeat_num());
			pstmt.setString(4, movie.getMovie_date());
			pstmt.setString(5, movie.getName_film());
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	} //upmovie_date
	public Movie getDB(int ins_id_film) {
		conn = DBManager.getConnection();
		
		String sql = "select * from movie where id_film=?";
		Movie movie = new Movie();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_film);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				movie.setId_film(rs.getInt("id_film"));
				movie.setName_film(rs.getString("name_film"));
				movie.setAge_phase(rs.getInt("age_phase"));
				movie.setSeat_num(rs.getInt("seat_num"));
				movie.setMovie_date(rs.getString("movie_date"));
				rs.close();
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return movie;
	}
	
	public ArrayList<Movie> getDBList() {
		conn = DBManager.getConnection();
		ArrayList<Movie> list = new ArrayList<Movie>();
		
		String sql = "select * from movie order by id_film";
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Movie movie = new Movie();
				movie.setId_film(rs.getInt("id_film"));
				movie.setName_film(rs.getString("name_film"));
				movie.setAge_phase(rs.getInt("age_phase"));
				movie.setSeat_num(rs.getInt("seat_num"));
				movie.setMovie_date(rs.getString("movie_date"));
				list.add(movie);
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
	/////나머지 함수들 	
	public int getLastId() {
		conn = DBManager.getConnection();
		
		String sql = "select max(id_film) as max_num from movie";
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
