package user;

import java.util.*;
import myutil.DBManager;
import java.sql.*;

public class UserDAO {
	
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
	public boolean insertDB(User user) {
		//DB에 유저 한명 추가
		conn = DBManager.getConnection();
		
		String sql = "insert into user(id_mem, name_mem, password, age_mem, register_date)"
				+ "values(?,?,?,?,?)";
		
		try {
			System.out.println(user);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user.getId_mem());
			pstmt.setString(2, user.getName_mem());
			pstmt.setString(3, user.getPassword());
			pstmt.setInt(4, user.getAge_mem());
			pstmt.setDate(5, user.getRegister_date());
			
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
	//관리자나 사용자만 회원정보를 지울 수 있음. 
	//관리자. list로 받아와서 id번호로 조회가능
	//사용자. 아이디값을 이용해 반환받아서 가능
	public boolean deleteDB(int ins_id_mem) {
		conn = DBManager.getConnection();
		
		String sql = "delete from user where id_mem=?";
		
		try{ 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ins_id_mem);
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
	public boolean deleteDB(String ins_name_mem) {
		conn = DBManager.getConnection();
		
		String sql = "delete from user where name_mem=?";
		
		try{ 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ins_name_mem);
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
	//오버로딩
	public boolean updateDB(User user) {
		conn = DBManager.getConnection();
		
		String sql = "update user set name_mem=?, password=?, age_mem=?, register_date=? where name_mem=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getName_mem());
			pstmt.setString(2, user.getPassword());
			pstmt.setInt(3, user.getAge_mem());
			pstmt.setDate(4, user.getRegister_date());
			pstmt.setString(5, user.getName_mem());
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	} //update
	public User getDB(String ins_name) {
		//아이디값으로 받아와야함.
		conn = DBManager.getConnection();
		
		String sql = "select * from user where name_mem=?";
		User user = new User();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ins_name);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user.setId_mem(rs.getInt("id_mem"));
				user.setName_mem(rs.getString("name_mem"));
				user.setPassword(rs.getString("password"));
				user.setAge_mem(rs.getInt("age_mem"));
				user.setRegister_date(rs.getDate("register_date"));
				rs.close();
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return user;
	}
	public ArrayList<User> getDBList() {
		conn = DBManager.getConnection();
		ArrayList<User> list = new ArrayList<User>();
		
		String sql = "select * from user order by id_mem";
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				
				user.setId_mem(rs.getInt("id_mem"));
				user.setName_mem(rs.getString("name_mem"));
				user.setPassword(rs.getString("password"));
				user.setAge_mem(rs.getInt("age_mem"));
				user.setRegister_date(rs.getDate("register_date"));
				list.add(user);
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
	public boolean checkID(String ins_name) {
		User user = getDB(ins_name);
		
		if(user.getName_mem() == null) {
			return false;
		}
		
		if(user.getName_mem().equals(ins_name)) {
			return true;
		}
		else
			return false;
	}
	
	public boolean login(String ins_name, String ins_password) {
		User user = getDB(ins_name);
		
		if(user.getName_mem() == null || user.getPassword() == null) {
			System.out.println("아이디,비밀번호" + ins_name + "," + ins_password );
			return false;
		}
		if(user.getName_mem().equals(ins_name) && user.getPassword().equals(ins_password)) {
			System.out.println("아이디,비밀번호" + ins_name + "," + ins_password );
			return true;
		}
		else
			return false;
		
	}
	public boolean checkAdmin(String ins_name_mem, String ins_password){
		User user = getDB(ins_name_mem);
		
		if(user.getName_mem() == null || user.getPassword() == null) {
			return false;
		}
		
		if(user.getName_mem().equals("admin") && user.getPassword().equals(ins_password)) {
			return true;
		}
		else
			return false;
		
	}
	
	public int getLastId() {
		conn = DBManager.getConnection();
		
		String sql = "select max(id_mem) as max_num from user";
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