package dto;

import java.sql.Date;
/*
CREATE TABLE file_board(
num INT PRIMARY KEY,
name VARCHAR(16) NOT NULL,
password VARCHAR(16) NOT NULL,
subject VARCHAR(100) NOT NULL,
content VARCHAR(1000) NOT NULL,
date DATETIME NOT NULL,
readcount INT NOT NULL
);
 */

public class BoardDTO {
//	+-----------+---------------+------+-----+---------+-------+
//	| Field     | Type          | Null | Key | Default | Extra |
//	+-----------+---------------+------+-----+---------+-------+
//	| num       | int           | NO   | PRI | NULL    |       |
//	| name      | varchar(16)   | NO   |     | NULL    |       |
//	| password  | varchar(16)   | NO   |     | NULL    |       |
//	| subject   | varchar(100)  | NO   |     | NULL    |       |
//	| content   | varchar(1000) | NO   |     | NULL    |       |
//	| date      | datetime      | NO   |     | NULL    |       |
//	| readcount | int           | NO   |     | NULL    |       |
//	+-----------+---------------+------+-----+---------+-------+
	// Database 컬럼들 
	private int num, readcount;
	private String name, password, subject, content;
	private Date date;
	
	// private로 선언한 변수들의 값을 컨트롤 하기 위한 Getter/Setter
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
}
