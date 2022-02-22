package dto;

import java.sql.Date;

public class ContestReplyDTO {
	int num, root_num;
	String id, contest_reply;
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
	public String getContest_reply() {
		return contest_reply;
	}
	public void setContest_reply(String contest_reply) {
		this.contest_reply = contest_reply;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
	
}
