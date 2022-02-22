package dto;

import java.sql.Date;

public class ComplainReplyDTO {

	int num;
	int root_num;
	String id;
	String complain_reply;
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
	public String getComplain_reply() {
		return complain_reply;
	}
	public void setComplain_reply(String complain_reply) {
		this.complain_reply = complain_reply;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
	
}
