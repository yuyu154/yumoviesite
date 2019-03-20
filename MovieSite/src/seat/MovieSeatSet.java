package seat;

import java.util.ArrayList;


public class MovieSeatSet {
	private int id_seat;
	private int id_film;
	private ArrayList<Integer> seats;
	
	public int getId_seat() {
		return id_seat;
	}
	public void setId_seat(int id_seat) {
		this.id_seat = id_seat;
	}
	public int getId_film() {
		return id_film;
	}
	public void setId_film(int id_film) {
		this.id_film = id_film;
	}
	public ArrayList<Integer> getSeats() {
		return seats;
	}
	public void setSeats(ArrayList<Integer> seats) {
		this.seats = seats;
	}
	
	@Override
	public String toString() {
		return "MovieSeatSet [id_seat=" + id_seat + ", id_film=" + id_film + ", seats=" + seats + "]";
	}
}
