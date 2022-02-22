package dto;

import java.sql.Date;

public class MemberDTO {
//	+---------+-------------+------+-----+---------+-------+
//	| Field   | Type        | Null | Key | Default | Extra |
//	+---------+-------------+------+-----+---------+-------+
//	| id      | varchar(16) | NO   | PRI | NULL    |       |
//	| pass    | varchar(16) | NO   |     | NULL    |       |
//	| name    | varchar(20) | NO   |     | NULL    |       |
//	| date    | datetime    | NO   |     | NULL    |       |
//	| email   | varchar(50) | NO   | UNI | NULL    |       |
//	| mobile  | varchar(20) | NO   |     | NULL    |       |
//	| address | varchar(50) | YES  |     | NULL    |       |
//	| phone   | varchar(20) | YES  |     | NULL    |       |
//	+---------+-------------+------+-----+---------+-------+
	// Database 컬럼들 
	private String id, password, name, email, address, phone, mobile;
	private Date date;
	
	// private로 선언한 변수들의 값을 컨트롤 하기 위한 Getter/Setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String adress) {
		this.address = adress;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	

}
