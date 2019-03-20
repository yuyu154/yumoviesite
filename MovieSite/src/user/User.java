package user;

import java.sql.Date;

public class User {
	
	private int id_mem;
	private String password;
	private String name_mem;
	private int age_mem;
	private Date register_date;
	
	public int getId_mem() {
		return id_mem;
	}
	public void setId_mem(int id_mem) {
		this.id_mem = id_mem;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName_mem() {
		return name_mem;
	}
	public void setName_mem(String name_mem) {
		this.name_mem = name_mem;
	}
	public int getAge_mem() {
		return age_mem;
	}
	public void setAge_mem(int age_mem) {
		this.age_mem = age_mem;
	}
	public Date getRegister_date() {
		return register_date;
	}
	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}
	@Override
	public String toString() {
		return "User [id_mem=" + id_mem + ", password=" + password + ", name_mem=" + name_mem + ", age_mem=" + age_mem
				+ ", register_date=" + register_date + "]";
	}
}
