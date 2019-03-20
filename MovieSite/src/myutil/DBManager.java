package myutil;

import java.sql.*;

public class DBManager {
		
	static Connection conn = null;
	static String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	static String jdbc_url = "jdbc:mysql://localhost:3306/film_booking?useSSL=false&autoReconnect=true&useSSL=false&serverTimezone=UTC";

	public static Connection getConnection() {
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,"yse","1234");
		}
		catch (Exception e) {
			e.printStackTrace();
			return null; 
		}
			return conn;
	}
}
