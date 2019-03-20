package movie;

import java.util.Date;

public class Movie {
	private int id_film;
	private String name_film;
	private int age_phase;
	private int seat_num;
	private String movie_date;	//Date를 두개의 Date객체로 분리
	
	public int getId_film() {
		return id_film;
	}
	public void setId_film(int id_film) {
		this.id_film = id_film;
	}
	public String getName_film() {
		return name_film;
	}
	public void setName_film(String name_film) {
		this.name_film = name_film;
	}
	public int getAge_phase() {
		return age_phase;
	}
	public void setAge_phase(int age_phase) {
		this.age_phase = age_phase;
	}
	public int getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(int seat_num) {
		this.seat_num = seat_num;
	}
	public String getMovie_date() {
		return movie_date;
	}
	public void setMovie_date(String movie_date) {
		this.movie_date = movie_date;
	}
	@Override
	public String toString() {
		return "Movie [id_film=" + id_film + ", name_film=" + name_film + ", age_phase=" + age_phase + ", seat_num="
				+ seat_num + ", movie_date=" + movie_date + "]";
	}
}
