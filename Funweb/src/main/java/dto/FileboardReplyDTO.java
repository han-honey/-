package dto;

import java.sql.Date;

public class FileboardReplyDTO {
	int num, root_num;
	String id, fileboard_reply;
	Date date;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	public int getRoot_num() {
		return root_num;
	}
	public void setRoot_num(int root_num) {
		this.root_num = root_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileboard_reply() {
		return fileboard_reply;
	}
	public void setFileboard_reply(String fileboard_reply) {
		this.fileboard_reply = fileboard_reply;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	

}
