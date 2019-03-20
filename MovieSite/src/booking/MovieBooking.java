package booking;

import java.sql.Date;

public class MovieBooking {
	private int id_resv;
	private int id_mem;
	private int id_film;
	private String film_name;
	private String movie_date;
	private Date resv_date;
	private int seat_no;
	private String status;
	
	public int getId_resv() {
		return id_resv;
	}
	public void setId_resv(int id_resv) {
		this.id_resv = id_resv;
	}
	public int getId_mem() {
		return id_mem;
	}
	public void setId_mem(int id_mem) {
		this.id_mem = id_mem;
	}
	public int getId_film() {
		return id_film;
	}
	public void setId_film(int id_film) {
		this.id_film = id_film;
	}
	public String getFilm_name() {
		return film_name;
	}
	public void setFilm_name(String film_name) {
		this.film_name = film_name;
	}
	public String getMovie_date() {
		return movie_date;
	}
	public void setMovie_date(String movie_date) {
		this.movie_date = movie_date;
	}
	public Date getResv_date() {
		return resv_date;
	}
	public void setResv_date(Date resv_date) {
		this.resv_date = resv_date;
	}
	public int getSeat_no() {
		return seat_no;
	}
	public void setSeat_no(int seat_no) {
		this.seat_no = seat_no;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "MovieBooking [id_resv=" + id_resv + ", id_mem=" + id_mem + ", id_film=" + id_film + ", film_name="
				+ film_name + ", movie_date=" + movie_date + ", resv_date=" + resv_date + ", seat_no=" + seat_no
				+ ", status=" + status + "]";
	}
}
